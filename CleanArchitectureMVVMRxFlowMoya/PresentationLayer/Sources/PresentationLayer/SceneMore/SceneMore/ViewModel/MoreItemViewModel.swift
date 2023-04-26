//  
//  MoreItemViewModel.swift
//  
//
//  Created by TAE SU LEE on 2023/03/17.
//

import Foundation

struct MoreItemViewModel: Identifiable {
    let id = UUID()
    let title: String
}

extension MoreItemViewModel: Equatable {
    static func ==(lhs: MoreItemViewModel, rhs: MoreItemViewModel) -> Bool {
        return lhs.title == rhs.title
    }
}
