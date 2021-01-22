//
//  BikeNetwork+CoreDataProperties.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//
//

import Foundation
import CoreData


extension BikeNetwork {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BikeNetwork> {
        return NSFetchRequest<BikeNetwork>(entityName: "BikeNetwork")
    }

    @NSManaged public var networkName: String?
    @NSManaged public var city: String?
    @NSManaged public var country: String?

}

extension BikeNetwork : Identifiable {

}
