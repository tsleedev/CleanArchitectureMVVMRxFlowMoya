//  ___FILEHEADER___

import DomainLayer
import RxSwift

extension ResponseModel {
    struct ___VARIABLE_productName:identifier___Items: Decodable {
        let items: [___VARIABLE_productName:identifier___]
    }
    
    struct ___VARIABLE_productName:identifier___Item: Decodable {
        let item: ___VARIABLE_productName:identifier___
    }
    
    struct ___VARIABLE_productName___: Decodable {
//        public let title: String
//
//        public init(title: String) {
//            self.title = title
//        }
    }
}

extension ResponseModel.___VARIABLE_productName:identifier___ {
    func toDomain() -> Entities.___VARIABLE_productName:identifier___ {
        return .init()
    }
}
