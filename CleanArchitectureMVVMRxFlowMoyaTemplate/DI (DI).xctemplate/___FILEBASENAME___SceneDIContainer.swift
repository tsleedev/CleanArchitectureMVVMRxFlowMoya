//  ___FILEHEADER___

import DomainLayer
import DataLayer
import UIKit

public final class ___VARIABLE_productName:identifier___SceneDIContainer {
    
    struct Dependencies {
        let networking: ___VARIABLE_productName:identifier___Networking
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - UseCases
    public func makeUseCase() -> ___VARIABLE_productName:identifier___UseCaseProtocol {
        return ___VARIABLE_productName:identifier___UseCase(repository: makeRepository())
    }
    
    // MARK: - Repositories
    private func makeRepository() -> ___VARIABLE_productName:identifier___Repository {
        return ___VARIABLE_productName:identifier___RepositoryImp(network: dependencies.networking)
    }
}
