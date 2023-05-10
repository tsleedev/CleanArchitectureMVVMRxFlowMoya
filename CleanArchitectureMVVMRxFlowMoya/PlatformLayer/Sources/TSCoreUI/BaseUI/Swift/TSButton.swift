//
//  TSButton.swift
//  
//
//  Created by TAE SU LEE on 2023/02/14.
//

import UIKit

public class TSButton: UIButton {
    
    // MARK: - IBInspectable
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
    
    @IBInspectable private var IBBgColor: String? {
        didSet {
            if let ibcolor = IBBgColor, !ibcolor.isEmpty {
                if let color = TSStyle.Color(rawValue: ibcolor) {
                    bgColor = color
                } else {
                    assertionFailure("\(String(describing: type(of: self))) Error - IBBgColor에 오타가 있습니다.(\(ibcolor))")
                }
            }
        }
    }
    
    @IBInspectable private var enableOverlay: Bool = true
    
    @IBInspectable public var normalBgColor: UIColor?
    @IBInspectable public var highlightedBgColor: UIColor?
    @IBInspectable public var disabledBgColor: UIColor = .lightGray
    
    // MARK: - Property
    private var overlayview: UIView = UIView()
    private var overlayAlpha = 1 - 0.16
    
    public var animated: Bool = true // 버튼 transform animation
    
    public var typography: TSStyle.Typography? {
        didSet {
            configureLabel()
        }
    }
    
    public var color: TSStyle.Color? {
        didSet {
            setTitleColor(color?.uicolor, for: .normal)
        }
    }
    
    public var bgColor: TSStyle.Color? {
        didSet {
            backgroundColor = bgColor?.uicolor ?? .clear
        }
    }
    
    public var html: String? {
        didSet {
            configureLabel()
        }
    }
    
    public override var backgroundColor: UIColor? {
        get {
            return super.backgroundColor
        }
        set {
            overlayview.backgroundColor = UIColor(white: 0, alpha: 0.16)
            super.backgroundColor = newValue
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            isUserInteractionEnabled = isEnabled
            if isEnabled {
                backgroundColor = normalBgColor
            } else {
                backgroundColor = disabledBgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        initSubViews()
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        configureLabel(title, for: state)
    }
    
    public override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {
        guard
            let attributedText = title,
            let typographyAttributes = typographyAttributes
        else {
            super.setAttributedTitle(title, for: state)
            return
        }
        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
        mutableAttributedText.with(attributes: typographyAttributes)
        super.setAttributedTitle(mutableAttributedText, for: state)
    }
    
    private func initSubViews() {
        addSubview(overlayview)
        layer.masksToBounds = true
        overlayview.alpha = 0

        overlayview.isUserInteractionEnabled = false
        overlayview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overlayview.topAnchor.constraint(equalTo: topAnchor),
            overlayview.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayview.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        normalBgColor = backgroundColor
    }
}

// MARK: - Helper
private extension TSButton {
    var typographyAttributes: [NSAttributedString.Key: Any]? {
        let attributes: [NSAttributedString.Key: Any]?
        if let typography = typography {
            attributes = typography.attributes(textAlignment: nil, lineBreakMode: titleLabel?.lineBreakMode, foregroundColor: titleColor(for: .normal))
        } else {
            attributes = nil
        }
        return attributes
    }
    
    func configureLabel() {
        if let html = html, !html.isEmpty {
            if let html = html.html2AttributedString {
                setAttributedTitle(html, for: .normal)
            } else {
                assertionFailure("\(String(describing: type(of: self))) Error - html 형식이 잘못됨 \(html)")
            }
        } else {
            configureLabel(titleLabel?.text, for: .normal)
        }
    }
    
    func configureLabel(_ text: String?, for state: UIControl.State) {
        if let text = text, !text.isEmpty {
            let attributedText = NSAttributedString(string: text, attributes: typographyAttributes)
            super.setAttributedTitle(attributedText, for: state)
        } else {
            super.setAttributedTitle(nil, for: state)
        }
    }
}

public extension TSButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchIn()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchOut()
    }
    
    override  func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchOut()
    }
}

extension TSButton {
    func touchIn() {
        transform = CGAffineTransform.identity
        UIView.animate(withDuration: animated ? 1 : 0,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0,
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
            if self.enableOverlay {
                self.alpha = self.overlayAlpha
            }
            let scale = self.animated ? 0.96 : 1
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: { _ in
        })
    }
    
    func touchOut() {
        UIView.animate(withDuration: animated ? 0.5 : 0,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
            if self.enableOverlay {
                self.alpha = 1
            }
            self.transform = CGAffineTransform.identity
        }, completion: { _ in()
        })
    }
}
