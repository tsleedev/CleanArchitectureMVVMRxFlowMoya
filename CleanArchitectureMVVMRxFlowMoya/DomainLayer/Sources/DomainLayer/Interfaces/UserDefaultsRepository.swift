//
//  UserDefaultsRepository.swift
//  
//
//  Created by TAE SU LEE on 2023/04/14.
//

import RxSwift

public protocol UserDefaultsRepository {
    func uniqueAppInstanceID() -> Single<String?>
    func appVersion() -> Single<String?>
    func deviceName() -> Single<String?>
    func deviceToken() -> Single<String?>
    func osVersion() -> Single<String?>
    func vendorId() -> Single<String?>
}
