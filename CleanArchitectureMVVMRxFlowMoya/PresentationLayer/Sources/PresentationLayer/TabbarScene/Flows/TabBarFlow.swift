//
//  TabBarFlow.swift
//  
//
//  Created by TAE SU LEE on 2023/02/01.
//

import DILayer
import TSCore
import UIKit
import RxFlow

private enum TabBarIndex: Int {
    case home = 0
    case search
    case more
}

public class TabBarFlow: DetectDeinit, Flow {
    // MARK: - Initialize with DIContainer
    private let appDIContainer: AppDIContainer
    
    public init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    
    private let rootViewController: TSTabBarController = {
        let tabBarController = TSTabBarController()
        return tabBarController
    }()
    
    // MARK: - Flow implementation
    public var root: Presentable {
        return self.rootViewController
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        if let step = step as? TabBarStep {
            return navigate(to: step)
        } else if let step = step as? DeepLinkStep {
            return navigate(to: step)
        }
        return .none
    }
}

// MARK: - Navigations
private extension TabBarFlow {
    func navigate(to step: TabBarStep) -> FlowContributors {
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        }
    }
    
    func navigate(to step: DeepLinkStep) -> FlowContributors {
        return navigateToDeepLink(to: step)
    }
}

// MARK: - Helper
private extension TabBarFlow {
    func navigateToMain() -> FlowContributors {
        let sceneDIContainer = appDIContainer.makeSceneDIContainer()
        let homeFlow = HomeFlow(homeSceneDIContainer: sceneDIContainer.makeHomeSceneDIContainer(),
                                searchSceneDIContainer: sceneDIContainer.makeSearchSceneDIContainer(),
                                settingsSceneDIContainer: sceneDIContainer.makeSettingsSceneDIContainer(),
                                rootViewController: UINavigationController())
        let searchFlow = SearchFlow(diContainer: sceneDIContainer.makeSearchSceneDIContainer(),
                                    rootViewController: UINavigationController())
        let moreFlow = MoreFlow(moreSceneDIContainer: sceneDIContainer.makeMoreSceneDIContainer(),
                                settingsSceneDIContainer: sceneDIContainer.makeSettingsSceneDIContainer(),
                                rootViewController: UINavigationController())
        
        Flows.use(homeFlow, searchFlow, moreFlow, when: .created) { [unowned self] flow0Root, flow1Root, flow2Root in
            let tabBarItem0 = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: nil)
            let tabBarItem1 = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
            let tabBarItem2 = UITabBarItem(title: "More", image: UIImage(systemName: "ellipsis"), selectedImage: nil)
            flow0Root.tabBarItem = tabBarItem0
            flow1Root.tabBarItem = tabBarItem1
            flow2Root.tabBarItem = tabBarItem2
            
            self.rootViewController.setViewControllers([flow0Root, flow1Root, flow2Root], animated: false)
        }
        
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow, withNextStepper: OneStepper(withSingleStep: HomeStep.mainIsRequired)),
            .contribute(withNextPresentable: searchFlow, withNextStepper: OneStepper(withSingleStep: SearchStep.mainIsRequired)),
            .contribute(withNextPresentable: moreFlow, withNextStepper: OneStepper(withSingleStep: MoreStep.mainIsRequired))
        ])
    }
}

// MARK: - DeepLink
private extension TabBarFlow {
    func navigateToDeepLink(to step: DeepLinkStep) -> FlowContributors {
        switch step {
        case .restartApp:
            return .one(flowContributor: .forwardToParentFlow(withStep: step))
        case .settings:
            // If the tab bar moves before the other view is closed, the following error occurs:
            // "Unbalanced calls to begin/end appearance transitions for"
            // To ensure that the other view is closed before moving, use DispatchQueue.main.async to delay the execution order.
            DispatchQueue.main.async {
                self.rootViewController.selectedIndex = 0
            }
            return .none
        }
    }
}
