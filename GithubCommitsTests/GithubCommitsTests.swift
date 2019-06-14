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
        XCTAssertEqual(commits.first!.commit.message, "Python Analysis")
        XCTAssertEqual(commits.first!.commit.author.name, "billy")
    }
    
    func testCommitsGiveCorrectFormatedValuesForDisplay() {
        let commits = try! JSONDecoder().decode(Commits.self, from: commitJson)
        XCTAssertEqual(commits.first!.commitHash, "Commit: 5f1102288aa8dbd2d69b487f11170717b489e6ab")
        XCTAssertEqual(commits.first!.commitMessage, "Message: Python Analysis")
        XCTAssertEqual(commits.first!.commitName, "billy")
    }
    
    
    let commitJson = """
[
  {
    "sha": "5f1102288aa8dbd2d69b487f11170717b489e6ab",
    "commit": {
      "author": {
        "name": "billy",
      },
      "message": "Python Analysis",
    },
  }
]
""".data(using: .utf8)!
    
    
    
}

