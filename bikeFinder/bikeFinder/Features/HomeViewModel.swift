//
//  HomeViewModel.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import Foundation

class HomeViewModel {
    
    let store = DataStore.shared
    
    var networkList: [NetworkSection] = []
    
    func requestData(completion: @escaping () -> Void) {
        store.requestNetworks { [weak self] (networks) in
            let networkDictionary = Dictionary(grouping: networks, by: { $0.country })
            var networkList: [NetworkSection] = []
            
            for (key, value) in networkDictionary {
                networkList.append(NetworkSection(sectionName: key, sectionNetworks: value))
            }
            
            self?.networkList = networkList.sorted(by: { $0.sectionName < $1.sectionName })
            
            completion()
        }
    }
}
