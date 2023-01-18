//
//  ReposDAO.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import TSCore
import Domain
import RxSwift

public class ReposDAO: DetectDeinit, ReposRepository {
    
    private let network: RepoNetworking
    
    public init(network: RepoNetworking) {
        self.network = network
    }
    
    public func fetchRepos(query: String, page: Int, perPage: Int = 30) -> Single<ReposPage> {
        return network
            .request(.searchRepos(query: query, page: page, perPage: perPage))
            .map(ReposResponseDTO.self)
            .map { $0.toDomain() }
    }	
}
