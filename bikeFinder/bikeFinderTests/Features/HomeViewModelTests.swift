//
//  HomeViewModelTests.swift
//  bikeFinderTests
//
//  Created by Lane Faison on 1/26/21.
//

import XCTest
@testable import bikeFinder

class HomeViewModelTests: XCTestCase {
    
    func testTitle_isCorrect() {
        let testViewModel = HomeViewModel()
        XCTAssertEqual(testViewModel.viewTitle, "City Bikes")
    }
    
    func testBikeNetworkFetchRequest_successful() {
        let testViewModel = HomeViewModel()
        let expectation = self.expectation(description: "BikeNetworkFetch")
        
        testViewModel.requestData { (error) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(testViewModel.getNetworkList.count > 0)
    }
}
