//
//  NetworkService.swift
//  InsTrend
//
//  Created by mac on 19.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class NetworkService {
    
        func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
                
            }
        }.resume()
    }
    
}
