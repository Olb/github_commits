//
//  GithubCommitsUITests.swift
//  GithubCommitsUITests
//
//  Created by Billy Bray on 6/14/19.
//  Copyright © 2019 Billy Bray. All rights reserved.
//

import XCTest

class GithubCommitsUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testUserSeesErrorMessageWithoutRequiredInfo() {
        let app = XCUIApplication()
        app.buttons["Show Commits!"].tap()
        
        let titleQuery = app.staticTexts["Oops!"]
        XCTAssertTrue(titleQuery.exists, "Alert should show with title \"Ooops!\"")
//
        let messageQuery = app.staticTexts["Owner name is required."]
        XCTAssertTrue(messageQuery.exists, "Message should say \"Owner name is required.\" when no owner name entered")
    }
    
    func testRepoSearchDismissesOnSuccesfulRepoSearch() {
        XCTFail()
    }
    
    func testUserSeesCommitsListOnSuccessfulRepoSearch() {
        XCTFail()
    }

}
