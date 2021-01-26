//
//  NetworkLocation.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/26/21.
//

import MapKit
import UIKit

class NetworkLocation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(network: BikeNetwork) {
        self.title = network.networkName
        self.coordinate = .init(latitude: CLLocationDegrees(network.latitude), longitude: CLLocationDegrees(network.longitude))
        self.info = "Location: \(network.city ?? "Unknown"), \(network.country ?? "Unknown")\nCompany(s): \(network.company?.joined(separator: ", ") ?? "Unknown")"
    }
}

extension CLLocationCoordinate2D: Equatable {}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return (lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude)
}
