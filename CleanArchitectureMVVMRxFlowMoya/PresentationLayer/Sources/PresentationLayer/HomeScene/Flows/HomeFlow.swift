//  
//  HomeFlow.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2023/03/06.
//

import DILayer
import TSCore
import UIKit
import RxFlow

public final class HomeFlow: DetectDeinit, Flow {
    // MARK: - Initialize with DIContainer And UINavigationController
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
    
    // MARK: - Flow
    public var root: Presentable {
        return self.rootViewController
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? HomeStep else { return .none }
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        case .settingsAreRequired:
            return navigateToSettings()
        }
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
