//  ___FILEHEADER___

import DomainLayer
import Foundation
import RxSwift

extension ResponseModel {
    struct ___VARIABLE_productName:identifier___Items: Decodable {
        let items: [___VARIABLE_productName:identifier___]
    }
    
    struct ___VARIABLE_productName:identifier___Item: Decodable {
        let item: ___VARIABLE_productName:identifier___
    }
    
    struct ___VARIABLE_productName___: Decodable {
//        let title: String
    }
}

// MARK: - DomainConvertible
extension ResponseModel.___VARIABLE_productName:identifier___: DomainConvertible {
    func toDomain() -> Entities.___VARIABLE_productName:identifier___ {
        return .init()
    }
}
