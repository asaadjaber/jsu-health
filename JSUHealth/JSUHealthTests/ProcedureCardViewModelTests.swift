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
        
        let item = viewModel.procedures[0]
        switch item {
        case .procedureCard(let procedureCard):
            XCTAssertEqual(procedureCard.imageName, "plastic surgery")
            XCTAssertEqual(procedureCard.price, 15000)
            XCTAssertTrue(procedureCard.procedures.contains("rhinoplasty"))
        case .clinicCard(_):
            ()
        }
    }
}
