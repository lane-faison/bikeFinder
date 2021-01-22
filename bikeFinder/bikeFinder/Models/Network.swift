//
//  Network.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import Foundation

struct Network: Codable {
    var company: CompanyName?
    let location: Location
    let name: String
    
    enum Keys: String, CodingKey {
        case company
        case location
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        location = try container.decode(Location.self, forKey: .location)
        name = try container.decode(String.self, forKey: .name)
        company = try container.decodeIfPresent(CompanyName.self, forKey: .company)
    }
}
