//
//  Endpoint.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import Foundation
import CoreData

enum Endpoint<T: NSManagedObject> {
    case networks
    
    var urlPath: String {
        switch self {
        case .networks:
            return "http://api.citybik.es/v2/networks"
        }
    }
}
