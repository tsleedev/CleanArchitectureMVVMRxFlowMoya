//
//  GithubRepo.swift
//  
//
//  Created by TAE SU LEE on 2022/11/15.
//

import Foundation

public extension Entities {
    struct SearchItems {
        public let totalCount: Int?
        public let items: [Search]
        
        public init(totalCount: Int?, items: [Search]) {
            self.totalCount = totalCount
            self.items = items
        }
    }
    
    struct Search: Decodable {
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
}
