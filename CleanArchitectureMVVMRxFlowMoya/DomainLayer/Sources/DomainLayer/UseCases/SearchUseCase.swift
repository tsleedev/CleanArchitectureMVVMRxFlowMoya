//
//  SearchUseCase.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/15.
//

import TSCore
import RxSwift

public protocol SearchUseCaseProtocol {
    func readItems(_ param: Params.Search) -> Single<Entities.SearchItems>
}

public class SearchUseCase: DetectDeinit, SearchUseCaseProtocol {
    
    private let repository: SearchRepository
    
    public init(repository: SearchRepository) {
        self.repository = repository
    }
    
    public func readItems(_ param: Params.Search) -> Single<Entities.SearchItems> {
        return repository.readItems(param)
    }
}
