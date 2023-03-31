//  
//  SettingsFlow.swift
//  CleanArchitectureMVVMRxFlowMoya
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
        guard let step = step as? SettingsStep else { return .none }
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        case .mainIsComplete:
            rootViewController.popViewController(animated: true)
            return .none
        case .flowCompleted:
            return .end(forwardToParentFlowWithStep: step)
        }
    }
}

// MARK: - Helper
private extension SettingsFlow {
    func navigateToMain() -> FlowContributors {
        let viewModel = SettingsViewModel(useCase: diContainer.makeUseCase())
        let viewController = SettingsViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        let viewControllers = rootViewController.viewControllers + [viewController]
        rootViewController.setViewControllers(viewControllers, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewModel))
    }
}
