//
//  GetPhotoRequestTests.swift
//  JSUHealthTests
//
//  Created by Asaad Jaber on 18/09/2024.
//

import XCTest
@testable import JSUHealth

final class GetPhotoRequestTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMakeURLRequest() {
        let getPhotoRequest = MockPhotoProvider(response: .value(Data(), URLResponse()))
        
        let query = getPhotoRequest.makeURLRequest(query: "rhinoplasty")
            
        XCTAssertEqual(query.url?.absoluteString, "http://123.com/search/photos?client_id=123&page=0&per_page=5&query=rhinoplasty")
        XCTAssertEqual(query.value(forHTTPHeaderField: "Accept-Version"), "v1")
    }
}
