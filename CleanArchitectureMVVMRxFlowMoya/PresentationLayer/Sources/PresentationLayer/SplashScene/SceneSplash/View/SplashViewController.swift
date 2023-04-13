//  
//  SplashViewController.swift
//  
//
//  Created by TAE SU LEE on 2023/03/22.
//

import TSCore
import TSCoreUI
import UIKit
import SwiftUI
import RxSwift
import SnapKit
import Then

class SplashViewController: BaseViewController {
    // MARK: - Views
    private lazy var hostingView: UIView = {
        addChild(hostingController)
        return hostingController.view
    }()
    
    // MARK: - Properties
    private let hostingController: UIHostingController<SplashView>
    
    // MARK: - Initialize with ViewModel
    init(viewModel: SplashViewModel) {
        self.hostingController = UIHostingController(rootView: SplashView(viewModel: viewModel))
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
}

// MARK: - Setup
private extension SplashViewController {
    func setupViews() {
        view.addSubview(hostingView)
    }
    
    func setupConstraints() {
        hostingView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
