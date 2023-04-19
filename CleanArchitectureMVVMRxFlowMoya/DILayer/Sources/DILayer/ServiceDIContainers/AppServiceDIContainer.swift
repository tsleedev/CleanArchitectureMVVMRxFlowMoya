//  
//  AppServiceDIContainer.swift
//  
//
//  Created by TAE SU LEE on 2023/04/18.
//

import DomainLayer
import DataLayer
import UIKit

public final class AppServiceDIContainer {
    struct Dependencies {
        let service: AppService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - UseCases
//public extension AppServiceDIContainer {
//    func makeUseCase() -> AppUseCaseProtocol {
//        return AppUseCase(repository: makeRepository())
//    }
//}
//
//// MARK: - Repositories
//private extension AppServiceDIContainer {
//    func makeRepository() -> AppRepository {
//        return AppRepositoryImp(service: dependencies.service)
//    }
//}
