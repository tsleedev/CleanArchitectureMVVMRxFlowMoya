//  
//  MoreViewModel.swift
//  
//
//  Created by TAE SU LEE on 2023/03/17.
//

import TSCore
import DomainLayer
import Foundation
import RxSwift
import RxCocoa
import RxFlow

public final class MoreViewModel: DetectDeinit, Stepper, ObservableObject {
    @Published var items: [MoreItemViewModel] = []
    
    public let steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()
    
    // MARK: - Initialize with UseCase
    private let useCase: MoreUseCaseProtocol

    public init(useCase: MoreUseCaseProtocol) {
        self.useCase = useCase
    }
}

// MARK: - ViewModelSwiftUIType
extension MoreViewModel: ViewModelSwiftUIType {
    public struct Input {
        let trigger = PublishSubject<Void>()
        let didSelect = PublishSubject<MoreItemViewModel>()
        let clickSettings = PublishSubject<Void>()
    }
    
    public func transform(input: Input) {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        input.trigger
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMapLatest { [weak self] _ -> Observable<[MoreItemViewModel]> in
                guard let self = self else { return .empty() }
                return self.useCase.readItems()
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .map { $0.map { MoreItemViewModel(title: $0.title) } }
            }
            .subscribe(onNext: { [weak self] items in
                guard let self = self else { return }
                self.items = items
            })
            .disposed(by: disposeBag)
        
        input.didSelect
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.steps.accept(MoreStep.detailIsRequired)
            })
            .disposed(by: disposeBag)
        
        input.clickSettings.asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] _ in
                self?.steps.accept(MoreStep.settingsAreRequired)
            })
            .disposed(by: disposeBag)
    }
}
