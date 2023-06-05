//
//  MoyaTargetTypeWrapper.swift
//  
//
//  Created by TAE SU LEE on 2023/03/24.
//

import Foundation
import Moya

/// `MoyaTargetTypeWrapper` is a wrapper protocol that encapsulates `Moya.TargetType`.
/// This protocol helps to avoid direct import of Moya in the DI Layer.
/// By doing so, it aids in reducing code coupling and enhancing independence between modules.
public protocol MoyaTargetTypeWrapper: TargetType { }


