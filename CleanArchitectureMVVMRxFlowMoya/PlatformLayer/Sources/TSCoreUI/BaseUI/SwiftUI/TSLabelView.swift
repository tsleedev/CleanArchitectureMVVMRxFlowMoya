//
//  TSLabelView.swift
//  
//
//  Created by TAE SU LEE on 2023/02/14.
//

import SwiftUI

public struct TSLabelView: UIViewRepresentable {
    private var text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public func makeUIView(context: Context) -> TSLabel {
        let label = TSLabel()
        return label
    }
    
    public func updateUIView(_ uiView: TSLabel, context: Context) {
        uiView.text = text
    }
}
