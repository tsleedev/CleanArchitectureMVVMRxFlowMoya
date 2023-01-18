//
//  File.swift
//  
//
//  Created by TAE SU LEE on 2022/11/20.
//

import TSCore
import UIKit
import RxFlow

public class WebFlow: DetectDeinit, Flow {
    public var root: Presentable {
        return isRoot ? rootViewController : mainViewController
    }
    
    private let viewModel: WebViewModel
    private let isRoot: Bool
    
    public init(viewModel: WebViewModel, isRoot: Bool = true) {
        self.viewModel = viewModel
        self.isRoot = isRoot
    }
    
    private lazy var mainViewController: WebViewController = {
        let viewController = WebViewController(viewModel: viewModel)
        return viewController
    }()
    
    private lazy var rootViewController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WebStep else { return .none }
        switch step {
        case .start:
            return navigateToMain()
        }
    }
}

// MARK: - Helper
private extension WebFlow {
    func navigateToMain() -> FlowContributors {
        if isRoot {
            rootViewController.viewControllers = [mainViewController]
            return .one(flowContributor: .contribute(withNextPresentable: rootViewController, withNextStepper: viewModel))
        }
        return .one(flowContributor: .contribute(withNextPresentable: mainViewController, withNextStepper: viewModel))
    }
}
