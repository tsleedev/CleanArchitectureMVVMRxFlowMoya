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

public class WebViewModel: DetectDeinit, ViewModelType, Stepper {
    
    public let steps = PublishRelay<Step>()
    
    public struct Input { }
    
    public struct Output {
        let title: String?
        let startUrl: String?
    }
    
    public var disposeBag = DisposeBag()
    
    private let webItemViewModel: WebItemViewModel
    
    public init(webItemViewModel: WebItemViewModel) {
        self.webItemViewModel = webItemViewModel
    }
    
    public func transform(input: Input) -> Output {
        return Output(
            title: webItemViewModel.title,
            startUrl: webItemViewModel.startUrl
        )
    }
}
