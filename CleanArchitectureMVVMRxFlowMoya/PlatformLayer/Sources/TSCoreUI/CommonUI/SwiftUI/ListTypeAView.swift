//
//  ListTypeAView.swift
//  
//
//  Created by TAE SU LEE on 2023/05/10.
//

import SwiftUI

public struct ListTypeAView: View {
    private let item: ListTypeAItemViewModel
    
    public init(item: ListTypeAItemViewModel) {
        self.item = item
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            if let icon = item.icon {
                icon.image
                    .color(.black)
            }
            if let title = item.title {
                Text(title)
                    .typography(.body)
                    .color(.black)
            }
            Spacer()
            TSImage.greaterthan.image
                .color(.black)
        }
        .padding([.leading, .trailing], 20)
        .frame(height: 50)
        .bgColor(.bg)
    }
}

struct ListTypeAView_Previews: PreviewProvider {
    static var previews: some View {
        let item = ListTypeAItemViewModel(
            icon: nil,
            title: "공유하기"
        )
        ListTypeAView(item: item)
            .previewLayout(.sizeThatFits)
    }
}
