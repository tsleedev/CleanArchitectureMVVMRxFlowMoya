//
//  SearchUseCaseTests.swift
//  
//
//  Created by TAE SU LEE on 2022/11/21.
//

import TSCore
import TSTestUtility
import XCTest
import RxSwift
import RxBlocking
@testable import DomainLayer

final class SearchUseCaseTests: XCTestCase {
    private var disposeBag: DisposeBag!
    
    private var searchUseCase: SearchUseCase!

    private func setupTest(searchItems: [Entities.SearchItems], shouldReturnError: Bool) {
        let searchRepositoryMock = SearchRepositoryMock(searchItems: searchItems, shouldReturnError: shouldReturnError)
        searchUseCase = SearchUseCase(repository: searchRepositoryMock)
    }
    
    override func setUpWithError() throws {
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        searchUseCase = nil
    }

    func testSearchUseCase() {
        // Given
        let searchItems: [Entities.SearchItems] = {
            let totalCount = 21
            let page1 = Entities.SearchItems(totalCount: totalCount,
                                             items: (1...20).map { Entities.Search(fullName: "title\($0)", avatarUrl: nil, description: "description\($0)", htmlUrl: nil) })
            let page2 = Entities.SearchItems(totalCount: totalCount,
                                             items: [Entities.Search(fullName: "title21", avatarUrl: nil, description: "description21", htmlUrl: nil)])
            return [page1, page2]
        }()
        
        setupTest(searchItems: searchItems, shouldReturnError: false)
        
        // When
        let testQuery = "title"
        let testParams = Params.Search(query: testQuery, page: 1, perPage: 20)
        do {
            let searchResult = try searchUseCase.readItems(testParams)
                .toBlocking()
                .first()
            
            // Then
            XCTAssertNotNil(searchResult)
            XCTAssertEqual(searchResult?.totalCount, 20, printError(msg: "", expectedEvent: searchResult?.totalCount as Any, actualEvent: 20))
            XCTAssertEqual(searchResult?.items.count, 20, printError(msg: "", expectedEvent: searchResult?.items.count as Any, actualEvent: 20))
            XCTAssertTrue(searchResult?.items.allSatisfy { $0.fullName?.contains(testQuery) == true } ?? false)
        } catch {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }
}
