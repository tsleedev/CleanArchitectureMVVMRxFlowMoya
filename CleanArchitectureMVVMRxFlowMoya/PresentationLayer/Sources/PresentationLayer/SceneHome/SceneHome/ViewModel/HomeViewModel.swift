//  
//  HomeViewModel.swift
//  
//
//  Created by TAE SU LEE on 2023/03/06.
//

import TSCore
import DomainLayer
import Foundation
import RxSwift
import RxCocoa
import RxFlow

public final class HomeViewModel: DetectDeinit, Stepper {
    public let steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()
    
    // MARK: - Initialize with UseCase
    private let useCase: HomeUseCaseProtocol

    public init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }
}

// MARK: - ViewModelType
extension HomeViewModel: ViewModelType {
    public struct Input {
        let clickSettings: Driver<Void>
    }
    
    public struct Output {
        
    }
    
    public func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        input.clickSettings
            .drive(onNext: { [weak self] _ in
                self?.steps.accept(HomeStep.settingsAreRequired)
            })
            .disposed(by: disposeBag)
        
        return Output(
            
        )
    }
}
