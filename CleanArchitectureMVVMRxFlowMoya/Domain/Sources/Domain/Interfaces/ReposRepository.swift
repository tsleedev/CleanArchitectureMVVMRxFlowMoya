//
//  ReposRepository.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/15.
//

import RxSwift

public protocol ReposRepository {
    func fetchRepos(query: String, page: Int, perPage: Int) -> Single<ReposPage>
}
