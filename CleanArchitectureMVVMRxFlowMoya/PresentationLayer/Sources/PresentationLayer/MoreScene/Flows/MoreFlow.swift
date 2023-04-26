//  
//  MoreFlow.swift
//  
//
//  Created by TAE SU LEE on 2023/03/17.
//

import DILayer
import TSCore
import UIKit
import RxFlow

public final class MoreFlow: DetectDeinit, Flow {
    // MARK: - Initialize with DIContainer And UINavigationController
    private let moreSceneDIContainer: MoreSceneDIContainer
    private let settingsSceneDIContainer: SettingsSceneDIContainer
    private let rootViewController: UINavigationController
    
    public init(moreSceneDIContainer: MoreSceneDIContainer, settingsSceneDIContainer: SettingsSceneDIContainer, rootViewController: UINavigationController) {
        self.moreSceneDIContainer = moreSceneDIContainer
        self.settingsSceneDIContainer = settingsSceneDIContainer
        self.rootViewController = rootViewController
    }
    
    // MARK: - Flow
    public var root: Presentable {
        return self.rootViewController
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        if let step = step as? MoreStep {
            return navigate(to: step)
        } else if let step = step as? DeepLinkStep {
            return navigate(to: step)
        }
        return .none
    }
}

// MARK: - Navigations
private extension MoreFlow {
    func navigate(to step: MoreStep) -> FlowContributors {
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        case .mainIsComplete:
            rootViewController.popViewController(animated: true)
            return .none
        case .flowCompleted:
            return .end(forwardToParentFlowWithStep: step)
        case .detailIsRequired:
            return navigateToDetail()
        case .settingsAreRequired:
            return navigateToSettings()
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
private extension MoreFlow {
    func navigateToMain() -> FlowContributors {
        let viewModel = MoreViewModel(useCase: moreSceneDIContainer.makeUseCase())
        let viewController = MoreViewController(viewModel: viewModel)
//        viewController.hidesBottomBarWhenPushed = true
        let viewControllers = rootViewController.viewControllers + [viewController]
        rootViewController.setViewControllers(viewControllers, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: rootViewController, withNextStepper: viewModel))
    }
    
    func navigateToDetail() -> FlowContributors {
        let viewController = MoreDetailViewViewController()
        viewController.hidesBottomBarWhenPushed = true
        viewController.title = "DetailView"
        rootViewController.pushViewController(viewController, animated: true)
        return .none
    }
    
    func navigateToSettings() -> FlowContributors {
//        let flow = SettingsFlow(diContainer: settingsSceneDIContainer, rootViewController: rootViewController)
//        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: OneStepper(withSingleStep: SettingsStep.mainIsRequired)))
        let flow = SettingsFlow(diContainer: settingsSceneDIContainer, rootViewController: UINavigationController())
        Flows.use(flow, when: .created) { root in
            root.view.backgroundColor = .systemBackground
            root.modalPresentationStyle = .fullScreen
            self.rootViewController.present(root, animated: true)
        }
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: OneStepper(withSingleStep: SettingsStep.mainIsRequired)))
    }
}

// MARK: - DeepLink
private extension MoreFlow {
    func navigateToDeepLink(to step: DeepLinkStep) -> FlowContributors {
        switch step {
        case .settings:
            rootViewController.presentedViewController?.dismiss(animated: false)
            return .none
        }
    }
}
