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
        XCTAssertTrue(titleQuery.exists, "Alert should show with title \"Oops!\"")

        let messageQuery = app.staticTexts["Owner name is required."]
        XCTAssertTrue(messageQuery.exists, "Message should say \"Owner name is required.\" when no owner name entered")
    }
    //testRepoSearchDismissesOnSuccesfulRepoSearch
    func testUserPromptedIfNoConnection() {
        
        let app = XCUIApplication()
        app.textFields["Repo Owner Name"].tap()
        
        let repoNameTextField = app.textFields["Repo Name"]
        repoNameTextField.tap()
        repoNameTextField.tap()
        app.buttons["Show Commits!"].tap()
        let titleQuery = app.staticTexts["Oops!"]
        XCTAssertTrue(titleQuery.exists, "Alert should show with title \"Oops!\"")
    }
    
    func testRepoSearchDismissesOnSuccesfulRepoSearch() {
        
        let app = XCUIApplication()
        let nameTextField =  app.otherElements.textFields["Repo Owner Name"]
        nameTextField.tap()
        nameTextField.setText(text: "olb", application: app)
        
        let repoTextField =  app.otherElements.textFields["Repo Name"]
        repoTextField.tap()
        repoTextField.setText(text: "github_commits", application: app)
        
        XCTAssertTrue(app.buttons["Show Commits!"].exists, "Show commits should be present before submission")
        app.buttons["Show Commits!"].tap()
        app.buttons["Show Commits!"].tap()
        sleep(5)
        XCTAssertFalse(app.buttons["Show Commits!"].exists, "Show commits should not be present before submission")
    }
    
    func testUserSeesCommitsListOnSuccessfulRepoSearch() {
        
        let app = XCUIApplication()
        let nameTextField =  app.otherElements.textFields["Repo Owner Name"]
        nameTextField.tap()
        nameTextField.setText(text: "olb", application: app)
        
        let repoTextField =  app.otherElements.textFields["Repo Name"]
        repoTextField.tap()
        repoTextField.setText(text: "github_commits", application: app)
        
        app.buttons["Show Commits!"].tap()
        app.buttons["Show Commits!"].tap()
        sleep(5)
        
        let titleQuery = app.staticTexts["Olb"]
        XCTAssertTrue(titleQuery.exists, "Alert should show with title \"Oops!\"")
    }
    
    func testSearchShownWhenSearchPressedOnCommitList() {
        
        let app = XCUIApplication()
        let nameTextField =  app.otherElements.textFields["Repo Owner Name"]
        nameTextField.tap()
        nameTextField.setText(text: "olb", application: app)
        
        let repoTextField =  app.otherElements.textFields["Repo Name"]
        repoTextField.tap()
        repoTextField.setText(text: "github_commits", application: app)
        
        app.buttons["Show Commits!"].tap()
        app.buttons["Show Commits!"].tap()
        sleep(5)
        
        app.buttons["Search"].tap()

        sleep(5)

        XCTAssertTrue(app.buttons["Show Commits!"].exists, "Search info screen should be displayed")
    }
}

extension XCUIElement {
    // The following is a workaround for inputting text in the
    //simulator when the keyboard is hidden
    func setText(text: String, application: XCUIApplication) {
        UIPasteboard.general.string = text
        doubleTap()
        application.menuItems["Paste"].tap()
    }
}



