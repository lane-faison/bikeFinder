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
        networking.request(Endpoint.networks.urlPath) { [weak self] (result) in
            switch result {
            case .success(let data):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                          let networksArray = json["networks"] as? [[String: Any]] else { return }
                    
                    networksArray.forEach {
                        guard let self = self,
                              let location = $0["location"] as? [String: Any],
                              let networkName = $0["name"] as? String,
                              let city = location["city"] as? String,
                              let country = location["country"] as? String, city == "Aspen, CO" else { return }
                        
                        let network = BikeNetwork(context: self.persistence.context)
                        network.networkName = networkName
                        network.city = city
                        network.country = country
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
