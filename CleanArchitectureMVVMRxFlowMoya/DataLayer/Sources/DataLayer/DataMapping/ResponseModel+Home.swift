//  
//  ResponseModel+Home.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2023/03/14.
//

import DomainLayer
import RxSwift

extension ResponseModel {
    struct HomeItems {
        let items: [Home]
    }
    
    struct HomeItem {
        let item: [Home]
    }
    
    struct Home {
        public let title: String

        public init(title: String) {
            self.title = title
        }
    }
}

extension ResponseModel.Home {
    func toDomain() -> Entities.Home {
        return .init(title: title)
    }
}
