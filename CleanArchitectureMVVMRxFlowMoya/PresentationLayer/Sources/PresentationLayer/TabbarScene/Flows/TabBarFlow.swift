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
    
    // MARK: - Flow
    public var root: Presentable {
        return self.rootViewController
    }
    
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? TabBarStep else {
            return .one(flowContributor: .forwardToParentFlow(withStep: step))
        }
        switch step {
        case .mainIsRequired:
            return navigateToMain()
        }
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
