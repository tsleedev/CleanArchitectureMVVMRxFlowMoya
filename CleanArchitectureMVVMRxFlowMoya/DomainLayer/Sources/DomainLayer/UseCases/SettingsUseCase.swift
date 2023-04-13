//  
//  SettingsUseCase.swift
//  
//
//  Created by TAE SU LEE on 2023/03/20.
//

import TSCore
import RxSwift

public protocol SettingsUseCaseProtocol {
    func readItems() -> Single<[Entities.Settings]>
}

public class SettingsUseCase: DetectDeinit, SettingsUseCaseProtocol {
    private let repository: SettingsRepository
    
    public init(repository: SettingsRepository) {
        self.repository = repository
    }
    
    public func readItems() -> Single<[Entities.Settings]> {
        return repository.readItems()
    }
}
