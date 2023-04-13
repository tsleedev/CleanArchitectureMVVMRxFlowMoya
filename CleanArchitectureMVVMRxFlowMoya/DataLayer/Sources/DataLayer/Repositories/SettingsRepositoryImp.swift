//  
//  SettingsRepositoryImp.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2023/03/20.
//

import TSCore
import DomainLayer
import RxSwift

public class SettingsRepositoryImp: DetectDeinit, SettingsRepository {
    
    private let service: SettingsAPIService
    
    public init(service: SettingsAPIService) {
        self.service = service
    }
    
    public func readItems() -> Single<[Entities.Settings]> {
        return service
            .request(.readItems)
            .map(ResponseModel.SettingsItems.self)
            .map { $0.items.map { $0.toDomain() } }
    }
}
