//
//  NetworkService.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import Foundation

struct NetworkService {
    
    func getBikeNetworks(completion: @escaping (NetworkFeed?) -> Void) {
        guard let url = URL(string: "http://api.citybik.es/v2/networks") else { return }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error == nil, let data = data {
                let networkFeed = parse(json: data)
                completion(networkFeed)
            } else {
                print("ERROR1")
                completion(nil)
            }
        }
        
        dataTask.resume()
    }
    
    private func parse(json: Data) -> NetworkFeed? {
        let decoder = JSONDecoder()
        do {
            let networkFeed = try decoder.decode(NetworkFeed.self, from: json)
            return networkFeed
        } catch let error {
            print("ERROR: \(error)")
            return nil
        }
    }
}
