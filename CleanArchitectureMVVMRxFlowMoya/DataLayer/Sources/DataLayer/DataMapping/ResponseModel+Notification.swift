//  
//  ResponseModel+Notification.swift
//
//
//  Created by TAE SU LEE on 2023/04/27.
//

import DomainLayer
import RxSwift

extension ResponseModel {
    struct Notification: Decodable {
        let title: String?
        let body: String?
        let imageUrl: String?
        let targets: String?
        
        private enum RootCodingKeys: String, CodingKey {
            case aps
            case imageUrl
            case targets
            
            enum APSNestedCodingKeys: String, CodingKey {
                case alert
                
                enum AlertNestedCodingKeys: String, CodingKey {
                    case title
                    case body
                }
            }
        }
        
        init(from decoder: Decoder) throws {
            let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
            let apsContainer = try rootContainer.nestedContainer(keyedBy: RootCodingKeys.APSNestedCodingKeys.self, forKey: .aps)
            let alertContainer = try apsContainer.nestedContainer(keyedBy: RootCodingKeys.APSNestedCodingKeys.AlertNestedCodingKeys.self, forKey: .alert)
            
            title = try alertContainer.decode(String.self, forKey: .title)
            body = try alertContainer.decode(String.self, forKey: .body)
            imageUrl = try rootContainer.decode(String.self, forKey: .imageUrl)
            targets = try rootContainer.decode(String.self, forKey: .targets)
        }
    }
}

extension ResponseModel.Notification {
    func toDomain() -> Entities.Notification {
        return .init(title: title,
                     body: body,
                     imageUrl: imageUrl,
                     targets: targets)
    }
}

/*
{
    "aps":{
        "alert" : {
                 "title" : "Test title",
                 "body" : "Test body"
              },
        "sound":"default",
        "badge":1
    },
    "imageUrl": "imageUrl",
    "targets": "view:settings",
}
*/
