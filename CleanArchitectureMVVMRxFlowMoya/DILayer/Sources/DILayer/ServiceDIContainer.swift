//
//  ServiceDIContainer.swift
//  
//
//  Created by TAE SU LEE on 2023/04/18.
//

import DataLayer
import Foundation

public final class ServiceDIContainer {
    private let configuration: AppConfiguration
    
    public init(configuration: AppConfiguration) {
        self.configuration = configuration
    }
}

// MARK: - MakeDIContainer
public extension ServiceDIContainer {
    func makeDeviceServiceDIContainer() -> DeviceServiceDIContainer {
       let appInfoService = AppInfoService()
       let userDefaultsService = UserDefaultsService()
       let deviceAPIService = DeviceAPIService(apiBaseURL: configuration.apiBaseURL,
                                               apiType: makeAPIType(statusCode: 200, delay: 1))
       let dependencies = DeviceServiceDIContainer.Dependencies(appInfoService: appInfoService,
                                                                userDefaultsService: userDefaultsService,
                                                                deviceAPIService: deviceAPIService)
       return DeviceServiceDIContainer(dependencies: dependencies)
   }
    
    func makeNotificationServiceDIContainer() -> NotificationServiceDIContainer {
       let dependencies = NotificationServiceDIContainer.Dependencies()
       return NotificationServiceDIContainer(dependencies: dependencies)
    }
}

// MARK: - Helper
private extension ServiceDIContainer {
    func makeAPIType(statusCode: Int, delay: TimeInterval) -> APIType {
        let apiType: APIType
        switch self.configuration.mode {
        case .useSampleData:
            apiType = .mock(statusCode: statusCode, mockFile: nil, delay: delay)
        case .useRealData:
            apiType = .real
        }
        return apiType
    }
}
