//
//  InstagramResponse.swift
//  InsTrend
//
//  Created by Admin on 20/08/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct InstagramTestUser: Codable {
    var access_token: String
    var user_id: Int
}

struct InstagramUser: Codable {
    var id: String
    var username: String
    var media_count: Int
}

struct Feed: Codable {
    var data: [MediaData]
    var paging: PagingData
}

struct MediaData: Codable {
    var id: String
    var caption: String?
}

struct PagingData: Codable {
    var cursors: CursorData
    var next: String?
}

struct CursorData: Codable {
    var before: String
    var after: String
}

struct InstagramMedia: Codable {
    var id: String
    var media_type: MediaType
    var media_url: String
    var username: String
    var timestamp: String
}

enum MediaType: String,Codable {
    case IMAGE
    case VIDEO
    case CAROUSEL_ALBUM
}
