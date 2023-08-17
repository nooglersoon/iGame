//
//  FavoritesViewControllerUITests.swift
//  iGameUITests
//
//  Created by Fauzi Achmad B D on 17/08/23.
//

import XCTest

final class FavoritesViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testSecondTabViewController() {
        let tabBarItem = app.tabBars.buttons["favoriteTabItem"]
        XCTAssertTrue(tabBarItem.exists)
        tabBarItem.tap()
        
        // Check if the expected view controller is shown
        let secondViewController = app.navigationBars["Favorites"]
        XCTAssertTrue(secondViewController.exists)
        
    }
}
