//  
//  HomeRepositoryImp.swift
//  
//
//  Created by TAE SU LEE on 2023/03/14.
//

import TSCore
import DomainLayer
import RxSwift

public class HomeRepositoryImp: DetectDeinit, HomeRepository {
    private let service: HomeAPIService
    
    public init(service: HomeAPIService) {
        self.service = service
    }
    
//    public func readItems(_ params: Params.Home) -> Single<[Entities.Home]> {
//        let requestDTO = RequestModel.Home()
//        return service
//            .request(.readItems(requestDTO))
//            .map(ResponseModel.HomeItems.self)
//            .map { $0.items.map { $0.toDomain() } }
//    }
//
//    public func readItem(_ params: Params.Home) -> Single<Entities.Home> {
//        let requestDTO = RequestDTO.Home()
//        return service
//            .request(.readItem(requestDTO))
//            .map(ResponseDTO.HomeItem.self)
//            .map { $0.toDomain() }
//    }
}
