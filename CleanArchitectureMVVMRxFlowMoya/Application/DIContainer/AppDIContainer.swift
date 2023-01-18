//
//  AppDIContainer.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import Data
import Foundation

final class AppDIContainer {
    
    func makeSearchSceneDIContainer() -> SearchSceneDIContainer {
        let networking = RepoNetworking()
//        let networking = RepoNetworking(networkType: .sample(statusCode: 200), delayed: 1)
//        let networking = RepoNetworking(networkType: .error, delayed: 1)
        let dependencies = SearchSceneDIContainer.Dependencies(repoNetworking: networking)
        return SearchSceneDIContainer(dependencies: dependencies)
    }
}
