//  ___FILEHEADER___

import TSCore
import DILayer
import UIKit
import RxFlow

public final class ___VARIABLE_productName:identifier___Flow: DetectDeinit, Flow {
    // MARK: - Initialize with DIContainer And UINavigationController
    private let diContainer: ___VARIABLE_productName:identifier___SceneDIContainer
    private let rootViewController: UINavigationController
    
    public init(diContainer: ___VARIABLE_productName:identifier___SceneDIContainer, rootViewController: UINavigationController) {
        self.diContainer = diContainer
        self.rootViewController = rootViewController
    }
    
    // MARK: - Flow implementation
    public var root: Presentable {
        return self.rootViewController
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        if let step = step as? ___VARIABLE_productName:identifier___Step {
            return navigate(to: step)
        } else if let step = step as? DeepLinkStep {
            return navigate(to: step)
        }
        return .none
    }
}

// MARK: - Navigations
private extension ___VARIABLE_productName:identifier___Flow {
    func navigate(to step: ___VARIABLE_productName:identifier___Step) -> FlowContributors {
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        case .mainIsComplete:
            rootViewController.popViewController(animated: true)
            return .end(forwardToParentFlowWithStep: step)
        case .flowCompleted:
            return .end(forwardToParentFlowWithStep: step)
        }
    }
    
    func navigate(to step: DeepLinkStep) -> FlowContributors {
        return navigateToDeepLink(to: step)
    }
}

// MARK: - Helper
private extension ___VARIABLE_productName:identifier___Flow {
    func navigateToMain() -> FlowContributors {
        let viewModel = ___VARIABLE_productName:identifier___ViewModel(useCase: diContainer.makeUseCase())
        let viewController = ___VARIABLE_productName:identifier___ViewController(viewModel: viewModel)
//        viewController.hidesBottomBarWhenPushed = true
        let viewControllers = rootViewController.viewControllers + [viewController]
        rootViewController.setViewControllers(viewControllers, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: rootViewController, withNextStepper: viewModel))
    }
}

// MARK: - DeepLink
private extension ___VARIABLE_productName:identifier___Flow {
    func navigateToDeepLink(to step: DeepLinkStep) -> FlowContributors {
        switch step {
        case .restartApp:
            return .one(flowContributor: .forwardToParentFlow(withStep: step))
        case .settings:
            return .none
        }
    }
}
