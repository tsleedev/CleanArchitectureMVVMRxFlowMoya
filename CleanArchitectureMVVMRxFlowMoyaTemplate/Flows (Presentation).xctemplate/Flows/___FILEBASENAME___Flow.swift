//  ___FILEHEADER___

import DILayer
import TSCore
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
    
    // MARK: - Flow
    public var root: Presentable {
        return self.rootViewController
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? ___VARIABLE_productName:identifier___Step else { return .none }
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
