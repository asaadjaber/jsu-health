//
//  JSUHealthTests.swift
//  JSUHealthTests
//
//  Created by Asaad Jaber on 16/09/2024.
//

import XCTest
@testable import JSUHealth

final class ProcedureCardViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModel() {
        let viewModel = ProcedureCardViewModel()
        
        XCTAssertEqual(viewModel.procedures[0].imageName, "plastic surgery")
        XCTAssertEqual(viewModel.procedures[0].price, 15000)
        XCTAssertTrue(viewModel.procedures[0].procedures.contains("rhinoplasty"))

    }
}
