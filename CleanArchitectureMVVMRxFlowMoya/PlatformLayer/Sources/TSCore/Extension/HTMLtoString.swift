//
//  HTMLtoString.swift
//  
//
//  Created by TAE SU LEE on 2023/02/14.
//

import TSLogger
import UIKit

// MARK: - HTML
public extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(
                data: self,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil
            )
        } catch {
            TSLogger.error("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

public extension String {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    
    var html2String: String {
        html2AttributedString?.string ?? " "
    }
}

public extension NSMutableAttributedString {
    func with(attributes: [NSAttributedString.Key: Any]) {
        let range = NSRange(location: 0, length: length)
        enumerateAttribute(.font, in: range, options: .longestEffectiveRangeNotRequired, using: { value, range, _ in
            if let attributesFont = attributes[.font] as? UIFont {
                if let originalFont = value as? UIFont,
                   let newFont = applyTraitsFromFont(originalFont, to: attributesFont) {
                    self.addAttribute(.font, value: newFont, range: range)
                } else {
                    self.addAttribute(.font, value: attributesFont, range: range)
                }
            }
            var attributesWithOutFont = attributes
            attributesWithOutFont.removeValue(forKey: .font)
            self.addAttributes(attributesWithOutFont, range: range)
        })
    }
    
    func applyTraitsFromFont(_ f1: UIFont, to f2: UIFont) -> UIFont? {
        let originalTrait = f1.fontDescriptor.symbolicTraits
        if originalTrait.contains(.traitBold) {
            var traits = f2.fontDescriptor.symbolicTraits
            traits.insert(.traitBold)
            if let fd = f2.fontDescriptor.withSymbolicTraits(traits) {
                return UIFont.init(descriptor: fd, size: 0)
            }
        }
        return f2
    }
}
