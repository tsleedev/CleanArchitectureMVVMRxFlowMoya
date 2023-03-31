//  
//  MoreFlow.swift
//  CleanArchitectureMVVMRxFlowMoya
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
        guard let step = step as? MoreStep else { return .none }
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
        let flow = SettingsFlow(diContainer: settingsSceneDIContainer, rootViewController: rootViewController)
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: OneStepper(withSingleStep: SettingsStep.mainIsRequired)))
    }
}
