//  
//  ResponseModel+Search.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2023/03/14.
//

import DomainLayer
import RxSwift

extension ResponseModel {
    struct SearchItems: Decodable {
        let totalCount: Int?
        let items: [Search]
        
        private enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
            case items
        }
    }
    
    struct SearchItem: Decodable {
        let item: Search
    }
    
    struct Search: Decodable {
        let fullName: String?
        let description: String?
        let htmlUrl: String?
        let owner: Owner?
        
        private enum CodingKeys: String, CodingKey {
            case fullName = "full_name"
            case description
            case htmlUrl = "html_url"
            case owner
        }
    }
        
    struct Owner: Decodable {
        let avatarUrl: String?
        
        private enum CodingKeys: String, CodingKey {
            case avatarUrl = "avatar_url"
        }
    }
}

extension ResponseModel.SearchItems {
    func toDomain() -> Entities.SearchItems {
        return .init(totalCount: totalCount,
                     items: items.map { $0.toDomain() })
    }
}

extension ResponseModel.Search {
    func toDomain() -> Entities.Search {
        return .init(fullName: fullName,
                     avatarUrl: owner?.avatarUrl,
                     description: description,
                     htmlUrl: htmlUrl)
    }
}
