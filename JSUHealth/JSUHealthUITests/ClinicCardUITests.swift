//
//  ClinicCardUITests.swift
//  JSUHealthUITests
//
//  Created by Asaad Jaber on 27/09/2024.
//

import XCTest
@testable import JSUHealth

final class ClinicCardUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testPriceTextView() {
        let app = XCUIApplication()
        
        app.launch()
        
        let locationTextView = app.descendants(matching: .staticText).element(matching: .staticText, identifier: "clinic-card-location-label")
        
        XCTAssertEqual(locationTextView.label, "Istanbul, Turkey")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
