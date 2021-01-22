//
//  NetworkingService.swift
//  bikeFinder
//
//  Created by Lane Faison on 1/22/21.
//

import Foundation

class NetworkingService {
    
    private init() {}
    static let shared = NetworkingService()
    
    func request(_ urlPath: String, completion: @escaping (Result<Data, NSError>) -> Void) {
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error as NSError))
            } else if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
