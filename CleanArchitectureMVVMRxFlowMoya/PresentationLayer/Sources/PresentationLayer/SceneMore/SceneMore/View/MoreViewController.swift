//  
//  MoreViewController.swift
//  
//
//  Created by TAE SU LEE on 2023/03/22.
//

import TSCoreUI
import UIKit
import SwiftUI
import RxSwift
import SnapKit

class MoreViewController: BaseViewController {
    // MARK: - Views
    private lazy var hostingView: UIView = {
        addChild(hostingController)
        hostingController.didMove(toParent: self)
        return hostingController.view
    }()
    private var rightBarButtonItem: UIBarButtonItem!
    
    // MARK: - Properties
    private let hostingController: UIHostingController<AnyView>
    private let rootView: MoreView
    
    // MARK: - Initialize with ViewModel
    init(viewModel: MoreViewModel) {
        self.rootView = MoreView(viewModel: viewModel)
        self.hostingController = UIHostingController(rootView: AnyView(rootView))
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
private extension MoreViewController {
    func setupViews() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        self.rightBarButtonItem = rightBarButtonItem
        view.addSubview(hostingView)
    }
    
    func setupConstraints() {
        hostingView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        let input = rootView.input
        rightBarButtonItem.rx.tap.asDriver()
            .drive(input.clickSettings)
            .disposed(by: disposeBag)
    }
}
