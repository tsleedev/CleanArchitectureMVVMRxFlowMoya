//  
//  ResponseModel+Home.swift
//  
//
//  Created by TAE SU LEE on 2023/03/14.
//

import DomainLayer
import RxSwift

extension ResponseModel {
    struct HomeItems: Decodable {
        let items: [Home]
    }
    
    struct HomeItem: Decodable {
        let item: Home
    }
    
    struct Home: Decodable {
        let title: String
    }
}

extension ResponseModel.Home {
    func toDomain() -> Entities.Home {
        return .init(title: title)
    }
}
