//
//  SearchFlow.swift
//  
//
//  Created by TAE SU LEE on 2022/11/16.
//

import DILayer
import TSCore
import UIKit
import RxFlow

public class SearchFlow: DetectDeinit, Flow {
    // MARK: - Initialize with DIContainer And UINavigationController
    private let diContainer: SearchSceneDIContainer
    private let rootViewController: UINavigationController
    
    public init(diContainer: SearchSceneDIContainer, rootViewController: UINavigationController) {
        self.diContainer = diContainer
        self.rootViewController = rootViewController
    }
    
    // MARK: - Flow
    public var root: Presentable {
        return self.rootViewController
    }

    public func navigate(to step: Step) -> FlowContributors {
        if let step = step as? SearchStep {
            return navigate(to: step)
        } else if let step = step as? DeepLinkStep {
            return navigate(to: step)
        }
        return .none
    }
}

// MARK: - Navigations
private extension SearchFlow {
    func navigate(to step: SearchStep) -> FlowContributors {
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        case .detailIsRequired(let viewModel):
            let webItemViewModel = WebItemViewModel(title: viewModel.fullName, startUrl: viewModel.htmlUrl)
            return navigateToWeb(webItemViewModel)
        }
    }
    
    func navigate(to step: DeepLinkStep) -> FlowContributors {
        return navigateToDeepLink(to: step)
    }
}

// MARK: - Helper
private extension SearchFlow {
    func navigateToMain() -> FlowContributors {
        let viewModel = SearchViewModel(useCase: diContainer.makeUseCase())
        let viewController = SearchViewController(viewModel: viewModel)
        let viewControllers = rootViewController.viewControllers + [viewController]
        rootViewController.setViewControllers(viewControllers, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewModel))
    }
    
    func navigateToWeb(_ itemViewModel: WebItemViewModel) -> FlowContributors {
        let viewModel = WebViewModel(itemViewModel: itemViewModel)
        let flow = WebFlow(viewModel: viewModel, rootViewController: rootViewController)
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: OneStepper(withSingleStep: WebStep.mainIsRequired)))
    }
}

// MARK: - DeepLink
private extension SearchFlow {
    func navigateToDeepLink(to step: DeepLinkStep) -> FlowContributors {
        switch step {
        case .restartApp:
            return .one(flowContributor: .forwardToParentFlow(withStep: step))
        case .settings:
            rootViewController.popToRootViewController(animated: false)
            return .none
        }
    }
}
