//  
//  RequestModel+Search.swift
//  
//
//  Created by TAE SU LEE on 2023/03/14.
//

import Foundation

public extension RequestModel {
    struct Search: Encodable {
        let query: String
        let page: Int
        let perPage: Int
        
        enum CodingKeys: String, CodingKey {
            case query = "q"
            case page
            case perPage = "per_page"
        }
    }
}
