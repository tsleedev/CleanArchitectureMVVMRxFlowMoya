//
//  Entities+Search+toItem.swift
//  
//
//  Created by TAE SU LEE on 2023/06/07.
//

import DomainLayer
import Foundation

extension Entities.Search {
    func toItem() -> SearchItemViewModel {
        return .init(fullName: fullName,
                     avatarUrl: avatarUrl,
                     description: description,
                     htmlUrl: htmlUrl)
    }
}
