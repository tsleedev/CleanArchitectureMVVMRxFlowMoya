//
//  SearchViewControllerTests.swift
//  
//
//  Created by TAE SU LEE on 2023/03/29.
//

import TSCore
import TSTestUtility
import DomainLayer
import XCTest
import RxSwift
import RxTest
@testable import PresentationLayer

class SearchViewControllerTests: XCTestCase {
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    var viewController: SearchViewController!
    var viewModel: SearchViewModel!

    private func setupTest(searchItems: [Entities.SearchItems], shouldReturnError: Bool) {
        let searchUseCaseMock = SearchUseCaseMock(searchItems: searchItems, shouldReturnError: shouldReturnError)
        viewModel = SearchViewModel(useCase: searchUseCaseMock)
        viewController = SearchViewController(viewModel: viewModel)
    }
    
    override func setUpWithError() throws {
        scheduler = TestScheduler(initialClock: 0) // Process all events synchronously
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        viewController = nil
        viewModel = nil
    }

    func testViewDidLoad() {
        let searchItems: [Entities.SearchItems] = [ Entities.SearchItems(totalCount: 0, items: []) ]
        setupTest(searchItems: searchItems, shouldReturnError: false)
        
        // Accessing the ViewController's view to implicitly call viewDidLoad()
        _ = viewController.view

        XCTAssertNotNil(viewController.view)
        XCTAssertNotNil(viewController.getSearchBar())
        XCTAssertNotNil(viewController.getTableView())
        XCTAssertNotNil(viewController.getActivityIndicatorView())
    }

    func testTableViewDataSource() {
        let searchItems: [Entities.SearchItems] = [ Entities.SearchItems(totalCount: 0, items: []) ]
        setupTest(searchItems: searchItems, shouldReturnError: false)
        
        _ = viewController.view

        XCTAssertNotNil(viewController.getTableView().dataSource)
        XCTAssertTrue(viewController.getTableView().dataSource is SearchViewController)
    }

    func testTableViewDelegate() {
        let searchItems: [Entities.SearchItems] = [ Entities.SearchItems(totalCount: 0, items: []) ]
        setupTest(searchItems: searchItems, shouldReturnError: false)
        
        _ = viewController.view

        XCTAssertNotNil(viewController.getTableView().delegate)
        XCTAssertTrue(viewController.getTableView().delegate is SearchViewController)
    }

    func testViewModelBinding() {
        let searchItems: [Entities.SearchItems] = {
            let totalCount = 21
            let page1 = Entities.SearchItems(totalCount: totalCount,
                                             items: (1...20).map { Entities.Search(fullName: "title\($0)", avatarUrl: nil, description: "description\($0)", htmlUrl: nil) }
            )
            let page2 = Entities.SearchItems(totalCount: totalCount,
                                             items: [Entities.Search(fullName: "title21", avatarUrl: nil, description: "description21", htmlUrl: nil)])
            return [page1, page2]
        }()
        setupTest(searchItems: searchItems, shouldReturnError: false)
        
        let testQuery = "title"
        let inputQuery = scheduler.createHotObservable([.next(10, testQuery)])
        let inputSelect = scheduler.createHotObservable([.next(20, SearchItemViewModel(with: searchItems[0].items[0]))])
        let inputTrigger = scheduler.createHotObservable([.next(30, ())])
        
        let input = SearchViewModel.Input(query: inputQuery.asDriver(onErrorJustReturn: ""),
                                          didSelectCell: inputSelect.asDriver(onErrorJustReturn: SearchItemViewModel(with: searchItems[0].items[0])))
        inputTrigger
            .bind(to: input.loadNextPageTrigger)
            .disposed(by: disposeBag)
        
        let output = viewModel.transform(input: input)
        
        let items = scheduler.createObserver([SearchItemViewModel].self)
        let expectedItems: [[SearchItemViewModel]] = [
            [],
            searchItems[0].items.compactMap { SearchItemViewModel(with: $0) },
            searchItems[1].items.compactMap { SearchItemViewModel(with: $0) }
        ]
        
        output.items.asObservable()
            .bind(to: items)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let actualEvents = items.events
        let expectedEvents: [Recorded<Event<[SearchItemViewModel]>>] = [
            .next(0, expectedItems[0]), // Initially, an empty array should be emitted
            .next(10, expectedItems[1]), // The search results should be emitted
            .next(30, expectedItems[1] + expectedItems[2]) // The search results for the next page should be emitted
        ]
        
        for (index, actualEvent) in actualEvents.enumerated() {
            let expectedEvent = expectedEvents[index]
            XCTAssertEqual(actualEvent, expectedEvent, printError(index: index, expectedEvent: expectedEvent, actualEvent: actualEvent))
        }
    }
}
