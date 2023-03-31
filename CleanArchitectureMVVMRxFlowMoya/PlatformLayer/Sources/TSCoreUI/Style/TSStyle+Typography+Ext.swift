//
//  File.swift
//  
//
//  Created by TAE SU LEE on 2023/02/10.
//

import SwiftUI

private enum FontType: String {
    case medium  = "AppleSDGothicNeo-Medium"
    case light   = "AppleSDGothicNeo-Light"
    case regular = "AppleSDGothicNeo-Regular"
    case bold    = "AppleSDGothicNeo-Bold"
    
    var name: String {
        switch self {
        case .medium:   return "AppleSDGothicNeo-Medium"
        case .light:    return "AppleSDGothicNeo-Light"
        case .regular:  return "AppleSDGothicNeo-Regular"
        case .bold:     return "AppleSDGothicNeo-Bold"
        }
    }
}

struct TypoObj {
    let font: Font
    let uifont: UIFont
    let size: CGFloat
    let letterSpacing: CGFloat
    let lineHeight: CGFloat
    
    fileprivate init(fontType: FontType, size: CGFloat, letterSpacing: CGFloat, lineHeight: CGFloat) {
        self.font = Font.custom(fontType.name, size: size)
        self.uifont = UIFont(name: fontType.name, size: size)!
        self.size = size
        self.letterSpacing = letterSpacing
        self.lineHeight = lineHeight
    }
}
    
extension TSStyle.Typography {
    var value: TypoObj {
        switch self {
        case .head:     return TypoObj(fontType: .bold,     size: 24.0,     letterSpacing: -1,      lineHeight: 31.0)
        case .body:     return TypoObj(fontType: .regular,  size: 16.0,     letterSpacing: -1,      lineHeight: 22.0)
        case .caption:  return TypoObj(fontType: .light,    size: 11.0,     letterSpacing: -1,      lineHeight: 15.0)
        }
    }
}
