//
//  HurricanesUITests.swift
//  HurricanesUITests
//

import XCTest

final class HurricanesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // MARK: Test TabView
        let satellitesButton = app.tabBars.buttons["Satellites"]
        XCTAssertTrue(satellitesButton.exists, "Satellite button does not exist")
        satellitesButton.tap()
        
        let informationButton = app.tabBars.buttons["Information"]
        XCTAssertTrue(informationButton.exists, "Information button does not exist")
        informationButton.tap()
        
        let settingsButton = app.tabBars.buttons["Settings"]
        XCTAssertTrue(settingsButton.exists, "Settings button does not exist")
        settingsButton.tap()
        
        let hurricanesButton = app.tabBars.buttons["Hurricanes"]
        XCTAssertTrue(hurricanesButton.exists, "Hurricanes button does not exist")
        hurricanesButton.tap()
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
