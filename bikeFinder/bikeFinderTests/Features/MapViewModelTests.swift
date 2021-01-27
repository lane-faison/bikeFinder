//
//  bikeFinderTests.swift
//  bikeFinderTests
//
//  Created by Lane Faison on 1/26/21.
//

import XCTest
@testable import bikeFinder

class MapViewModelTests: XCTestCase {
    
    let dataStore = DataStore.shared
    
    func testNetworkLocationsCount_isThree() {
        let testBikeNetworks = getTestNetworks()
        let testViewModel = MapViewModel(bikeNetworks: testBikeNetworks, highlightedNetworkIndex: 0)
        XCTAssertEqual(testViewModel.networkLocations.count, 3)
    }
    
    func testHighlightedNetworkIndex_returnsCorrectNetwork() {
        let testBikeNetworks = getTestNetworks()
        let testViewModel = MapViewModel(bikeNetworks: testBikeNetworks, highlightedNetworkIndex: 2)
        XCTAssertEqual(testViewModel.networkLocations[2].title, "C")
    }
    
    func testHighlightedNetwork_isNil_whenNoIndexSpecified() {
        let testBikeNetworks = getTestNetworks()
        let testViewModel = MapViewModel(bikeNetworks: testBikeNetworks, highlightedNetworkIndex: nil)
        XCTAssertEqual(testViewModel.highlightedNetwork, nil)
    }
}

extension MapViewModelTests {
    
    private func getTestNetworks() -> [BikeNetwork] {
        return [createTestNetwork(withName: "A"),
                createTestNetwork(withName: "B"),
                createTestNetwork(withName: "C")]
    }
    
    private func createTestNetwork(withName name: String) -> BikeNetwork {
        let newNetwork = BikeNetwork(entity: BikeNetwork.entity(), insertInto: nil)
        newNetwork.id = "123"
        newNetwork.networkName = name
        newNetwork.city = "testCity"
        newNetwork.country = "testCountry"
        newNetwork.company = ["testCompany"]
        newNetwork.latitude = 123.123
        newNetwork.longitude = 123.123
        return newNetwork
    }
}
