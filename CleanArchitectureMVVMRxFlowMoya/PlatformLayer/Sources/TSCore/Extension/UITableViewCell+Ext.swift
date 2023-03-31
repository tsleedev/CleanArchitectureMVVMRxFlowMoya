//
//  UITableViewCell+Ext.swift
//  
//
//  Created by TAE SU LEE on 2022/11/20.
//

import UIKit

extension UITableViewCell {
    public static var identifier: String {
        return String(describing: Self.self)
    }
}
