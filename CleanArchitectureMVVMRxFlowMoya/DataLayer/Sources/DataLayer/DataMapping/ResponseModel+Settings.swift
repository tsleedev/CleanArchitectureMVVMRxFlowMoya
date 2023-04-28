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
        let title: String
    }
}

extension ResponseModel.Settings {
    func toDomain() -> Entities.Settings {
        return .init(title: title)
    }
}
