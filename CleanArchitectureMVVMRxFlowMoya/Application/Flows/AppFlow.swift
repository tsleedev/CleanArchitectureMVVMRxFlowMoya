//
//  AppFlow.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import TSCore
import TSCoreUI
import DILayer
import PresentationLayer
import UIKit
import RxFlow
import RxSwift
import RxCocoa

final class AppFlow: DetectDeinit, Flow {
    // MARK: - Initialize with Window and DIContainer
    private let window: UIWindow
    private let appDIContainer: AppDIContainer
    
    init(window: UIWindow, appDIContainer: AppDIContainer) {
        self.window = window
        self.appDIContainer = appDIContainer
    }
    
    // MARK: - Flow implementation
    var root: Presentable {
        return self.window
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        case .splashIsRequired:
            return navigateToSplash()
        }
    }
}

// MARK: - Helper
private extension AppFlow {
    func navigateToSplash() -> FlowContributors {
        let splashFlow = SplashFlow()
        TSWindowManager.shared.add(splashFlow.window)
        let flowContributors = navigate(to: AppStep.mainIsRequired)
        if case let .one(flowContributor) = flowContributors {
            return .multiple(flowContributors: [
                flowContributor,
                .contribute(withNextPresentable: splashFlow, withNextStepper: OneStepper(withSingleStep: SplashStep.mainIsRequired))
            ])
        } else {
            return .one(flowContributor: .contribute(withNextPresentable: splashFlow, withNextStepper: OneStepper(withSingleStep: SplashStep.mainIsRequired)))
        }
    }
    
    func navigateToMain() -> FlowContributors {
        let tabBarFlow = TabBarFlow(appDIContainer: appDIContainer)
        Flows.use(tabBarFlow, when: .created) { [unowned self] tabBarRoot in
            self.window.rootViewController = tabBarRoot
            self.window.makeKeyAndVisible()
        }
        return .one(flowContributor: .contribute(withNextPresentable: tabBarFlow, withNextStepper: OneStepper(withSingleStep: TabBarStep.mainIsRequired)))
    }
}

// MARK: - Stepper
class AppStepper: Stepper {
    let steps = PublishRelay<Step>()

    var initialStep: Step {
        return AppStep.splashIsRequired
    }
}
