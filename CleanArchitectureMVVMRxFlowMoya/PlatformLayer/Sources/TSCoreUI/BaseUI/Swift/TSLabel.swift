//
//  TSLabel.swift
//  
//
//  Created by TAE SU LEE on 2023/02/10.
//

import TSCore
import UIKit

public class TSLabel: UILabel {
    @IBInspectable private var IBTypography: String? {
        didSet {
            if let ibtypography = IBTypography, !ibtypography.isEmpty {
                if let typography = TSStyle.Typography(rawValue: ibtypography) {
                    self.typography = typography
                } else {
                    assertionFailure("\(String(describing: type(of: self))) Error - IBTypography에 오타가 있습니다.(\(ibtypography))")
                }
            }
        }
    }
    
    @IBInspectable private var IBColor: String? {
        didSet {
            if let ibcolor = IBColor, !ibcolor.isEmpty {
                if let color = TSStyle.Color(rawValue: ibcolor) {
                    self.color = color
                } else {
                    assertionFailure("\(String(describing: type(of: self))) Error - IBColor에 오타가 있습니다.(\(ibcolor))")
                }
            }
        }
    }
    
    public var typography: TSStyle.Typography? {
        didSet {
            configureLabel()
        }
    }
    
    public var color: TSStyle.Color? {
        didSet {
            textColor = color?.uicolor ?? .clear
        }
    }
    
    public override var text: String? {
        didSet {
            configureLabel()
        }
    }
    
    // stored property의 didSet에서 처리시 textAlignment가 초기화됨
    // computed property로 받아서 처리 할 수 있게 함
    // (Objective C property는 stored/computed property 둘다 취급 가능?)
    public override var attributedText: NSAttributedString? {
        get {
            return super.attributedText
        }
        set {
            guard
                let attributedText = newValue,
                let typographyAttributes = typographyAttributes
            else {
                super.attributedText = newValue
                return
            }
            let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
            mutableAttributedText.with(attributes: typographyAttributes)
            super.attributedText = mutableAttributedText
            addUnderline()
        }
    }
    
    public var html: String? {
        didSet {
            configureLabel()
        }
    }
    
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentMode = .center
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        contentMode = .center
//    }
    
    func addUnderline() {
        if let attributedText = attributedText {
            let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
            let range = NSRange(location: 0, length: mutableAttributedText.length)
            
            mutableAttributedText.addAttributes([
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: UIColor.red // 밑줄 색상을 선택합니다.
            ], range: range)
            
            super.attributedText = mutableAttributedText
        }
    }
}

// MARK: - Helper
private extension TSLabel {
    var typographyAttributes: [NSAttributedString.Key: Any]? {
        let attributes: [NSAttributedString.Key: Any]?
        if let typography = typography {
            attributes = typography.attributes(textAlignment: textAlignment, lineBreakMode: lineBreakMode)
        } else {
            attributes = nil
        }
        return attributes
    }
    
    func configureLabel() {
        if let html = html, !html.isEmpty {
            if let html = html.html2AttributedString {
                attributedText = html
            } else {
                assertionFailure("\(String(describing: type(of: self))) Error - html 형식이 잘못됨 \(html)")
            }
        } else if let text = text, !text.isEmpty {
            super.attributedText = NSAttributedString(string: text, attributes: typographyAttributes)
            addUnderline()
        } else {
            super.attributedText = nil
        }
    }
}
