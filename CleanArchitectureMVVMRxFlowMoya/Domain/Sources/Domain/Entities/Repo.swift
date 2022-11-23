//
//  GithubRepo.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/15.
//

import Foundation

public struct Repo: Equatable {
    public let fullName: String?
    public let avatarUrl: String?
    public let description: String?
    public let htmlUrl: String?
    
    public init(fullName: String?, avatarUrl: String?, description: String?, htmlUrl: String?) {
        self.fullName = fullName
        self.avatarUrl = avatarUrl
        self.description = description
        self.htmlUrl = htmlUrl
    }
}

public struct ReposPage: Equatable {
    public let totalCount: Int?
    public let repos: [Repo]?
    
    public init(totalCount: Int?, repos: [Repo]?) {
        self.totalCount = totalCount
        self.repos = repos
    }
}
