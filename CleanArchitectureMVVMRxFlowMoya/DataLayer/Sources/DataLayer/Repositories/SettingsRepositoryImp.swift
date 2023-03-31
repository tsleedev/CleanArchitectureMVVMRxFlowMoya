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
    
    private let network: SettingsNetworking
    
    public init(network: SettingsNetworking) {
        self.network = network
    }
    
    public func readItems() -> Single<[Entities.Settings]> {
        return network
            .request(.readItems)
            .map(ResponseModel.SettingsItems.self)
            .map { $0.items.map { $0.toDomain() } }
    }
}
