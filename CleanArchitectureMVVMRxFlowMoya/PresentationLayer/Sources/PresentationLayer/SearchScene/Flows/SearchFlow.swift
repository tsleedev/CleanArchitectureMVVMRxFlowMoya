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
        guard let step = step as? SearchStep else { return .none }
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        case .detailIsRequired(let viewModel):
            let webItemViewModel = WebItemViewModel(title: viewModel.fullName, startUrl: viewModel.htmlUrl)
            return navigateToWeb(webItemViewModel)
        }
    }
}

// MARK: - Helper
private extension SearchFlow {
    func navigateToMain() -> FlowContributors {
        let viewModel = SearchViewModel(useCase: diContainer.makeUseCase())
        let viewController = SearchViewController(viewModel: viewModel)
        let viewControllers = rootViewController.viewControllers + [viewController]
        rootViewController.setViewControllers(viewControllers, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: rootViewController, withNextStepper: viewModel))
    }
    
    func navigateToWeb(_ itemViewModel: WebItemViewModel) -> FlowContributors {
        let viewModel = WebViewModel(itemViewModel: itemViewModel)
        let flow = WebFlow(viewModel: viewModel, rootViewController: rootViewController)
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: OneStepper(withSingleStep: WebStep.mainIsRequired)))
    }
}
