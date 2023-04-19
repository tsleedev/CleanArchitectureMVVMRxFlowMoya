//
//  UserDefaultsRepository.swift
//  
//
//  Created by TAE SU LEE on 2023/04/14.
//

import Foundation

public protocol UserDefaultsRepository {
    var uniqueAppInstanceID: String? { get set }
    var appVersion: String? { get set }
    var deviceModel: String? { get set }
    var deviceToken: String? { get set }
    var osVersion: String? { get set }
    var vendorId: String? { get set }
}
