//
//  iGameUITests.swift
//  iGameUITests
//
//  Created by Fauzi Achmad B D on 17/08/23.
//

import XCTest

final class HomeViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testNavigationTitle() {
        XCTAssertTrue(app.navigationBars["iGame"].staticTexts["iGame"].exists)
    }
    
    func testCollectionViewCellsExist() {
        let collectionView = app.collectionViews["gamesCollectionViewIdentifier"]
        XCTAssertTrue(collectionView.exists)
        
        let cell = collectionView.cells.element(matching: .cell, identifier: "cardCell")
        XCTAssertTrue(cell.exists)
    }
    
}
