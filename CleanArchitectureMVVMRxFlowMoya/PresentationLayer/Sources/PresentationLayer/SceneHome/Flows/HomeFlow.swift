//  
//  HomeFlow.swift
//  
//
//  Created by TAE SU LEE on 2023/03/06.
//

import DILayer
import TSCore
import TSCoreUI
import UIKit
import RxFlow
import RxSwift
import RxCocoa

public final class HomeFlow: DetectDeinit, Flow {
    // MARK: - Initialize with DIContainer
    private let homeSceneDIContainer: HomeSceneDIContainer
    private let searchSceneDIContainer: SearchSceneDIContainer
    private let settingsSceneDIContainer: SettingsSceneDIContainer
    private let rootViewController: UINavigationController
    
    public init(homeSceneDIContainer: HomeSceneDIContainer,
                searchSceneDIContainer: SearchSceneDIContainer,
                settingsSceneDIContainer: SettingsSceneDIContainer,
                rootViewController: UINavigationController) {
        self.homeSceneDIContainer = homeSceneDIContainer
        self.searchSceneDIContainer = searchSceneDIContainer
        self.settingsSceneDIContainer = settingsSceneDIContainer
        self.rootViewController = rootViewController
    }
    
    // MARK: - Flow implementation
    public var root: Presentable {
        return self.rootViewController
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        if let step = step as? HomeStep {
            return navigate(to: step)
        } else if let step = step as? DeepLinkStep {
            return navigate(to: step)
        }
        return .none
    }
}

// MARK: - Navigations
private extension HomeFlow {
    func navigate(to step: HomeStep) -> FlowContributors {
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        case .settingsAreRequired:
            return navigateToSettings()
        }
    }
    
    func navigate(to step: DeepLinkStep) -> FlowContributors {
        return navigateToDeepLink(to: step)
    }
}

// MARK: - Helper
private extension HomeFlow {
    func navigateToMain() -> FlowContributors {
        let viewModel = HomeViewModel(useCase: homeSceneDIContainer.makeUseCase())
        let viewController = HomeViewController(viewModel: viewModel)
        let viewControllers = rootViewController.viewControllers + [viewController]
        rootViewController.setViewControllers(viewControllers, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewModel))
    }
    
    func navigateToSettings() -> FlowContributors {
        let flow = SettingsFlow(diContainer: settingsSceneDIContainer, rootViewController: rootViewController)
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: OneStepper(withSingleStep: SettingsStep.mainIsRequired)))
    }
}

// MARK: - DeepLink
private extension HomeFlow {
    func navigateToDeepLink(to step: DeepLinkStep) -> FlowContributors {
        switch step {
        case .restartApp:
            return .one(flowContributor: .forwardToParentFlow(withStep: step))
        case .settings:
            if rootViewController.viewControllers.contains(where: { $0 is SettingsViewController }) {
                return .none
            } else {
                return navigateToSettings()
            }
        }
    }
}
