//
//  File.swift
//  
//
//  Created by TAE SU LEE on 2023/03/13.
//

import DomainLayer
import RxSwift

extension ResponseModel {
    struct MoreItems: Decodable {
        let items: [More]
    }
    
    struct MoreItem: Decodable {
        let item: [More]
    }
    
    struct More: Decodable {
        let title: String
    }
}

extension ResponseModel.More {
    func toDomain() -> Entities.More {
        return .init(title: title)
    }
}
