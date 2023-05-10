//
//  ListTypeAItemViewModel.swift
//  
//
//  Created by TAE SU LEE on 2023/05/10.
//

import Foundation

public struct ListTypeAItemViewModel: Identifiable, Equatable {
    public let id = UUID()
    let icon: TSImage?
    let title: String?
    
    public init(icon: TSImage?, title: String?) {
        self.icon = icon
        self.title = title
    }
}
