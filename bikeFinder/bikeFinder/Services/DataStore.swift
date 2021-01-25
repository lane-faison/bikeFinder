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
    
    private var existingNetworkIds: [String] = []
    
    func requestNetworks(completion: @escaping ([BikeNetwork]) -> Void) {
        fetchStoredNetworkIds()
        networking.request(Endpoint.networks.urlPath) { [weak self] (result) in
            switch result {
            case .success(let data):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                          let networksArray = json["networks"] as? [[String: Any]] else { return }
                    
                    networksArray.forEach { self?.createNetworkFromJSON($0) }
                    
                    self?.saveAndFetchStoredNetworks(completion: completion)
                } catch {
                    print("Error parsing JSON: \(error)")
                    self?.saveAndFetchStoredNetworks(completion: completion)
                }
            case .failure(let error):
                print("Error with the request: \(error).\nResturning available data from CoreData")
                self?.saveAndFetchStoredNetworks(completion: completion)
            }
        }
    }
    
    private func fetchStoredNetworkIds() {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: BikeNetwork.self))
            let fetchResult = try self.persistence.context.fetch(fetchRequest)
            existingNetworkIds = fetchResult.compactMap { ($0 as? BikeNetwork)?.id }
        } catch {
            existingNetworkIds = []
        }
    }
    
    private func fetchStoredNetworks(completion: @escaping ([BikeNetwork]) -> Void) {
        persistence.fetch(BikeNetwork.self, completion: completion)
    }
    
    private func createNetworkFromJSON(_ networkJSON: [String: Any]) {
        if let location = networkJSON["location"] as? [String: Any],
           let id = networkJSON["id"] as? String,
           !existingNetworkIds.contains(id),
           let networkName = networkJSON["name"] as? String,
           let city = location["city"] as? String,
           let country = location["country"] as? String,
           let latitude = location["latitude"] as? Double,
           let longitude = location["longitude"] as? Double {
            
            let newNetwork = BikeNetwork(context: self.persistence.context)
            newNetwork.id = id
            newNetwork.networkName = networkName
            newNetwork.city = city
            newNetwork.country = country
            newNetwork.latitude = latitude
            newNetwork.longitude = longitude
            
            if let companyName = networkJSON["company"] as? [String] {
                newNetwork.company = companyName
            } else if let companyName = networkJSON["company"] as? String {
                newNetwork.company = [companyName]
            } else {
                newNetwork.company = nil
            }
        }
    }
    
    private func saveAndFetchStoredNetworks(completion: @escaping ([BikeNetwork]) -> Void) {
        DispatchQueue.main.async {
            self.persistence.save {
                self.fetchStoredNetworks(completion: completion)
            }
        }
    }
}
