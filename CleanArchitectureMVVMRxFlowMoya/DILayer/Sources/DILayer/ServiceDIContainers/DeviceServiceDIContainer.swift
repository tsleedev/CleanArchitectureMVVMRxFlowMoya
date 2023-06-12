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
        let appInfoService: AppInfoService
        let userDefaultsService: UserDefaultsService
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
        return AppInfoRepositoryImp(service: dependencies.appInfoService)
    }
    
    func makeUserDefaultsRepository() -> UserDefaultsRepository {
        return UserDefaultsRepositoryImp(service: dependencies.userDefaultsService)
    }
    
    func makeDeviceRepository() -> DeviceRepository {
        return DeviceRepositoryImp(service: dependencies.deviceAPIService)
    }
}

// MARK: - SampleDataProviding
struct DeviceSampleDataProviding: APISampleDataProviding {
    func provideAPISampleData(forEndpoint endpoint: MoyaTargetTypeWrapper) -> APISampleData? {
        guard let endpoint = endpoint as? DeviceAPI else { return nil }
        switch endpoint {
        case .regist:
            return APISampleData(statusCode: 200, delay: 1, jsonLoader: JSONFile.Device.deviceRegist200)
        case .update:
            return APISampleData(statusCode: 200, delay: 1, jsonLoader: JSONFile.Device.deviceRegist200)
        case .deviceToken:
            return APISampleData(statusCode: 200, delay: 1, jsonLoader: JSONFile.Device.deviceRegist200)
        }
    }
}
