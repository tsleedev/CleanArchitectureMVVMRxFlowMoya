//
//  MoreRepositoryImp.swift
//  
//
//  Created by TAE SU LEE on 2023/02/06.
//

import TSCore
import DomainLayer
import RxSwift

public class MoreRepositoryImp: DetectDeinit, MoreRepository {
    
    private let network: MoreNetworking
    
    public init(network: MoreNetworking) {
        self.network = network
    }
    
    public func readItems() -> Single<[Entities.More]> {
        return network
            .request(.readItems)
            .map(ResponseModel.MoreItems.self)
            .map { $0.items.map { $0.toDomain() } }
    }
}
