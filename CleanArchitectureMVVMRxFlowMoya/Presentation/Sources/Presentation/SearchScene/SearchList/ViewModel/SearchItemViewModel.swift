//
//  SearchItemViewModel.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/15.
//

import TSCoreUI
import Domain
import Foundation

public struct SearchItemViewModel: Equatable {
    public let fullName: String?
    public let avatarUrl: String?
    public let description: String?
    public let htmlUrl: String?
}

extension SearchItemViewModel {
    init(with repo: Repo) {
        fullName = repo.fullName
        avatarUrl = repo.avatarUrl
        description = repo.description
        htmlUrl = repo.htmlUrl
    }
    
    func convertThumbnailViewModel() -> ThumbnailViewModel {
        return ThumbnailViewModel(title: fullName,
                                  thumbnailUrl: avatarUrl,
                                  description: description)
    }
}
