//
//  MoreRepository.swift
//  
//
//  Created by TAE SU LEE on 2023/02/06.
//

import RxSwift

public protocol MoreRepository {
    func readItems() -> Single<[Entities.More]>
}
