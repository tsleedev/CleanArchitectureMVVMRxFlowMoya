//  ___FILEHEADER___

import TSCore
import DomainLayer
import Foundation
import RxSwift
import RxCocoa
import RxFlow

public final class ___VARIABLE_productName:identifier___ViewModel:  DetectDeinit, Stepper {
    public let steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()
    
    private let items = BehaviorSubject<[___VARIABLE_productName:identifier___ItemViewModel]>(value: [])
    
    // MARK: - Initialize with UseCase
    private let useCase: ___VARIABLE_productName:identifier___UseCaseProtocol

    public init(useCase: ___VARIABLE_productName:identifier___UseCaseProtocol) {
        self.useCase = useCase
    }
}

// MARK: - ViewModelType
extension ___VARIABLE_productName:identifier___ViewModel: ViewModelType {
    public struct Input {
        let trigger = PublishSubject<Void>()
        let flowCompleted = PublishSubject<Void>()
    }
    
    public struct Output {
        let items: BehaviorSubject<[___VARIABLE_productName:identifier___ItemViewModel]>
        let fetching: Driver<Bool>
        let error: Driver<Error>
    }
    
    public func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        input.trigger
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMapLatest { [weak self] _ -> Observable<[___VARIABLE_productName:identifier__ItemViewModel]> in
                guard let self = self else { return .empty() }
                return self.useCase.readItems()
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .map { $0.map { ___VARIABLE_productName:identifier__ItemViewModel(title: $0.title) } }
            }
            .subscribe(onNext: { [weak self] items in
                guard let self = self else { return }
                self.items = items
            })
            .disposed(by: disposeBag)
        
        input.flowCompleted
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.steps.accept(___VARIABLE_productName:identifier___Step.flowCompleted)
            })
            .disposed(by: disposeBag)
        
        return Output(
            items: items.asObserver(),
            fetching: activityIndicator.asDriver(),
            error: errorTracker.asDriver()
        )
    }
}
