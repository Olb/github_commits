//
//  GithubCommitsTests.swift
//  GithubCommitsTests
//
//  Created by Billy Bray on 6/14/19.
//  Copyright © 2019 Billy Bray. All rights reserved.
//

import XCTest
@testable import GithubCommits

class GithubCommitsTests: XCTestCase {

    func testUserSearchInfoHasCorrectFields() {
        let repoSearchInfo = RepoSearchInfo(ownerName: "Olb", repoName: "github_commits")
        XCTAssertEqual(repoSearchInfo.ownerName, "Olb")
        XCTAssertEqual(repoSearchInfo.repoName, "github_commits")
    }
    
    func testCommitsHasAuthorMessageHash() {
        let commit = Commit(sha: "hash", commit: CommitDetails(message: "a message", author: Author(name: "Olb")))
        XCTAssertEqual(commit.sha, "hash")
        XCTAssertEqual(commit.commit.author.name, "Olb")
        XCTAssertEqual(commit.commit.message, "a message")
    }
    
    func testCanGetCommitFromJson() {
        let commits = try! JSONDecoder().decode(Commits.self, from: commitJson)
        XCTAssertEqual(commits.first!.sha, "5f1102288aa8dbd2d69b487f11170717b489e6ab")
        XCTAssertEqual(commits.first!.commit.message, "github_commits")
        XCTAssertEqual(commits.first!.commit.author.name, "billy")
    }
    
    func testCommitsGiveCorrectFormatedValuesForDisplay() {
        let commits = try! JSONDecoder().decode(Commits.self, from: commitJson)
        XCTAssertEqual(commits.first!.commitHash, "Commit: 5f1102288aa8dbd2d69b487f11170717b489e6ab")
        XCTAssertEqual(commits.first!.commitMessage, "Message: github_commits")
        XCTAssertEqual(commits.first!.commitName, "billy")
    }
    
    func testSearchPresenterReturnsErrorOnInvalidSearchParams() {
        let expect = expectation(description: "Presenter delegate should get fail message on invalid api request")
        var searchRepoPresenter = SearchRepoPresenter(delegate: MockRepoSearchDelegate(expectation: expect))
        searchRepoPresenter.webService = MockWebService(delegate: searchRepoPresenter)
        
        searchRepoPresenter.search(ownerName: "fail", repoName: "test")
        wait(for: [expect], timeout: 1)
        
    }
    
    func testSearchPresenterReturnsCommitsOnCorrectSearchParams() {
        let expect = expectation(description: "Presenter delegate should get success with commits on valid api request")
        var searchRepoPresenter = SearchRepoPresenter(delegate: MockRepoSearchDelegate2(expectation: expect))
        searchRepoPresenter.webService = MockWebService(delegate: searchRepoPresenter)
        
        searchRepoPresenter.search(ownerName: "pass", repoName: "test")
        wait(for: [expect], timeout: 1)
        
    }
    
    struct MockWebService: WebServiceProtocol {
        var delegate: CommitApiProtocol
        func getCommits(repoSearchInfo: RepoSearchInfo) {
            if repoSearchInfo.ownerName == "fail" {
                delegate.failure(message: "fail")
            } else {
                delegate.success(commits: [])
            }
        }
    }
    
    class MockRepoSearchDelegate: RepoSearchPresenterDelegate {
        let expect: XCTestExpectation
        
        init(expectation: XCTestExpectation) {
            self.expect = expectation
        }
        
        func showProgressIndicator() {
            
        }
        
        func hideProgressIndicator() {
            
        }
        
        func repoSearchSuccess(commits: Commits) {
            
        }
        
        func reportSearchFailed(message: String) {
            self.expect.fulfill()
        }
    }
    
    class MockRepoSearchDelegate2: RepoSearchPresenterDelegate {
        let expect: XCTestExpectation
        
        init(expectation: XCTestExpectation) {
            self.expect = expectation
        }
        
        func showProgressIndicator() {
            
        }
        
        func hideProgressIndicator() {
            
        }
        
        func repoSearchSuccess(commits: Commits) {
            XCTAssert(commits.count == 0, "Commits must be empty array on success")
            self.expect.fulfill()
        }
        
        func reportSearchFailed(message: String) {
            
        }
    }
    
    
    let commitJson = """
[
  {
    "sha": "5f1102288aa8dbd2d69b487f11170717b489e6ab",
    "commit": {
      "author": {
        "name": "billy",
      },
      "message": "github_commits",
    },
  }
]
""".data(using: .utf8)!
    
    
    
}

