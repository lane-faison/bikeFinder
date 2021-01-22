//
//  DataService.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import UIKit
import CoreData

struct DataService {
    private let context: NSManagedObjectContext
    private let entity: NSEntityDescription
    
    struct Keys {
        static let entityName = "BikeNetwork"
        static let city = "city"
        static let companyName = "companyName"
        static let country = "country"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let networkName = "networkName"
    }
    
    init() {
        let application = UIApplication.shared
        let delegate = application.delegate as! AppDelegate
        context = delegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: Keys.entityName, in: context)!
    }
    
//    var currentBikeNetworkObjects: [NSManagedObject]? {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Keys.entityName)
//        do {
//            if let results = try context.fetch(request) as? [NSManagedObject] {
//                return results.isEmpty ? nil : results
//            } else {
//                return nil
//            }
//        } catch let error {
//            print("Error retrieving data: \(error)")
//            return nil
//        }
//    }
    
    func saveBikeNetworkData(_ networks: [Network]) {
        for network in networks {
            let newNetwork = NSEntityDescription.insertNewObject(forEntityName: Keys.entityName, into: context)
//            newNetwork.setValue(network.name, forKey: Keys.networkName)
//            newNetwork.setValue(network.company, forKey: Keys.companyName)
//            newNetwork.setValue(network.location.city, forKey: Keys.city)
//            newNetwork.setValue(network.location.country, forKey: Keys.country)
//            newNetwork.setValue(network.location.latitude, forKey: Keys.latitude)
//            newNetwork.setValue(network.location.longitude, forKey: Keys.longitude)
        }
        do {
            try context.save()
            print("Saving data successful!")
        } catch let error {
            print("Error saving data: \(error)")
        }
    }
}
