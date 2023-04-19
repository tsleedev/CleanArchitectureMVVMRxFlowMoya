//  
//  AppInfoRepository.swift
//  
//
//  Created by TAE SU LEE on 2023/04/14.
//

import RxSwift

public protocol AppInfoRepository {
    func appBundleID() -> String
    func appVersion() -> String
    func buildVersion() -> String
    func deviceModel() -> String
    func deviceType() -> String
    func osType() -> String
    func osVersion() -> String
}
