//  
//  SettingsFlow.swift
//  
//
//  Created by TAE SU LEE on 2023/03/20.
//

import DILayer
import TSCore
import SwiftUI
import RxFlow

public final class SettingsFlow: DetectDeinit, Flow {
    // MARK: - Initialize with DIContainer And UINavigationController
    private let diContainer: SettingsSceneDIContainer
    private let rootViewController: UINavigationController
    
    public init(diContainer: SettingsSceneDIContainer, rootViewController: UINavigationController) {
        self.diContainer = diContainer
        self.rootViewController = rootViewController
    }
    
    // MARK: - Flow
    public var root: Presentable {
        return self.rootViewController
    }

    public func navigate(to step: Step) -> FlowContributors {
        if let step = step as? SettingsStep {
            return navigate(to: step)
        } else if let step = step as? DeepLinkStep {
            return navigate(to: step)
        }
        return .none
    }
}

// MARK: - Navigations
private extension SettingsFlow {
    func navigate(to step: SettingsStep) -> FlowContributors {
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        case .mainIsComplete:
            rootViewController.popViewController(animated: true)
            return .end(forwardToParentFlowWithStep: step)
        case .mainIsCompleteModal:
            rootViewController.dismiss(animated: true)
            return .end(forwardToParentFlowWithStep: step)
        case .flowCompleted:
            return .end(forwardToParentFlowWithStep: step)
        }
    }
    
    func navigate(to step: DeepLinkStep) -> FlowContributors {
        switch step {
        case .settings:
            return navigateToDeepLink(to: step)
        }
    }
}

// MARK: - Helper
private extension SettingsFlow {
    func navigateToMain() -> FlowContributors {
        let viewModel = SettingsViewModel(useCase: diContainer.makeUseCase())
        let viewController = SettingsViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        viewController.hidesBottomBarWhenPushed = true
        let viewControllers = rootViewController.viewControllers + [viewController]
        rootViewController.setViewControllers(viewControllers, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewModel))
    }
}

// MARK: - DeepLink
private extension SettingsFlow {
    func navigateToDeepLink(to step: DeepLinkStep) -> FlowContributors {
        switch step {
        case .settings:
            return .none
        }
    }
}
