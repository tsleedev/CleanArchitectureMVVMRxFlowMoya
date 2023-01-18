//
//  SearchReposUseCase.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/15.
//

import TSCore
import RxSwift

public protocol SearchReposUseCaseProtocol {
    func excute(query: String, page: Int, perPage: Int) -> Single<ReposPage>
}

public class SearchReposUseCase: DetectDeinit, SearchReposUseCaseProtocol {
    
    private let reposRepository: ReposRepository
    
    public init(reposRepository: ReposRepository) {
        self.reposRepository = reposRepository
    }
    
    public func excute(query: String, page: Int, perPage: Int) -> Single<ReposPage> {
        return reposRepository.fetchRepos(query: query, page: page, perPage: perPage)
    }
}
