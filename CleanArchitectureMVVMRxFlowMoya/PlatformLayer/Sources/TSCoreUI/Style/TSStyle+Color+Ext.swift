//
//  TSStyle+Color+Ext.swift
//  
//
//  Created by TAE SU LEE on 2023/02/09.
//

import SwiftUI

public extension TSStyle.Color {
    var uicolor: UIColor {
        UIColor(named: self.rawValue, in: Bundle.module, compatibleWith: nil) ?? UIColor.red
    }
    
    var color: Color {
        Color(self.rawValue, bundle: Bundle.module)
    }
}
