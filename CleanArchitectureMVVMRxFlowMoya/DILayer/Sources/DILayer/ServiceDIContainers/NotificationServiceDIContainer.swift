//  
//  NotificationServiceDIContainer.swift
//
//
//  Created by TAE SU LEE on 2023/04/28.
//

import DomainLayer
import DataLayer
import UIKit

public final class NotificationServiceDIContainer {
    struct Dependencies { }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - UseCases
public extension NotificationServiceDIContainer {
    func makeUseCase() -> NotificationUseCaseProtocol {
        return NotificationUseCase(repository: makeRepository())
    }
}

// MARK: - Repositories
private extension NotificationServiceDIContainer {
    func makeRepository() -> NotificationRepository {
        return NotificationRepositoryImp()
    }
}
