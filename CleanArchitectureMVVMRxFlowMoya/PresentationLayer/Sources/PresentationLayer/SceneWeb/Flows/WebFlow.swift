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
        if let step = step as? WebStep {
            return navigate(to: step)
        } else if let step = step as? DeepLinkStep {
            return navigate(to: step)
        }
        return .none
    }
}

// MARK: - Navigations
private extension WebFlow {
    func navigate(to step: WebStep) -> FlowContributors {
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        }
    }
    
    func navigate(to step: DeepLinkStep) -> FlowContributors {
        return navigateToDeepLink(to: step)
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

// MARK: - DeepLink
private extension WebFlow {
    func navigateToDeepLink(to step: DeepLinkStep) -> FlowContributors {
        switch step {
        case .restartApp:
            return .one(flowContributor: .forwardToParentFlow(withStep: step))
        case .settings:
            return .none
        }
    }
}
