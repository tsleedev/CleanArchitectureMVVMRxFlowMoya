//
//  TSStyle+Typography.swift
//  
//
//  Created by TAE SU LEE on 2023/02/09.
//

import UIKit

public extension TSStyle {
    enum Typography: String {
        case head
        case body
        case caption
    }
}

extension TSStyle.Typography {
    func attributes(textAlignment: NSTextAlignment?,
                    lineBreakMode: NSLineBreakMode?,
                    foregroundColor: UIColor? = nil) -> [NSAttributedString.Key: Any] {
        let value = value
        let paragraphStyle = NSMutableParagraphStyle()
        if value.lineHeight > 0 {
            paragraphStyle.minimumLineHeight = value.lineHeight
            paragraphStyle.maximumLineHeight = value.lineHeight
        }
        if let textAlignment = textAlignment {
            paragraphStyle.alignment = textAlignment
        }
        if let lineBreakMode = lineBreakMode {
            paragraphStyle.lineBreakMode = lineBreakMode
        }
        
        var attributes: [NSAttributedString.Key: Any] = [
            .font: value.uifont,
            .kern: value.letterSpacing,
            .paragraphStyle: paragraphStyle
        ]
        if let foregroundColor = foregroundColor {
            attributes[.foregroundColor] = foregroundColor
        }
        if value.lineHeight > 0 {
            attributes[.baselineOffset] = (value.lineHeight - value.uifont.lineHeight) / 4
        }
        return attributes
    }
}
