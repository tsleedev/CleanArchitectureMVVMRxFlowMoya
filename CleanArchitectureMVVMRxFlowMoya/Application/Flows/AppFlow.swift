//
//  AppFlow.swift
//  
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
        if let step = step as? AppStep {
            return navigate(to: step)
        } else if let step = step as? DeepLinkStep {
            return navigate(to: step)
        }
        return .none
    }
}

// MARK: - Navigations
private extension AppFlow {
    func navigate(to step: AppStep) -> FlowContributors {
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        case .splashIsRequired:
            return navigateToSplash()
        }
    }
    
    func navigate(to step: DeepLinkStep) -> FlowContributors {
        return navigateToDeepLink(to: step)
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

// MARK: - DeepLink
private extension AppFlow {
    func navigateToDeepLink(to step: DeepLinkStep) -> FlowContributors {
        switch step {
        case .restartApp:
            Application.shared.restart()
            return .none
        case .settings:
            return .none
        }
    }
}

// MARK: - Stepper
class AppStepper: Stepper {
    let steps = PublishRelay<Step>()

    var initialStep: Step {
        return AppStep.splashIsRequired
    }
}
