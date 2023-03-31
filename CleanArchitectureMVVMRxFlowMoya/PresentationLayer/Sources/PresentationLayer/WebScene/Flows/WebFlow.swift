//
//  File.swift
//  
//
//  Created by TAE SU LEE on 2022/11/20.
//

import TSCore
import UIKit
import RxFlow

public class WebFlow: DetectDeinit, Flow {
    // MARK: - Initialize with UINavigationController
    private let viewModel: WebViewModel
    private let rootViewController: UINavigationController
    
    public init(viewModel: WebViewModel, rootViewController: UINavigationController) {
        self.viewModel = viewModel
        self.rootViewController = rootViewController
    }
    
    // MARK: - Flow
    public var root: Presentable {
        return self.rootViewController
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WebStep else { return .none }
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        }
    }
}

// MARK: - Helper
private extension WebFlow {
    func navigateToMain() -> FlowContributors {
        let viewController = WebViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        let viewControllers = rootViewController.viewControllers + [viewController]
        rootViewController.setViewControllers(viewControllers, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewModel))
    }
}
