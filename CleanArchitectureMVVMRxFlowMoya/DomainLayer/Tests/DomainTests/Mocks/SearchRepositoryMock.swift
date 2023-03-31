//
//  SearchRepositoryMock.swift
//  
//
//  Created by TAE SU LEE on 2023/03/30.
//

import TSCore
import DomainLayer
import RxSwift

class SearchRepositoryMock: SearchRepository {
    private let searchItems: [Entities.SearchItems]
    private let shouldReturnError: Bool
    
    init(searchItems: [Entities.SearchItems], shouldReturnError: Bool) {
        self.searchItems = searchItems
        self.shouldReturnError = shouldReturnError
    }
    
    func readItems(_ param: Params.Search) -> Single<Entities.SearchItems> {
        if shouldReturnError {
            return Single.error(APIError.unknown)
        } else {
            if param.page <= searchItems.count {
                let searchItem = searchItems[param.page-1]
                let filteredItems = searchItem.items.filter { $0.fullName?.lowercased().contains(param.query.lowercased()) ?? false }
                return Single.just(Entities.SearchItems(totalCount: filteredItems.count, items: filteredItems))
            } else {
                return Single.just(Entities.SearchItems(totalCount: 0, items: []))
            }
        }
    }
}
