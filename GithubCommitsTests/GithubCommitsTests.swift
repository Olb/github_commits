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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserGetCommitsForRepo() {
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
    
    
    
}

