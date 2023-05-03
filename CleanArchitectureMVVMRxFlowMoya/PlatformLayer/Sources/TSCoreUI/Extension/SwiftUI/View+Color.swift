//
//  View+Color.swift
//  
//
//  Created by TAE SU LEE on 2023/05/02.
//

import SwiftUI

public extension View {
    func color(_ color: TSStyle.Color) -> some View {
        return self.foregroundColor(color.color)
    }
    
    func bgColor(_ color: TSStyle.Color) -> some View {
        return self.background(color.color)
    }
}
