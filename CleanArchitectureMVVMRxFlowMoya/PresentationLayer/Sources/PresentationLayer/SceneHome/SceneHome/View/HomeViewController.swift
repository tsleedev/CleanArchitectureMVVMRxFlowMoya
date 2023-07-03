//  
//  HomeViewController.swift
//  
//
//  Created by TAE SU LEE on 2023/03/06.
//

import TSCore
import TSCoreUI
import UIKit
import RxSwift
import SnapKit
import Then

class HomeViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var label: TSLabel! {
        didSet {
            label.typography = .head
            label.color = .red
        }
    }
    
    // MARK: - Views
    private var rightBarButtonItem: UIBarButtonItem!
    
    // MARK: - Properties
    private var input: HomeViewModel.Input?
    
    // MARK: - Initialize with ViewModel
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        configureUI()
        bindViewModel()
    }
}

// MARK: - Setup
private extension HomeViewController {
    func setupViews() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        self.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupConstraints() {
        // Add here constraints
    }
    
    func configureUI() {
        label.text = "Hello, World!"
    }
    
    func bindViewModel() {
        let clickSettings = rightBarButtonItem.rx.tap.asDriver()
        
        let input = HomeViewModel.Input(
            clickSettings: clickSettings
        )
        self.input = input
        
        let output = viewModel.transform(input: input)
    }
}

#if canImport(SwiftUI) && DEBUG
import DILayer
import SwiftUI

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        let appConfiguration = AppConfiguration(forPreviewWithTarget: .dev, mockData: nil)
        let diContainer = AppDIContainer(configuration: appConfiguration).makeSceneDIContainer()
        let viewModel = HomeViewModel(useCase: diContainer.makeHomeSceneDIContainer().makeUseCase())
        return HomeViewController(viewModel: viewModel).showPreview()
    }
}

#endif
