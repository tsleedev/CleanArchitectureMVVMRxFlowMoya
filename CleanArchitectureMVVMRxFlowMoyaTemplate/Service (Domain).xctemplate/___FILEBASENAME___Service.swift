//  ___FILEHEADER___

import TSCore
import Foundation
import RxSwift

public final class ___VARIABLE_productName:identifier___Service: DetectDeinit {
    public var disposeBag = DisposeBag()
    
    // MARK: - Initialize with UseCase
    private let useCase: ___VARIABLE_productName:identifier___UseCaseProtocol

    public init(useCase: ___VARIABLE_productName:identifier___UseCaseProtocol) {
        self.useCase = useCase
    }
}
