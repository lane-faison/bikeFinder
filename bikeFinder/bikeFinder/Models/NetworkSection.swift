//
//  NetworkList.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/24/21.
//

import Foundation

struct NetworkSection {
    var sectionName: String!
    var sectionNetworks: [BikeNetwork]!
    
    var sectionFlag: String {
        flag(country: sectionName)
    }
    
    private func flag(country: String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return "\(String(s)) - \(country)"
    }
}
