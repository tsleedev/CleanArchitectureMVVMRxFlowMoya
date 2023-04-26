//
//  NibLoadable.swift
//  
//
//  Created by TAE SU LEE on 2023/04/14.
//  
//

import UIKit
import SnapKit

public protocol NibLoadable {
    associatedtype ViewType = Self
    func loadViewFromNib(name: String) -> ViewType?
}

public extension NibLoadable where Self: UIView {
    func loadViewFromNib(name nibName: String) -> ViewType? {
        let bundle = Bundle.module // Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? ViewType
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle.module // Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: Self.self), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setupNib() {
        guard let view = loadViewFromNib() else { return }
        addSubview(view)
        view.backgroundColor = .clear
        view.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

public extension NibLoadable where Self: UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
    }
    
    static var identifier: String {
        return String(describing: Self.self)
    }
}

public extension NibLoadable where Self: UICollectionViewCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
    }
    
    static var identifier: String {
        return String(describing: Self.self)
    }
}
