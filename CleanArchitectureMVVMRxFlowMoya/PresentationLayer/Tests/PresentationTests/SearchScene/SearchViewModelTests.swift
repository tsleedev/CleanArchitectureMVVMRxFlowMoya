//
//  SearchViewModelTests.swift
//  
//
//  Created by TAE SU LEE on 2022/11/20.
//

import TSCore
import TSTestUtility
import DomainLayer
import XCTest
import RxSwift
import RxFlow
import RxTest
@testable import PresentationLayer

class SearchViewModelTests: XCTestCase {
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    private var viewModel: SearchViewModel!
    private var querySubject: PublishSubject<String>!
    private var didSelectCell: PublishSubject<SearchItemViewModel>!
    private var input: SearchViewModel.Input!
    private var output: SearchViewModel.Output!
    
    private func setupTest(searchItems: [Entities.SearchItems], shouldReturnError: Bool) {
        let searchUseCaseMock = SearchUseCaseMock(searchItems: searchItems, shouldReturnError: shouldReturnError)
        viewModel = SearchViewModel(useCase: searchUseCaseMock)

        querySubject = PublishSubject()
        didSelectCell = PublishSubject()
        input = SearchViewModel.Input(query: querySubject.asDriver(onErrorDriveWith: .empty()),
                                      didSelectCell: didSelectCell.asDriver(onErrorDriveWith: .empty()))
        output = viewModel.transform(input: input)
    }
    
    override func setUpWithError() throws {
        scheduler = TestScheduler(initialClock: 0) // Process all events synchronously
        disposeBag = DisposeBag()
    }
    
    func testSearchWithPagination() {
        let searchItems: [Entities.SearchItems] = {
            let totalCount = 21
            let page1 = Entities.SearchItems(totalCount: totalCount,
                                             items: (1...20).map { Entities.Search(fullName: "title\($0)", avatarUrl: nil, description: "description\($0)", htmlUrl: nil) })
            let page2 = Entities.SearchItems(totalCount: totalCount,
                                             items: [Entities.Search(fullName: "title21", avatarUrl: nil, description: "description21", htmlUrl: nil)])
            return [page1, page2]
        }()
        
        setupTest(searchItems: searchItems, shouldReturnError: false)
        
        let items = scheduler.createObserver([SearchItemViewModel].self)
        let expectedItems = [
            [],
            searchItems[0].items.compactMap { SearchItemViewModel(with: $0) },
            searchItems[1].items.compactMap { SearchItemViewModel(with: $0) }
        ]
        
        scheduler.createColdObservable([
            .next(10, "title")
        ])
        .bind(to: querySubject)
        .disposed(by: disposeBag)

        scheduler.createColdObservable([
            .next(20, ())
        ])
        .bind(to: input.loadNextPageTrigger)
        .disposed(by: disposeBag)
        
        output.items
            .asDriver(onErrorDriveWith: .empty())
            .drive(items)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let actualEvents = items.events
        let expectedEvents: [Recorded<Event<[SearchItemViewModel]>>] = [
            .next(0, expectedItems[0]),
            .next(10, expectedItems[1]),
            .next(20, expectedItems[1] + expectedItems[2])
        ]
                
        for (index, actualEvent) in actualEvents.enumerated() {
            let expectedEvent = expectedEvents[index]
            XCTAssertEqual(actualEvent, expectedEvent, printError(index: index, expectedEvent: expectedEvent, actualEvent: actualEvent))
        }
    }
    
    func testSearchWithNoResults() {
        let searchItems: [Entities.SearchItems] = [
            Entities.SearchItems(totalCount: 0, items: [])
        ]
        
        setupTest(searchItems: searchItems, shouldReturnError: false)
        
        let items = scheduler.createObserver([SearchItemViewModel].self)
        let expectedItems: [[SearchItemViewModel]] = [[]]
        
        scheduler.createColdObservable([
            .next(10, "noresults")
        ])
        .bind(to: querySubject)
        .disposed(by: disposeBag)
        
        output.items
            .asDriver(onErrorDriveWith: .empty())
            .drive(items)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let actualEvents = items.events
        let expectedEvents: [Recorded<Event<[SearchItemViewModel]>>] = [
            .next(0, expectedItems[0]),
            .next(10, expectedItems[0])
        ]
                
        for (index, actualEvent) in actualEvents.enumerated() {
            let expectedEvent = expectedEvents[index]
            XCTAssertEqual(actualEvent, expectedEvent, printError(index: index, expectedEvent: expectedEvent, actualEvent: actualEvent))
        }
    }
    
    func testSearchWithError() {
        let searchItems: [Entities.SearchItems] = [
            Entities.SearchItems(totalCount: 0, items: [])
        ]
        
        setupTest(searchItems: searchItems, shouldReturnError: true)
        
        let items = scheduler.createObserver([SearchItemViewModel].self)
        let expectedItems: [[SearchItemViewModel]] = [[]]
        
        let error = scheduler.createObserver(APIError.self)
        
        scheduler.createColdObservable([
            .next(10, "errorSearch")
        ])
        .bind(to: querySubject)
        .disposed(by: disposeBag)
        
        output.items
            .asDriver(onErrorDriveWith: .empty())
            .drive(items)
            .disposed(by: disposeBag)
        
        output.error
            .asDriver(onErrorDriveWith: .empty())
            .drive(error)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let actualEvents = items.events
        let expectedEvents: [Recorded<Event<[SearchItemViewModel]>>] = [
            .next(0, expectedItems[0]),
            .next(10, expectedItems[0])
        ]
        
        let actualErrorEvents = error.events
        let expectedErrorEvents: [Recorded<Event<APIError>>] = [
            .next(10, .unknown)
        ]
        
        XCTAssertEqual(actualEvents, expectedEvents, printError(msg: "items", expectedEvent: expectedEvents, actualEvent: actualEvents))
        XCTAssertEqual(actualErrorEvents, expectedErrorEvents, printError(msg: "errors", expectedEvent: expectedErrorEvents, actualEvent: actualErrorEvents))
    }
    
    func testCellSelectionTriggersDetailStep() {
        let searchItems: [Entities.SearchItems] = [
            Entities.SearchItems(totalCount: 1,
                                 items: [Entities.Search(fullName: "title1", avatarUrl: nil, description: "description1", htmlUrl: nil)])
        ]
        
        setupTest(searchItems: searchItems, shouldReturnError: false)

        let expectedViewModel = SearchItemViewModel(with: searchItems[0].items[0])

        // Record steps
        let steps = scheduler.createObserver(Step.self)
        viewModel.steps
            .asSignal(onErrorSignalWith: .empty())
            .emit(to: steps)
            .disposed(by: disposeBag)

        // Trigger cell selection
        scheduler.createColdObservable([
            .next(10, expectedViewModel)
        ])
        .bind(to: didSelectCell)
        .disposed(by: disposeBag)

        scheduler.start()

        // Check if the correct step is emitted
        let actualEvents = steps.events
        let expectedEvents: [Recorded<Event<Step>>] = [
            .next(10, SearchStep.detailIsRequired(viewModel: expectedViewModel))
        ]

        for (index, actualEvent) in actualEvents.enumerated() {
            let expectedEvent = expectedEvents[index]
            XCTAssertTrue(areEqual(actualEvent.value.element!, expectedEvent.value.element!), printError(index: index, expectedEvent: expectedEvent, actualEvent: actualEvent))
        }
        
        func areEqual(_ lhs: Step, _ rhs: Step) -> Bool {
            switch (lhs, rhs) {
            case let (lhs as SearchStep, rhs as SearchStep):
                switch (lhs, rhs) {
                case (.detailIsRequired(let lhsViewModel), .detailIsRequired(let rhsViewModel)):
                    return lhsViewModel == rhsViewModel
                default:
                    return false
                }
            default:
                return false
            }
        }
    }
    
    func testSearchQueryChangeUpdatesResults() {
        let searchItems: [Entities.SearchItems] = [
            Entities.SearchItems(totalCount: 2,
                                 items: [
                                    Entities.Search(fullName: "title1", avatarUrl: nil, description: "description1", htmlUrl: nil),
                                    Entities.Search(fullName: "title2", avatarUrl: nil, description: "description2", htmlUrl: nil)
                                 ])
        ]
        
        setupTest(searchItems: searchItems, shouldReturnError: false)

        let items = scheduler.createObserver([SearchItemViewModel].self)
        let expectedItems: [[SearchItemViewModel]] = [
            [],
            searchItems[0].items.compactMap { SearchItemViewModel(with: $0) },
            searchItems[0].items.compactMap { SearchItemViewModel(with: $0) }.filter { $0.fullName == "title1" }
        ]

        // Perform search with initial query
        scheduler.createColdObservable([
            .next(10, "title")
        ])
        .bind(to: querySubject)
        .disposed(by: disposeBag)

        // Change search query
        scheduler.createColdObservable([
            .next(20, "title1")
        ])
        .bind(to: querySubject)
        .disposed(by: disposeBag)

        output.items
            .asDriver(onErrorDriveWith: .empty())
            .drive(items)
            .disposed(by: disposeBag)

        scheduler.start()

        let actualEvents = items.events
        let expectedEvents: [Recorded<Event<[SearchItemViewModel]>>] = [
            .next(0, expectedItems[0]),
            .next(10, expectedItems[1]),
            .next(20, expectedItems[1]),
            .next(20, expectedItems[2])
        ]

        for (index, actualEvent) in actualEvents.enumerated() {
            let expectedEvent = expectedEvents[index]
            XCTAssertEqual(actualEvent, expectedEvent, printError(index: index, expectedEvent: expectedEvent, actualEvent: actualEvent))
        }
    }
    
    func testLoadingIndicator() {
        // Setup
        let searchItems: [Entities.SearchItems] = [
            Entities.SearchItems(totalCount: 1,
                                 items: [Entities.Search(fullName: "title1", avatarUrl: nil, description: "description1", htmlUrl: nil)])
        ]
        
        setupTest(searchItems: searchItems, shouldReturnError: false)

        let isLoading = scheduler.createObserver(Bool.self)
        
        output.isLoading
            .asDriver(onErrorDriveWith: .empty())
            .drive(isLoading)
            .disposed(by: disposeBag)
        
        // Perform search
        scheduler.createColdObservable([
            .next(10, "query")
        ])
        .bind(to: querySubject)
        .disposed(by: disposeBag)

        scheduler.start()
        
        // Verify
        let actualEvents = isLoading.events
        let expectedEvents: [Recorded<Event<Bool>>] = [
            .next(0, false),   // Initial state
            .next(10, true),   // Search starts
            .next(10, false)   // Search completes
        ]

        for (index, actualEvent) in actualEvents.enumerated() {
            let expectedEvent = expectedEvents[index]
            XCTAssertEqual(actualEvent, expectedEvent, printError(index: index, expectedEvent: expectedEvent, actualEvent: actualEvent))
        }
    }
}
