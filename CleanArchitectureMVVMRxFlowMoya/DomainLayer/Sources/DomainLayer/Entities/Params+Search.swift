//
//  Params+Search.swift
//  
//
//  Created by TAE SU LEE on 2023/03/14.
//

import Foundation

public extension Params {
    struct Search {
        public let query: String
        public let page: Int
        public let perPage: Int
        
        public init(query: String, page: Int, perPage: Int) {
            self.query = query
            self.page = page
            self.perPage = perPage
        }
    }
}
