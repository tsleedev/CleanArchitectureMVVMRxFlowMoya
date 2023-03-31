//  
//  SettingsRepository.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2023/03/20.
//

import RxSwift

public protocol SettingsRepository {
    func readItems() -> Single<[Entities.Settings]>
}
