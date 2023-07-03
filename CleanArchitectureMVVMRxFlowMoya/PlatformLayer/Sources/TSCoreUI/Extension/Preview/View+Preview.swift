//
//  View+Preview.swift
//  
//
//  Created by TAE SU LEE on 2023/07/03.
//

import SwiftUI

extension UIView {
    private struct Preview: UIViewRepresentable {
        typealias UIViewType = UIView

        let view: UIView

        func makeUIView(context: Context) -> UIView {
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {
        }
    }

    public func showPreview() -> some View {
        Preview(view: self)
    }
}
