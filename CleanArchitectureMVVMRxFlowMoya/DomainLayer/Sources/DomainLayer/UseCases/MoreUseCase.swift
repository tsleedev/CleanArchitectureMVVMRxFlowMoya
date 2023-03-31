//
//  MoreUseCase.swift
//  
//
//  Created by TAE SU LEE on 2023/02/06.
//

import TSCore
import RxSwift

public protocol MoreUseCaseProtocol {
    func readItems() -> Single<[Entities.More]>
}

public class MoreUseCase: DetectDeinit, MoreUseCaseProtocol {
    
    private let repository: MoreRepository
    
    public init(repository: MoreRepository) {
        self.repository = repository
    }
    
    public func readItems() -> Single<[Entities.More]> {
        return repository.readItems()
    }
}
