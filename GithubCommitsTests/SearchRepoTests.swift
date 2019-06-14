//
//  SearchRepoTests.swift
//  GithubCommitsTests
//
//  Created by Billy Bray on 6/14/19.
//  Copyright © 2019 Billy Bray. All rights reserved.
//

import XCTest
@testable import GithubCommits

class SearchRepoTests: XCTestCase {

    func testUserSearchesButEntersNoOwnerName() {
        let expect = expectation(description: "Error message shown when no owner name entered")
        let presenter = SearchRepoPresenter(delegate: MockUIViewController(expectation: expect, expectationMessage: "Owner name is required."))
        presenter.search(ownerName: "", repoName: "github_commits")
        wait(for: [expect], timeout: 1)
    }
    
    func testUserSearchesButEntersNoRepoName() {
        let expect = expectation(description: "Error message shown when no repo name entered")
        let presenter = SearchRepoPresenter(delegate: MockUIViewController(expectation: expect, expectationMessage: "Repo name is required."))
        presenter.search(ownerName: "olb", repoName: "")
        wait(for: [expect], timeout: 1)
    }
    
    func testUserSearchesForRepoUsingOwnerNameAndRepoNameGetSuccess() {
        let expect = expectation(description: "User should get success on valid owner name and repo name")
        let presenter = SearchRepoPresenter(delegate: MockUIViewController2(expectation: expect))
        presenter.search(ownerName: "olb", repoName: "github_commits")
        wait(for: [expect], timeout: 1)
    }
    
    func testUserShownProgressIndicatorWhenSearchPressed() {
        let expect = expectation(description: "Progress indicator should show when user searches for repo")
        let presenter = SearchRepoPresenter(delegate: MockUIViewController3(expectation: expect))
        presenter.search(ownerName: "olb", repoName: "github_commits")
        wait(for: [expect], timeout: 1)
    }
    
    func testUserNotShownProgressIndicatorWhenSearchComplete() {
        let expect = expectation(description: "Progress indicator should hide when search for repo ends")
        let presenter = SearchRepoPresenter(delegate: MockUIViewController4(expectation: expect))
        presenter.search(ownerName: "olb", repoName: "github_commits")
        wait(for: [expect], timeout: 1)
    }
    
    
    class MockUIViewController: RepoSearchPresenterDelegate {
        let expect: XCTestExpectation
        let expectationMessage: String?
        
        init(expectation: XCTestExpectation, expectationMessage: String?) {
            self.expect = expectation
            self.expectationMessage = expectationMessage
        }
        
        func showProgressIndicator() {
        }
        
        func hideProgressIndicator() {
        }
        
        func repoSearchSuccess(commits: Commits) {
        }
        
        func reportSearchFailed(message: String) {
            XCTAssertEqual(message, expectationMessage)
            self.expect.fulfill()
        }
    }
    
    class MockUIViewController2: RepoSearchPresenterDelegate {
        let expect: XCTestExpectation
        
        init(expectation: XCTestExpectation) {
            self.expect = expectation
        }
        
        func showProgressIndicator() {
        }
        
        func hideProgressIndicator() {
        }
  
        func repoSearchSuccess(commits: Commits) {
            self.expect.fulfill()
        }
        
        func reportSearchFailed(message: String) {
        }
    }
    
    class MockUIViewController3: RepoSearchPresenterDelegate {
        let expect: XCTestExpectation
        
        init(expectation: XCTestExpectation) {
            self.expect = expectation
        }
        
        func showProgressIndicator() {
            self.expect.fulfill()
        }
        
        func hideProgressIndicator() {
        }
        
        func repoSearchSuccess(commits: Commits) {
        }
        
        func reportSearchFailed(message: String) {
        }
    }
    
    class MockUIViewController4: RepoSearchPresenterDelegate {
        let expect: XCTestExpectation
        
        init(expectation: XCTestExpectation) {
            self.expect = expectation
        }
        
        func showProgressIndicator() {
        }
        
        func hideProgressIndicator() {
            self.expect.fulfill()
        }
        
        func repoSearchSuccess(commits: Commits) {
        }
        
        func reportSearchFailed(message: String) {
        }
    }

}
