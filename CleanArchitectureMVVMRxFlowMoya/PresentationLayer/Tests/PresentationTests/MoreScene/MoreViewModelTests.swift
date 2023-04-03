//
//  MoreViewModelTests.swift
//  
//
//  Created by TAE SU LEE on 2023/03/31.
//

import TSCore
import TSTestUtility
import DomainLayer
import XCTest
import Combine
import RxSwift
import RxFlow
@testable import PresentationLayer

final class MoreViewModelTests: XCTestCase {
    private var disposeBag: DisposeBag!
    private var cancellables: Set<AnyCancellable>!
    
    private var viewModel: MoreViewModel!
    private var input: MoreViewModel.Input!
    
    private func setupTest(moreItems: [Entities.More], shouldReturnError: Bool) {
        let moreUseCaseMock = MoreUseCaseMock(moreItems: moreItems, shouldReturnError: shouldReturnError)
        viewModel = MoreViewModel(useCase: moreUseCaseMock)
        
        input = MoreViewModel.Input()
        viewModel.transform(input: input)
    }
    
    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTriggerInput() {
        // Create XCTestExpectation to wait for the async operation to complete
        let expectation = XCTestExpectation(description: "Waiting for items")
        
        let moreItems: [Entities.More] = [
            Entities.More(title: "title1"),
            Entities.More(title: "title2")
        ]
        
        setupTest(moreItems: moreItems, shouldReturnError: false)
        
        let expectedItems = [
            [],
            moreItems.map { MoreItemViewModel(title: $0.title) }
        ]
        
        var receivedItems: [[MoreItemViewModel]] = []
        var counter = 0
        viewModel.$items
            .sink { items in
                receivedItems.append(items)
                counter += 1
                // Call fulfill when the async operation is complete (after 2 emissions)
                if counter == 2 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        input.trigger.onNext(())
        
        // Wait for the async operation to complete
        wait(for: [expectation], timeout: 2) // Set an appropriate timeout value.
        
        // Compare the receivedItems with the expected values here.
        XCTAssertEqual(receivedItems.count, 2, printError(msg: "1", expectedEvent: 2 , actualEvent: receivedItems.count))
        XCTAssertEqual(receivedItems[0], expectedItems[0], printError(msg: "2", expectedEvent: expectedItems[0], actualEvent: receivedItems[0]))
        XCTAssertEqual(receivedItems[1], expectedItems[1], printError(msg: "3", expectedEvent: expectedItems[1], actualEvent: receivedItems[1]))
    }
    
    func testDidSelectInput() {
        let expectation = XCTestExpectation(description: "Navigate to detailIsRequired")
        
        let moreItems: [Entities.More] = [
            Entities.More(title: "title1"),
            Entities.More(title: "title2")
        ]
        
        setupTest(moreItems: moreItems, shouldReturnError: false)
        
        viewModel.steps
            .bind { step in
                if case MoreStep.detailIsRequired = step {
                    expectation.fulfill()
                }
            }
            .disposed(by: disposeBag)
        
        input.didSelect.onNext(MoreItemViewModel(title: "title1"))

        wait(for: [expectation], timeout: 1.0)
    }

    func testClickSettingsInput() {
        let expectation = XCTestExpectation(description: "Navigate to settingsAreRequired")
        
        let moreItems: [Entities.More] = [
            Entities.More(title: "title1"),
            Entities.More(title: "title2")
        ]
        
        setupTest(moreItems: moreItems, shouldReturnError: false)
        
        viewModel.steps
            .bind { step in
                if case MoreStep.settingsAreRequired = step {
                    expectation.fulfill()
                }
            }
            .disposed(by: disposeBag)
        
        input.clickSettings.onNext(())

        wait(for: [expectation], timeout: 1.0)
    }
}
