//  
//  AppInfoRepository.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2023/04/14.
//

import RxSwift

public protocol AppInfoRepository {
    func appBundleID() -> Single<String?>
    func appVersion() -> Single<String?>
    func appOSVersion() -> Single<String?>
    func buildVersion() -> Single<String?>
    func deviceType() -> Single<String?>
    func osType() -> Single<String?>
}
