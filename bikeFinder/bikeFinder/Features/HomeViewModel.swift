//
//  HomeViewModel.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import Foundation

class HomeViewModel {
    
    let store = DataStore.shared
    
    var networks: [BikeNetwork] = []
    
    func requestData(completion: @escaping () -> Void) {
        store.requestNetworks { [weak self] (networks) in
            self?.networks = networks
            completion()
        }
    }
}
