//  
//  SettingsViewModel.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2023/03/20.
//

import TSCore
import DomainLayer
import Foundation
import RxSwift
import RxCocoa
import RxFlow

public final class SettingsViewModel: DetectDeinit, Stepper, ObservableObject {
    @Published var items: [SettingsItemViewModel] = []
    
    public let steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()
    
    // MARK: - Initialize with UseCase
    private let useCase: SettingsUseCaseProtocol

    public init(useCase: SettingsUseCaseProtocol) {
        self.useCase = useCase
    }
}

// MARK: - ViewModelSwiftUIType
extension SettingsViewModel: ViewModelSwiftUIType {
    public struct Input {
        let trigger = PublishSubject<Void>()
        let flowCompleted = PublishSubject<Void>()
    }
    
    public func transform(input: Input) {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        input.trigger
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMapLatest { [weak self] _ -> Observable<[SettingsItemViewModel]> in
                guard let self = self else { return .empty() }
                return self.useCase.readItems()
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .map { $0.map { SettingsItemViewModel(title: $0.title) } }
            }
            .subscribe(onNext: { [weak self] items in
                guard let self = self else { return }
                self.items = items
            })
            .disposed(by: disposeBag)
        
        input.flowCompleted
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.steps.accept(SettingsStep.mainIsComplete)
            })
            .disposed(by: disposeBag)
    }
}
