//
//  MoreUseCaseMock.swift
//  
//
//  Created by TAE SU LEE on 2023/03/31.
//

import TSCore
import DomainLayer
import Foundation
import RxSwift

public class MoreUseCaseMock: MoreUseCaseProtocol {
    private let moreItems: [Entities.More]
    private let shouldReturnError: Bool
    
    init(moreItems: [Entities.More], shouldReturnError: Bool) {
        self.moreItems = moreItems
        self.shouldReturnError = shouldReturnError
    }
    
    public func readItems() -> Single<[Entities.More]> {
        if shouldReturnError {
            return Single.error(APIError.unknown)
        } else {
            return Single.just(moreItems)
        }
    }
}
