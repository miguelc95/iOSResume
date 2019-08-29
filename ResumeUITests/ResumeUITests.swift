//
//  ResumeUITests.swift
//  ResumeUITests
//
//  Created by Miguel Fernando Cuellar Gauna on 8/26/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import XCTest

class ResumeUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWorkInteraction(){
        let app = XCUIApplication()
        app.tabBars.buttons["Work"].tap()
        app.collectionViews.cells.element(boundBy: 0).tap()
    }
    
    func testWorkRotation(){
        let app = XCUIApplication()
        app.tabBars.buttons["Work"].tap()
        app.collectionViews.cells.element(boundBy: 0).tap()
        XCUIDevice.shared.orientation = .landscapeLeft
    }
    
    func testMeInteraction(){
        let app = XCUIApplication()
        app.tabBars.buttons["Me"].tap()
        let tableView = app.descendants(matching: .table).firstMatch
        guard let lastCell = tableView.cells.allElementsBoundByIndex.last else { return }
        lastCell.tap()
        
        let firstCell = app.tables.cells.firstMatch
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 10))
        start.press(forDuration: 0, thenDragTo: finish)
        XCUIDevice.shared.orientation = .landscapeLeft
    }
    
    func testPersonalInteraction(){
        let app = XCUIApplication()
        app.tabBars.buttons["Projects"].tap()

        let scrollView = app.scrollViews.element(boundBy: 0)
        let pageIndicator = app.pageIndicators.element(boundBy: 0)
        
        XCTAssertEqual(pageIndicator.value as? String, "page 1 of 3")

        scrollView.swipeLeft()
        XCTAssertEqual(pageIndicator.value as? String, "page 2 of 3")
        
        pageIndicator.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.2)).tap()
        XCTAssertFalse(app.otherElements["page_2"].exists)
        XCTAssertEqual(pageIndicator.value as? String, "page 3 of 3")
    }

}
