//  ___FILEHEADER___

import DomainLayer
import DataLayer
import UIKit

public final class ___VARIABLE_productName:identifier___ServiceDIContainer {
    struct Dependencies {
        let service: ___VARIABLE_productName:identifier___Service
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - UseCases
public extension ___VARIABLE_productName:identifier___ServiceDIContainer {
    func makeUseCase() -> ___VARIABLE_productName:identifier___UseCaseProtocol {
        return ___VARIABLE_productName:identifier___UseCase(repository: makeRepository())
    }
}

// MARK: - Repositories
private extension ___VARIABLE_productName:identifier___ServiceDIContainer {
    func makeRepository() -> ___VARIABLE_productName:identifier___Repository {
        return ___VARIABLE_productName:identifier___RepositoryImp(service: dependencies.service)
    }
}
