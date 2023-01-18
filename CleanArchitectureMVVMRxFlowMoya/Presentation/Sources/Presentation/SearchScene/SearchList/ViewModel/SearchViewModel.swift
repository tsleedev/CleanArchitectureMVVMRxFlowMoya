//
//  SearchViewModel.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/15.
//

import TSCore
import TSLogger
import Domain
import Foundation
import RxSwift
import RxCocoa
import RxFlow

final public class SearchViewModel: DetectDeinit, ViewModelType, Stepper {
    
    public let steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()
    
    private let repos = BehaviorSubject<[SearchItemViewModel]>(value: [])
    private var pageIndex: Int = 1
    private var isAllLoaded = false
    
    public struct Input {
        let query: Driver<String>
        let didSelectCell: Driver<SearchItemViewModel>
        let loadNextPageTrigger = PublishSubject<Void>()
    }
    
    public struct Output {
        let repos: BehaviorSubject<[SearchItemViewModel]>
        let fetching: Driver<Bool>
        let page: Driver<Int>
        let error: Driver<Error>
    }
    
    private let searchReposUseCase: SearchReposUseCaseProtocol
    
    public init(searchReposUseCase: SearchReposUseCaseProtocol) {
        self.searchReposUseCase = searchReposUseCase
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
                return self.searchReposUseCase
                    .excute(query: query, page: page, perPage: Constants.perPage)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .catchAndReturn(ReposPage(totalCount: 0, repos: []))
                    .map { $0.repos?.compactMap { SearchItemViewModel(with: $0) } ?? [] }
            }
        }
            .share(replay: 1)
        
        Observable
            .combineLatest(request, response, repos.asObservable()) { [weak self] request, response, repos in
                Log.debug("response page: \(request.0) query: \(request.1) preItemCount: \(repos.count) currentItemCount: \(response.count)")
                self?.isAllLoaded = response.count < Constants.perPage
                return request.0 == 1 ? response : repos + response
            }
            .sample(response)
            .do(onNext: { Log.debug("response item count \($0.count)") })
            .bind(to: repos)
            .disposed(by: disposeBag)
        
        let fetching = activityIndicator.asDriver()
        let page = pageMerge.sample(response).asDriver(onErrorJustReturn: 1)
        
        input.didSelectCell
            .drive(onNext: { [weak self] viewModel in
                self?.steps.accept(SearchStep.detail(viewModel: viewModel))
            })
            .disposed(by: disposeBag)
        
        return Output(
            repos: repos.asObserver(),
            fetching: fetching,
            page: page,
            error: errorTracker.asDriver()
        )
    }
}
