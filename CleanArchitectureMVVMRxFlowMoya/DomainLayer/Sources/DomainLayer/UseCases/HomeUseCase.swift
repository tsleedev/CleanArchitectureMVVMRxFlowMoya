//  
//  HomeUseCase.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2023/03/13.
//

import TSCore
import RxSwift

public protocol HomeUseCaseProtocol {
//    func read() -> Single<[Entities.Home]>
}

public class HomeUseCase: DetectDeinit, HomeUseCaseProtocol {
    
    private let repository: HomeRepository
    
    public init(repository: HomeRepository) {
        self.repository = repository
    }
    
//    public func read() -> Single<[Entities.Home]> {
//        return repository.read()
//    }
}
