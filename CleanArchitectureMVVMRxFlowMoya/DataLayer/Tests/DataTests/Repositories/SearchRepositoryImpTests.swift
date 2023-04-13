//
//  SearchRepositoryImpTests.swift
//  
//
//  Created by TAE SU LEE on 2022/11/21.
//

import XCTest
import RxSwift
import DomainLayer
@testable import DataLayer

final class SearchRepositoryImpTests: XCTestCase {
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchShouldReturnSuccess() {
        let expectation = XCTestExpectation(description: "Search API Success Test")
        let service = SearchAPIService(apiBaseURL: URL(string: "about:blank")!, apiType: .mock(statusCode: 200, mockFile: nil, delay: 1))
        let searchDAO = SearchRepositoryImp(service: service)
        
        let param = Params.Search(query: "rxswift", page: 1, perPage: 20)
        searchDAO.readItems(param)
            .subscribe(onSuccess: { searchItems in
                XCTAssertNotNil(searchItems)
                expectation.fulfill()
            }, onFailure: { error in
                XCTFail(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testSearchShouldReturnNoItems() {
        let expectation = XCTestExpectation(description: "Search API No Items Test")
        let service = SearchAPIService(apiBaseURL: URL(string: "about:blank")!, apiType: .mock(statusCode: 200, mockFile: .searchNoItems, delay: 1))
        let searchDAO = SearchRepositoryImp(service: service)

        let param = Params.Search(query: "noresults", page: 1, perPage: 20)
        searchDAO.readItems(param)
            .subscribe(onSuccess: { searchItems in
                XCTAssertEqual(searchItems.items.count, 0)
                expectation.fulfill()
            }, onFailure: { error in
                XCTFail(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testSearchShouldReturnFailure() {
        let expectation = XCTestExpectation(description: "Search API Failure Test")
        let service = SearchAPIService(apiBaseURL: URL(string: "about:blank")!, apiType: .mock(statusCode: 403, mockFile: nil, delay: 1))
        let searchDAO = SearchRepositoryImp(service: service)
        
        let param = Params.Search(query: "rxswift", page: 1, perPage: 20)
        searchDAO.readItems(param)
            .subscribe(onSuccess: { searchItems in
                XCTFail("The test should have failed but got a success instead")
            }, onFailure: { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1.5)
    }
}
