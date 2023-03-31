//
//  SearchViewModel.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/15.
//

import Utils
import TSCore
import TSLogger
import DomainLayer
import Foundation
import RxSwift
import RxCocoa
import RxFlow

public final class SearchViewModel: DetectDeinit, Stepper {
    public let steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()
    
    private let items = BehaviorSubject<[SearchItemViewModel]>(value: [])
    private var pageIndex: Int = 1
    private var isAllLoaded = false
    
    // MARK: - Initialize with UseCase
    private let useCase: SearchUseCaseProtocol
    
    public init(useCase: SearchUseCaseProtocol) {
        self.useCase = useCase
    }
}

// MARK: - ViewModelType
extension SearchViewModel: ViewModelType {
    public struct Input {
        let query: Driver<String>
        let didSelectCell: Driver<SearchItemViewModel>
        let loadNextPageTrigger = PublishSubject<Void>()
    }
    
    public struct Output {
        let items: BehaviorSubject<[SearchItemViewModel]>
        let isLoading: Driver<Bool>
        let page: Driver<Int>
        let error: Driver<APIError>
    }
    
    public func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let queryRequest = activityIndicator.asObservable()
            .sample(input.query.asObservable())
            .flatMap { loading -> Observable<Int> in
                if loading {
                    return Observable.empty()
                } else {
                    return Observable<Int>.create { [weak self] observer in
                        guard let self = self else { return Disposables.create() }
                        self.pageIndex = 1
                        observer.onNext(self.pageIndex)
                        observer.onCompleted()
                        return Disposables.create()
                    }
                }
            }
        
        let nextPageRequest = activityIndicator.asObservable()
            .sample(input.loadNextPageTrigger)
            .flatMap { [weak self] loading -> Observable<Int> in
                if loading {
                    return Observable.empty()
                } else {
                    guard self?.isAllLoaded == false else { return Observable.empty() }
                    
                    return Observable<Int>.create { [weak self] observer in
                        guard let self = self else { return Disposables.create() }
                        self.pageIndex += 1
                        observer.onNext(self.pageIndex)
                        observer.onCompleted()
                        return Disposables.create()
                    }
                }
            }
        
        let pageMerge = Observable.merge(queryRequest, nextPageRequest)
            .share(replay: 1)
        
        let request = Observable.combineLatest(pageMerge, input.query.asObservable())
            .share(replay: 1)
        
        let response = request.flatMapLatest { [weak self] (page, query) -> Observable<[SearchItemViewModel]> in
            guard let self = self else { return Observable.empty() }
            if query.isEmpty {
                return Observable.just([])
            } else {
                return self.useCase
                    .readItems(Params.Search(query: query, page: page, perPage: Constants.perPage))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .catchAndReturn(Entities.SearchItems(totalCount: 0, items: []))
                    .map { $0.items.compactMap { SearchItemViewModel(with: $0) } }
            }
        }
            .share(replay: 1)
        
        Observable
            .combineLatest(request, response, items.asObservable()) { [weak self] request, response, repos in
                TSLogger.debug("response page: \(request.0) query: \(request.1) preItemCount: \(repos.count) currentItemCount: \(response.count)")
                self?.isAllLoaded = response.count < Constants.perPage
                return request.0 == 1 ? response : repos + response
            }
            .sample(response)
            .do(onNext: { TSLogger.debug("response item count \($0.count)") })
            .bind(to: items)
            .disposed(by: disposeBag)
        
        input.didSelectCell
            .drive(onNext: { [weak self] viewModel in
                self?.steps.accept(SearchStep.detailIsRequired(viewModel: viewModel))
            })
            .disposed(by: disposeBag)
        
        let page = pageMerge.sample(response).asDriver(onErrorJustReturn: 1)
        let error = errorTracker.asDriver().map { $0 as? APIError ?? .unknown }
                
        return Output(
            items: items.asObserver(),
            isLoading: activityIndicator.asDriver(),
            page: page,
            error: error
        )
    }
}
