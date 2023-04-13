//  ___FILEHEADER___

import TSCore
import DomainLayer
import RxSwift

public class ___VARIABLE_productName:identifier___RepositoryImp: DetectDeinit, ___VARIABLE_productName___Repository {
    
    private let service: ___VARIABLE_productName:identifier___APIService
    
    public init(service: ___VARIABLE_productName:identifier___APIService) {
        self.service = service
    }
    
//    public func readItems(_ param: Params.___VARIABLE_productName___) -> Single<[Entities.___VARIABLE_productName___]> {
//        let requestModel = RequestModel.___VARIABLE_productName___()
//        return service
//            .request(.readItems(requestDTO))
//            .map(ResponseModel.___VARIABLE_productName___Items.self)
//            .map { $0.items.map { $0.toDomain() } }
//    }
//
//    public func readItem(_ param: Params.___VARIABLE_productName___) -> Single<Entities.___VARIABLE_productName___> {
//        let requestModel = RequestModel.___VARIABLE_productName___()
//        return service
//            .request(.readItem(requestModel))
//            .map(ResponseModel.___VARIABLE_productName___Item.self)
//            .map { $0.toDomain() }
//    }
}
