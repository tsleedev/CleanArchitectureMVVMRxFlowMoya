//
//  ReposDTO.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import Foundation
import Domain

struct ReposResponseDTO: Decodable {
    let totalCount: Int?
    let repos: [RepoDTO]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case repos = "items"
    }
}

extension ReposResponseDTO {
    struct RepoDTO: Decodable {
        let fullName: String?
        let description: String?
        let htmlUrl: String?
        let owner: OwnerDTO?
        
        enum CodingKeys: String, CodingKey {
            case fullName = "full_name"
            case description
            case htmlUrl = "html_url"
            case owner
        }
    }
    
    struct OwnerDTO: Decodable {
        let avatarUrl: String?
        
        enum CodingKeys: String, CodingKey {
            case avatarUrl = "avatar_url"
        }
    }
}

extension ReposResponseDTO {
    func toDomain() -> ReposPage {
        return .init(totalCount: totalCount,
                     repos: repos.map { $0.toDomain() })
    }
}

extension ReposResponseDTO.RepoDTO {
    func toDomain() -> Repo {
        return .init(fullName: fullName,
                     avatarUrl: owner?.avatarUrl,
                     description: description,
                     htmlUrl: htmlUrl)
    }
}
