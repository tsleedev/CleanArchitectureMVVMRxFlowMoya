//
//  Text+Typography.swift
//  
//
//  Created by TAE SU LEE on 2023/02/10.
//

import SwiftUI

public extension Text {
    func typography(_ style: TSStyle.Typography) -> some View {
        let value = style.value
        return self.font(Font(value.uifont))
            .tracking(value.letterSpacing)
            .lineSpacing((value.lineHeight - value.uifont.lineHeight))
            .padding(.vertical, (value.lineHeight - value.uifont.lineHeight) / 2)
    }
}
