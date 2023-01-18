//
//  AppFlow.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import TSCore
import Presentation
import Data
import UIKit
import RxFlow
import RxSwift
import RxCocoa

final class AppFlow: DetectDeinit, Flow {
    private let window: UIWindow
    private var rootViewController: UINavigationController!
    
    var root: Presentable {
        return self.window
    }
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func navigate(to step: Step) -> FlowContributors {
        if let step = step as? AppStep {
            return navigate(to: step)
        } else if let step = step as? SearchStep {
            return navigate(to: step)
        }
        return .none
    }
}

// MARK: - AppStep
private extension AppFlow {
    func navigate(to step: AppStep) -> FlowContributors {
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        case .webIsRequired(let viewModel, let isRoot):
            return navigateToWeb(viewModel, isRoot)
        }
    }
}

// MARK: - SearchStep
private extension AppFlow {
    func navigate(to step: SearchStep) -> FlowContributors {
        switch step {
        case .detail(let viewModel):
            let webItemViewModel = WebItemViewModel(title: viewModel.fullName, startUrl: viewModel.htmlUrl)
            return .one(flowContributor: .forwardToCurrentFlow(withStep: AppStep.webIsRequired(viewModel: webItemViewModel, isRoot: false)))
        default:
            return .none
        }
    }
}

// MARK: - Helper
private extension AppFlow {
    func navigateToMain() -> FlowContributors {
        let diContainer = AppDIContainer().makeSearchSceneDIContainer()
        let viewModel = SearchViewModel(searchReposUseCase: diContainer.makeSearchReposUseCase())
        let flow = SearchFlow(viewModel: viewModel)
        Flows.use(flow, when: .created) { root in
            self.window.rootViewController = root
            if let root = root as? UINavigationController {
                self.rootViewController = root
            }
        }
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: OneStepper(withSingleStep: SearchStep.start)))
    }
    
    func navigateToWeb(_ itemViewModel: WebItemViewModel, _ isRoot: Bool) -> FlowContributors {
        let viewModel = WebViewModel(webItemViewModel: itemViewModel)
        let flow = WebFlow(viewModel: viewModel, isRoot: isRoot)
        Flows.use(flow, when: .created) { root in
            if isRoot {
                self.rootViewController.present(root, animated: true)
            } else {
                self.rootViewController.pushViewController(root, animated: true)
            }
        }
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: OneStepper(withSingleStep: WebStep.start)))
    }
}

class AppStepper: Stepper {
    let steps = PublishRelay<Step>()

    var initialStep: Step {
        return AppStep.mainIsRequired
    }
}
