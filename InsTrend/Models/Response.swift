//
//  Response.swift
//  InsTrend
//
//  Created by mac on 19.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct Response: Decodable {
    var results: [Track]
}

struct Track: Decodable {
    var id : Int
    var author : String
    var imageUrl : String
}
