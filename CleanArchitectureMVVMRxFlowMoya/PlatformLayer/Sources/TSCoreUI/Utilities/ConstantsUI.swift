//
//  ConstantsUI.swift
//  
//
//  Created by TAE SU LEE on 2023/05/02.
//

import Foundation

public struct ConstantsUI {
    enum Margin {
        case m8
        case m16
        case m24
    }

    enum Padding {
        case p8
        case p16
        case p24
    }

    enum Spacing {
        case s8
        case s16
        case s24
    }
}

extension ConstantsUI.Margin {
    public var value: CGFloat {
        switch self {
        case .m8:   return 8
        case .m16:  return 16
        case .m24: return 24
        }
    }
}

extension ConstantsUI.Padding {
    public var value: CGFloat {
        switch self {
        case .p8:   return 8
        case .p16:  return 16
        case .p24: return 24
        }
    }
}

extension ConstantsUI.Spacing {
    public var value: CGFloat {
        switch self {
        case .s8:   return 8
        case .s16:  return 16
        case .s24: return 24
        }
    }
}
