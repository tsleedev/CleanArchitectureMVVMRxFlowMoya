//
//  AppDIContainer.swift
//  
//
//  Created by TAE SU LEE on 2022/11/16.
//

import Foundation

public final class AppDIContainer {
    private let configuration: AppConfiguration
    
    public init(configuration: AppConfiguration) {
        self.configuration = configuration
    }
}

// MARK: - MakeDIContainer
public extension AppDIContainer {
    func makeSceneDIContainer() -> SceneDIContainer {
        return SceneDIContainer(configuration: configuration)
    }
    
    func makeServiceDIContainer() -> ServiceDIContainer {
        return ServiceDIContainer(configuration: configuration)
    }
}
