//
//  SettingsViewController.swift
//  
//
//  Created by TAE SU LEE on 2023/03/22.
//

import TSCoreUI
import UIKit
import SwiftUI
import RxSwift
import SnapKit

class SettingsViewController: BaseViewController {
    // MARK: - Views
    private lazy var hostingView: UIView = {
        addChild(hostingController)
        return hostingController.view
    }()
    
    // MARK: - Properties
    private let hostingController: UIHostingController<SettingsView>
    
    // MARK: - Initialize with ViewModel
    init(viewModel: SettingsViewModel) {
        self.hostingController = UIHostingController(rootView: SettingsView(viewModel: viewModel))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // Necessary when the main scene closes (if not used, the flow won't be deinitialized)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if isMovingFromParent {
            let rootView = hostingController.rootView as SettingsView
            rootView.input.flowCompleted.onNext(())
        }
    }
}

// MARK: - Setup
private extension SettingsViewController {
    func setupViews() {
        view.addSubview(hostingView)
        if navigationController?.viewControllers.count == 1 {
            let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: nil, action: nil)
            navigationItem.rightBarButtonItem = rightBarButtonItem
            rightBarButtonItem.rx.tap.asDriver()
                .drive(onNext: { [weak self] _ in
                    guard let self = self else { return }
                    let rootView = self.hostingController.rootView as SettingsView
                    rootView.input.dismissModal.onNext(())
                })
                .disposed(by: disposeBag)
        }
    }
    
    func setupConstraints() {
        hostingView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
