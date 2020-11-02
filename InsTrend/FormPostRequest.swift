//
//  FormPostRequest.swift
//  InsTrend
//
//  Created by Admin on 22/08/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class FormPostRequest {
    static func getPostString(params: [String : Any]) -> String {
        var data = [String]()
        
        for (key, value) in params {
            data.append(key + "=\(value)")
        }
        
        return data.map { String($0) }.joined(separator: "&")
    }

    static func callPost(url: URL, params: [String : Any], finish: @escaping ((error: Error?, data: Data?)) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let postString = self.getPostString(params: params)
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            finish((error, data))
        }
        
        task.resume()
    }
}
