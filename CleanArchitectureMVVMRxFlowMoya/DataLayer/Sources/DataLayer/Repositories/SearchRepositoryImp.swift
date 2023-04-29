//
//  SearchRepositoryImp.swift
//  
//
//  Created by TAE SU LEE on 2022/11/16.
//

import TSCore
import DomainLayer
import RxSwift

public class SearchRepositoryImp: DetectDeinit, SearchRepository {
    private let service: SearchAPIService
    
    public init(service: SearchAPIService) {
        self.service = service
    }
    
    public func readItems(_ param: Params.Search) -> Single<Entities.SearchItems> {
        let requestDTO = RequestModel.Search(query: param.query,
                                           page: param.page,
                                           perPage: param.perPage)
        return service
            .request(.readItems(requestDTO))
            .map(ResponseModel.SearchItems.self)
            .map { $0.toDomain() }
    }	
}
