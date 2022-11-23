//
//  SearchReposUseCaseTests.swift
//  
//
//  Created by TAE SU LEE on 2022/11/21.
//

import XCTest
import RxSwift
@testable import Domain

final class SearchReposUseCaseTests: XCTestCase {
    
    var disposeBag = DisposeBag()
    
    let reposPages: [ReposPage] = {
        let page1 = ReposPage(totalCount: 3, repos: [
            Repo(fullName: "title1", avatarUrl: nil, description: "description1", htmlUrl: nil),
            Repo(fullName: "title2", avatarUrl: nil, description: "description2", htmlUrl: nil)
        ])
        let page2 = ReposPage(totalCount: 3, repos: [
            Repo(fullName: "title3", avatarUrl: nil, description: "description3", htmlUrl: nil)
        ])
        return [page1, page2]
    }()
    
    class ReposDAOMock: ReposRepository {
        var reposPages: [ReposPage] = []
        
        func fetchRepos(query: String, page: Int, perPage: Int) -> Single<ReposPage> {
            return Single.just(reposPages[page-1])
        }
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchReposUseCase() {
        let expectation = self.expectation(description: "Search Repository error")
        let expectedRepo = reposPages[0]
        
        let reposDAO = ReposDAOMock()
        reposDAO.reposPages = reposPages
        let useCase = SearchReposUseCase(reposRepository: reposDAO)
        useCase.excute(query: "", page: 1, perPage: 2)
            .subscribe(onSuccess: { reposPage in
                XCTAssertEqual(expectedRepo, reposPage)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1.0)
    }
}
