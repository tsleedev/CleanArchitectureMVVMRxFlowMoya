//  ___FILEHEADER___

import TSCore
import DomainLayer
import Foundation
import RxSwift
import RxCocoa
import RxFlow

public final class ___VARIABLE_productName:identifier___ViewModel: DetectDeinit, Stepper, ObservableObject {
    @Published var items: [___VARIABLE_productName:identifier___ItemViewModel] = []
    
    public let steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()
    
    // MARK: - Initialize with UseCase
    private let useCase: ___VARIABLE_productName:identifier___UseCaseProtocol

    public init(useCase: ___VARIABLE_productName:identifier___UseCaseProtocol) {
        self.useCase = useCase
    }
}

// MARK: - ViewModelSwiftUIType
extension ___VARIABLE_productName:identifier___ViewModel: ViewModelSwiftUIType {
    public struct Input {
        let trigger = PublishSubject<Void>()
        let flowCompleted = PublishSubject<Void>()
    }
    
    public func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        input.trigger
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMapLatest { [weak self] _ -> Observable<[___VARIABLE_productName:identifier___ItemViewModel]> in
                guard let self = self else { return .empty() }
                return self.useCase.readItems()
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .map { $0.map { ___VARIABLE_productName:identifier___ItemViewModel(title: $0.title) } }
            }
            .bind(to: items)
            .disposed(by: disposeBag)
        
        input.flowCompleted
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.steps.accept(___VARIABLE_productName:identifier___Step.flowCompleted)
            })
            .disposed(by: disposeBag)
    }
}
