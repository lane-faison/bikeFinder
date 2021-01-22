//
//  HomeViewModel.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import Foundation

class HomeViewModel {
    let dataService = DataService()
    let networkService = NetworkService()
    
    var networks: [Network] = []
    
    func fetchData(completion: @escaping ((Error?) -> Void)) {
        networkService.getBikeNetworks { (data) in
            self.networks = data?.networks ?? []
            completion(nil)
        }
    }
}
