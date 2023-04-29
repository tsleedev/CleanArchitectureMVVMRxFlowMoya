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
    private let service: MoreAPIService
    
    public init(service: MoreAPIService) {
        self.service = service
    }
    
    public func readItems() -> Single<[Entities.More]> {
        return service
            .request(.readItems)
            .map(ResponseModel.MoreItems.self)
            .map { $0.items.map { $0.toDomain() } }
    }
}
