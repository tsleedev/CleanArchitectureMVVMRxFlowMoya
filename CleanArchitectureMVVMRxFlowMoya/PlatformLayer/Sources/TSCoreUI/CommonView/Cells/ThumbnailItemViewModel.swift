//
//  ThumbnailItemViewModel.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/15.
//

import Foundation

public struct ThumbnailItemViewModel {
    let title: String?
    let thumbnailUrl: String?
    let description: String?
    
    public init(title: String?, thumbnailUrl: String?, description: String?) {
        self.title = title
        self.thumbnailUrl = thumbnailUrl
        self.description = description
    }
}
