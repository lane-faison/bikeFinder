//
//  MapViewModel.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/26/21.
//

import Foundation

final class MapViewModel {
    
    var networkLocations: [NetworkLocation] = []
    
    private let highlightedNetworkIndex: Int?
    
    var highlightedNetwork: NetworkLocation? {
        if let index = highlightedNetworkIndex {
            return networkLocations[index]
        }
        return nil
    }
    
    init(bikeNetworks: [BikeNetwork], highlightedNetworkIndex: Int?) {
        self.networkLocations = bikeNetworks.map { NetworkLocation(network: $0) }
        self.highlightedNetworkIndex = highlightedNetworkIndex
    }
}
