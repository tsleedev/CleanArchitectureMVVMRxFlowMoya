//
//  MoreSceneDIContainer.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2023/02/06.
//

import DomainLayer
import DataLayer
import UIKit

public final class MoreSceneDIContainer {
    
    struct Dependencies {
        let networking: MoreNetworking
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - UseCases
    public func makeUseCase() -> MoreUseCaseProtocol {
        return MoreUseCase(repository: makeRepository())
    }
    
    // MARK: - Repositories
    private func makeRepository() -> MoreRepository {
        return MoreRepositoryImp(network: dependencies.networking)
    }
}
