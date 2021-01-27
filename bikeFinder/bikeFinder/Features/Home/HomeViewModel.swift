//
//  HomeViewModel.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import Foundation

class HomeViewModel {
    
    let viewTitle: String = "City Bikes"
    let store = DataStore.shared
    
    private var networkList: [NetworkSection] = []
    
    var getNetworkList: [NetworkSection] {
        return networkList
    }
    
    func requestData(completion: @escaping (Error?) -> Void) {
        store.requestNetworks { [weak self] (networks, error) in
            let networkDictionary = Dictionary(grouping: networks, by: { $0.country })
            var networkList: [NetworkSection] = []
            
            for (key, value) in networkDictionary {
                networkList.append(NetworkSection(sectionName: key, sectionNetworks: value))
            }
            
            self?.networkList = networkList.sorted(by: { $0.sectionName < $1.sectionName })
            
            completion(error)
        }
    }
}
