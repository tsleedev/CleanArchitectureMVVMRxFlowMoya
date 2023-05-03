//
//  View+Border.swift
//  
//
//  Created by TAE SU LEE on 2023/05/03.
//

import SwiftUI

public extension View {
    func border(_ color: TSStyle.Color, lineWidth: CGFloat = 1) -> some View {
        return self.border(color.color, width: lineWidth)
    }
    
    func cornerBorder(_ color: TSStyle.Color, lineWidth: CGFloat = 1, cornerRadius: CGFloat) -> some View {
        return self.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color.color, lineWidth: lineWidth)
        )
    }
}
