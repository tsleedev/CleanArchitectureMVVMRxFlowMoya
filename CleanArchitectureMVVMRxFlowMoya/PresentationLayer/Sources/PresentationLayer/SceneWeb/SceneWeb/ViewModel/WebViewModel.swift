//
//  File.swift
//  
//
//  Created by TAE SU LEE on 2022/11/20.
//

import TSCore
import Foundation
import RxSwift
import RxCocoa
import RxFlow

public class WebViewModel: DetectDeinit, Stepper {
    public let steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()
    
    // MARK: - Initialize with UseCase
    private let itemViewModel: WebItemViewModel
    
    public init(itemViewModel: WebItemViewModel) {
        self.itemViewModel = itemViewModel
    }
}

// MARK: - ViewModelType
extension WebViewModel: ViewModelType {
    public struct Input { }
    
    public struct Output {
        let title: String?
        let startUrl: String?
    }
    
    public func transform(input: Input) -> Output {
        return Output(
            title: itemViewModel.title,
            startUrl: itemViewModel.startUrl
        )
    }
}
