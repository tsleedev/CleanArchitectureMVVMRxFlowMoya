//
//  SearchItemViewModel.swift
//  
//
//  Created by TAE SU LEE on 2022/11/15.
//

import TSCoreUI
import DomainLayer
import Foundation

public struct SearchItemViewModel: Equatable {
    public let fullName: String?
    public let avatarUrl: String?
    public let description: String?
    public let htmlUrl: String?
}

extension SearchItemViewModel {
    init(with search: Entities.Search) {
        fullName = search.fullName
        avatarUrl = search.avatarUrl
        description = search.description
        htmlUrl = search.htmlUrl
    }
}

// MARK: - Convert
extension SearchItemViewModel {
    func toThumbnailItemViewModel() -> ThumbnailItemViewModel {
        return ThumbnailItemViewModel(title: fullName,
                                      thumbnailUrl: avatarUrl,
                                      description: description)
    }
}
