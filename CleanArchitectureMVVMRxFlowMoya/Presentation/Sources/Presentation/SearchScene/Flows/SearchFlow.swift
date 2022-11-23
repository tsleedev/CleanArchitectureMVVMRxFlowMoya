//
//  SearchFlow.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import UIKit
import Platform
import RxFlow

public class SearchFlow: DetectDeinit, Flow {
    public var root: Presentable {
        return self.rootViewController
    }
    
    private let viewModel: SearchViewModel
    
    public init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    private lazy var rootViewController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SearchStep else { return .none }
        switch step {
        case .start:
            return navigateToMain()
        case .detail:
            return .one(flowContributor: .forwardToParentFlow(withStep: step))
        }
    }
}

// MARK: - Helper
private extension SearchFlow {
    func navigateToMain() -> FlowContributors {
        let viewController = SearchViewController(viewModel: viewModel)
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: rootViewController, withNextStepper: viewModel))
    }
}
