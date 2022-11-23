//
//  ReposDAOTests.swift
//  
//
//  Created by TAE SU LEE on 2022/11/21.
//

import XCTest
import Platform
import RxSwift
@testable import Data

final class ReposDAOTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchRepos() {
        let expectation = XCTestExpectation()
        
        let sampleData = RepoAPI
            .searchRepos(query: "RxSwift", page: 1, perPage: 20)
            .sampleData
        let expectedRepo = try? JSONDecoder().decode(ReposResponseDTO.self, from: sampleData)
        
        let dao = ReposDAO(network: RepoNetworking(networkType: .sample(statusCode: 200), delayed: 1))
        dao.fetchRepos(query: "RxSwift", page: 1)
            .subscribe(onSuccess: { reposPage in
                XCTAssertEqual(expectedRepo?.toDomain(), reposPage)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSearchReposAPIRateLimitExceeded() {
        let expectation = XCTestExpectation()
        
        let expectedRepo = try? JSONDecoder().decode(APIErrorResponse.self, from: SampleData().error)
        
        let dao = ReposDAO(network: RepoNetworking(networkType: .error, delayed: 1))
        dao.fetchRepos(query: "RxSwift", page: 1)
            .subscribe(onFailure: { error in
                XCTAssertEqual(expectedRepo?.message, (error as? APIError)?.errorDescription)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1.0)
    }
}
