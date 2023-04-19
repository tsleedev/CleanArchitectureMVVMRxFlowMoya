//  
//  DeviceServiceDIContainer.swift
//  
//
//  Created by TAE SU LEE on 2023/04/18.
//

import DomainLayer
import DataLayer
import UIKit

public final class DeviceServiceDIContainer {
    struct Dependencies {
        let appInfoUseCase: AppInfoService
        let userDefaultsUseCase: UserDefaultsService
        let deviceAPIService: DeviceAPIService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - UseCases
public extension DeviceServiceDIContainer {
    func makeAppInfoUseCase() -> AppInfoUseCaseProtocol {
        return AppInfoUseCase(repository: makeAppInfoRepository())
    }
    
    func makeUserDefaultsUseCase() -> UserDefaultsUseCaseProtocol {
        return UserDefaultsUseCase(repository: makeUserDefaultsRepository())
    }
    
    func makeDeviceUseCase() -> DeviceUseCaseProtocol {
        return DeviceUseCase(repository: makeDeviceRepository())
    }
}

// MARK: - Repositories
private extension DeviceServiceDIContainer {
    func makeAppInfoRepository() -> AppInfoRepository {
        return AppInfoRepositoryImp(service: dependencies.appInfoUseCase)
    }
    
    func makeUserDefaultsRepository() -> UserDefaultsRepository {
        return UserDefaultsRepositoryImp(service: dependencies.userDefaultsUseCase)
    }
    
    func makeDeviceRepository() -> DeviceRepository {
        return DeviceRepositoryImp(service: dependencies.deviceAPIService)
    }
}
