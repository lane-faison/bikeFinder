//
//  HomeViewModel.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import Foundation

class HomeViewModel {
    let networking = NetworkingService.shared
    let persistence = PersistenceService.shared
    
    var networks: [BikeNetwork] = []
    
    func fetchData(completion: @escaping ((Error?) -> Void)) {
        networking.request("http://api.citybik.es/v2/networks") { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                          let networksArray = json["networks"] as? [[String: Any]] else { return }
                    
                    let networks: [BikeNetwork] = networksArray.compactMap {
                        guard let location = $0["location"] as? [String: Any],
                              let networkName = $0["name"] as? String,
                              let city = location["city"] as? String,
                              let country = location["country"] as? String else { return nil }
                        
                        let network = BikeNetwork(context: self.persistence.context)
                        network.networkName = networkName
                        network.city = city
                        network.country = country
                        
                        return network
                    }
                    self.networks = networks
                    completion(nil)
                } catch let error {
                    print("Error parsing JSON: \(error)")
                }
            case .failure(let error):
                print("Error with the request: \(error)")
            }
        }
    }
}
