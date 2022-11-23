//
//  SearchViewModelTests.swift
//  
//
//  Created by TAE SU LEE on 2022/11/20.
//

import XCTest
import Domain
import RxSwift
import RxTest
@testable import Presentation

class SearchViewModelTests: XCTestCase {
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    var viewModel: SearchViewModel!
    var querySubject: PublishSubject<String>!
    var didSelectCell: PublishSubject<SearchItemViewModel>!
    var input: SearchViewModel.Input!
    var output: SearchViewModel.Output!
    
    let reposPages: [ReposPage] = {
        let page1 = ReposPage(totalCount: 21, repos:
            (1...20).map { Repo(fullName: "title\($0)", avatarUrl: nil, description: "description\($0)", htmlUrl: nil) }
        )
        let page2 = ReposPage(totalCount: 21, repos: [
            Repo(fullName: "title21", avatarUrl: nil, description: "description21", htmlUrl: nil)
        ])
        return [page1, page2]
    }()
    
    class SearchReposUseCaseMock: SearchReposUseCaseProtocol {
        var reposPages: [ReposPage] = []
        
        func excute(query: String, page: Int, perPage: Int) -> Single<ReposPage> {
            return Single.just(reposPages[page-1])
        }
    }
    
    override func setUpWithError() throws {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        
        let searchReposUseCaseMock = SearchReposUseCaseMock()
        searchReposUseCaseMock.reposPages = reposPages
        viewModel = SearchViewModel(searchReposUseCase: searchReposUseCaseMock)
        
        querySubject = PublishSubject()
        didSelectCell = PublishSubject()
        input = SearchViewModel.Input(query: querySubject.asDriver(onErrorDriveWith: .empty()),
                                      didSelectCell: didSelectCell.asDriver(onErrorDriveWith: .empty()))
        output = viewModel.transform(input: input)
    }
    
    func testWhenSearchReposUseCase() {
        let repos = scheduler.createObserver([SearchItemViewModel].self)
        let expectedRepos = [
            [],
            reposPages[0].repos?.compactMap { SearchItemViewModel(with: $0) } ?? [],
            reposPages[1].repos?.compactMap { SearchItemViewModel(with: $0) } ?? []
        ]
        
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = expectedRepos.count
        
        scheduler.createColdObservable([
            .next(1, "RxSwift")
        ])
        .bind(to: querySubject)
        .disposed(by: disposeBag)

        scheduler.createColdObservable([
            .next(2, ())
        ])
        .debug("scheduler1")
        .bind(to: input.loadNextPageTrigger)
        .disposed(by: disposeBag)
        
        output.repos
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: {
                print("repos \($0.count)")
                repos.onNext($0)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(repos.events, [
            .next(0, expectedRepos[0]),
            .next(1, expectedRepos[1]),
            .next(2, expectedRepos[1] + expectedRepos[2])
        ])
        
        wait(for: [expectation], timeout: 1.0)
    }
}
