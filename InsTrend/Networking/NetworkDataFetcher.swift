//
//  NetworkDataFetcher.swift
//  InsTrend
//
//  Created by mac on 22.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    
    let networkServise = NetworkService()
    func fetchTracks(urlString: String, response: @escaping (Response?) -> Void) {
        networkServise.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let tracks = try JSONDecoder().decode(Response.self, from: data)
                    response(tracks)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}
