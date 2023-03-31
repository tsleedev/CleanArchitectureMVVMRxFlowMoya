//  
//  SplashFlow.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2023/03/20.
//

import TSCore
import TSCoreUI
import SwiftUI
import RxFlow

public final class SplashFlow: DetectDeinit, Flow {
    private let viewModel = SplashViewModel()
    
    public let window = UIWindow()
    
    // MARK: - Flow
    public var root: Presentable {
        return self.window
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SplashStep else { return .none }
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        case .mainIsComplete:
            TSWindowManager.shared.remove(window)
            return .end(forwardToParentFlowWithStep: step)
        }
    }
}

// MARK: - Helper
private extension SplashFlow {
    func navigateToMain() -> FlowContributors {
        let viewController = SplashViewController(viewModel: viewModel)
        window.rootViewController = viewController
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewModel))
    }
}
