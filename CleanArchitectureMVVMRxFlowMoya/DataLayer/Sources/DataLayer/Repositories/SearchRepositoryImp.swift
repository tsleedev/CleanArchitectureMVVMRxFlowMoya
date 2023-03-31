//
//  SearchRepositoryImp.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import TSCore
import DomainLayer
import RxSwift

public class SearchRepositoryImp: DetectDeinit, SearchRepository {
    
    private let network: SearchNetworking
    
    public init(network: SearchNetworking) {
        self.network = network
    }
    
    public func readItems(_ param: Params.Search) -> Single<Entities.SearchItems> {
        let requestDTO = RequestModel.Search(query: param.query,
                                           page: param.page,
                                           perPage: param.perPage)
        return network
            .request(.readItems(requestDTO))
            .map(ResponseModel.SearchItems.self)
            .map { $0.toDomain() }
    }	
}
