//  
//  ResponseModel+Settings.swift
//  
//
//  Created by TAE SU LEE on 2023/03/20.
//

import DomainLayer
import RxSwift

extension ResponseModel {
    struct SettingsItems: Decodable {
        let items: [Settings]
    }
    
    struct SettingsItem: Decodable {
        let item: Settings
    }
    
    struct Settings: Decodable {
        public let title: String

        public init(title: String) {
            self.title = title
        }
    }
}

extension ResponseModel.Settings {
    func toDomain() -> Entities.Settings {
        return .init(title: title)
    }
}
