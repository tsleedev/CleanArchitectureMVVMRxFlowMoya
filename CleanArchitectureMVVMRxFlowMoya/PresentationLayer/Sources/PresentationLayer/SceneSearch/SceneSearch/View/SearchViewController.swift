//
//  SearchViewController.swift
//  
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
    // MARK: - Views
    private let searchBar = UISearchBar()
    private let tableView = UITableView().then {
        $0.register(ThumbnailTableViewCell.self, forCellReuseIdentifier: ThumbnailTableViewCell.identifier)
        $0.keyboardDismissMode = .onDrag
    }
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Properties
    
    // MARK: - Initialize with ViewModel
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
        
        setupViews()
        setupConstraints()
        bindViewModel()
    }
}

// MARK: - Setup
private extension SearchViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
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
        
        output.items
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(
                cellIdentifier: ThumbnailTableViewCell.identifier,
                cellType: ThumbnailTableViewCell.self)
            ) { _, viewModel, cell in
                cell.configure(viewModel.toThumbnailItemViewModel())
            }
            .disposed(by: disposeBag)
        
        output.isLoading
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
                if let message = error.errorDescription, !message.isEmpty {
                    self?.alert(message)
                }
                TSLogger.error("\(error)")
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

#if DEBUG
// Accessors for testing purposes
extension SearchViewController {
    func getSearchBar() -> UISearchBar {
        return searchBar
    }
    
    func getTableView() -> UITableView {
        return tableView
    }
    
    func getActivityIndicatorView() -> UIActivityIndicatorView {
        return activityIndicator
    }
}
#endif
