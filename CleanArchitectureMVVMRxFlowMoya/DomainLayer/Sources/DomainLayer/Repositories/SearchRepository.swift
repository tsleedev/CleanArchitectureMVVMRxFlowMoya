//
//  SearchRepository.swift
//  
//
//  Created by TAE SU LEE on 2022/11/15.
//

import RxSwift

public protocol SearchRepository {
    func readItems(_ param: Params.Search) -> Single<Entities.SearchItems>
}
