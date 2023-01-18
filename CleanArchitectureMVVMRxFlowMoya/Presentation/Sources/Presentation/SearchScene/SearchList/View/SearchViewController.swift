//
//  SearchViewController.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/15.
//

import TSCore
import TSCoreUI
import TSLogger
import UIKit
import RxSwift
import RxSwiftExt
import SnapKit
import Then

class SearchViewController: BaseViewController {
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView().then {
        $0.register(ThumbnailCell.self, forCellReuseIdentifier: ThumbnailCell.identifier)
        $0.keyboardDismissMode = .onDrag
    }
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    private var didSetupConstraints = false
    
    private let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        bindViewModel()
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            searchBar.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
            tableView.snp.makeConstraints { make in
                make.top.equalTo(searchBar.snp.bottom)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            activityIndicator.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
}

// MARK: - Setup
private extension SearchViewController {
    func initView() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.setNeedsUpdateConstraints()
    }
    
    func bindViewModel() {
        let query = searchBar.rx.text.orEmpty.asDriver().distinctUntilChanged().debounce(.milliseconds(300))
        let didSelect = Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(SearchItemViewModel.self))
            .do(onNext: { [weak self] (indexPath, _) in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .map { $0.1 }
            .asDriver(onErrorDriveWith: .empty())
        
        let input = SearchViewModel.Input(
            query: query,
            didSelectCell: didSelect
        )
        
        tableView.rx.reachedBottom()
            .bind(to: input.loadNextPageTrigger)
            .disposed(by: disposeBag)
        
        let output = viewModel.transform(input: input)
        
        output.repos
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(
                cellIdentifier: ThumbnailCell.identifier,
                cellType: ThumbnailCell.self)
            ) { _, viewModel, cell in
                cell.bind(viewModel.convertThumbnailViewModel())
            }
            .disposed(by: disposeBag)
        
        output.fetching
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        output.page
            .drive(onNext: { [weak self] page in
                guard let self = self, page == 1 else { return }
                let indexPath = IndexPath(row: NSNotFound, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            })
            .disposed(by: disposeBag)
        
        output.error
            .drive(onNext: { [weak self] error in
                if let error = error as? APIError,
                   let message = error.errorDescription, !message.isEmpty {
                    self?.alert(message)
                }
                Log.error("\(error)")
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Helper
private extension SearchViewController {
    func alert(_ message: String) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(title: "확인", style: .cancel)
        )
        alertController.modalPresentationStyle = .fullScreen
        present(alertController, animated: true, completion: nil)
    }
}
