//
//  DataStore.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import Foundation
import CoreData

class DataStore: NSObject {
    
    let persistence = PersistenceService.shared
    let networking = NetworkingService.shared
    
    private override init() {
        super.init()
    }
    static let shared = DataStore()
    
    func requestNetworks(completion: @escaping ([BikeNetwork]) -> Void) {
        var networkIds: [String]
        
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: BikeNetwork.self))
            let fetchResult = try self.persistence.context.fetch(fetchRequest)
            networkIds = fetchResult.compactMap { ($0 as? BikeNetwork)?.id }
        } catch {
            networkIds = []
        }
        
        networking.request(Endpoint.networks.urlPath) { [weak self] (result) in
            switch result {
            case .success(let data):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                          let networksArray = json["networks"] as? [[String: Any]] else { return }
                    
                    for network in networksArray {
                        guard let self = self,
                              let location = network["location"] as? [String: Any],
                              let id = network["id"] as? String,
                              let networkName = network["name"] as? String,
                              let city = location["city"] as? String,
                              let country = location["country"] as? String,
                              let latitude = location["latitude"] as? Double,
                              let longitude = location["longitude"] as? Double
                        else { break }
                        
                        if !networkIds.contains(id) {
                            let newNetwork = BikeNetwork(context: self.persistence.context)
                            newNetwork.id = id
                            newNetwork.networkName = networkName
                            newNetwork.city = city
                            newNetwork.country = country
                            newNetwork.latitude = latitude
                            newNetwork.longitude = longitude
                            
                            if let companyName = network["company"] as? [String] {
                                newNetwork.company = companyName
                            } else if let companyName = network["company"] as? String {
                                newNetwork.company = [companyName]
                            } else {
                                newNetwork.company = nil
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self?.persistence.save {
                            self?.persistence.fetch(BikeNetwork.self, completion: { (objects) in
                                completion(objects)
                            })
                        }
                    }
                } catch let error {
                    print("Error parsing JSON: \(error)")
                }
            case .failure(let error):
                print("Error with the request: \(error)")
            }
        }
    }
}
