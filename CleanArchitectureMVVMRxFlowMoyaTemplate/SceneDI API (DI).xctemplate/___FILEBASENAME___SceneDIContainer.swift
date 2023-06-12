//  ___FILEHEADER___

import DomainLayer
import DataLayer
import UIKit

public final class ___VARIABLE_productName:identifier___SceneDIContainer {
    struct Dependencies {
//        let service: ___VARIABLE_productName:identifier___Service
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - UseCases
public extension ___VARIABLE_productName:identifier___SceneDIContainer {
    func makeUseCase() -> ___VARIABLE_productName:identifier___UseCaseProtocol {
        return ___VARIABLE_productName:identifier___UseCase(repository: makeRepository())
    }
}

// MARK: - Repositories
private extension ___VARIABLE_productName:identifier___SceneDIContainer {
    func makeRepository() -> ___VARIABLE_productName:identifier___Repository {
//        return ___VARIABLE_productName:identifier___RepositoryImp(service: dependencies.service)
        return ___VARIABLE_productName:identifier___RepositoryImp()
    }
}

// MARK: - SampleDataProviding
struct ___VARIABLE_productName:identifier___APISampleDataProviding: APISampleDataProviding {
    func provideAPISampleData(forEndpoint endpoint: MoyaTargetTypeWrapper) -> APISampleData? {
        return nil
//        guard let endpoint = endpoint as? ___VARIABLE_productName:identifier___API else { return nil }
//        switch endpoint {
//        case .readItems:
//            return APISampleData(statusCode: 200, delay: 1, jsonLoader: JSONFile.___VARIABLE_productName:identifier___.readItems200)
//        }
    }
}
