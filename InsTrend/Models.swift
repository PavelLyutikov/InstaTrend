

import Foundation

struct TrendItem: Codable {
    var id: Int
    var author: String
    var imageURL: String
    var source: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case imageURL = "imageUrl"
        case source = "istok"
    }
    
    func getURL() -> URL? {
        URL(string: imageURL)
    }
}

struct TrendItemSearch: Codable {
    var id: Int
    var name: String
    var author: String
    var imageURL: String
    var source: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case author
        case imageURL = "imgUrl"
        case source = "istok"
    }
    
    func getURL() -> URL? {
        URL(string: imageURL)
    }
}

struct TimeTrend: Codable {
    var time : String
}

struct Info: Codable {
//    var info: String
//    var inf: String
    var englishInfo: String
    var arabicInfo: String
    var hungarianInfo: String
    var vietnamInfo: String
    var greekInfo: String
    var danishInfo: String
    var hebrewInfo: String
    var indonesianInfo: String
    var spanishInfo: String
    var italianInfo: String
    var catalanInfo: String
    var chineseInfo: String
    var koreanInfo: String
    var malayInfo: String
    var germanInfo: String
    var netherlandsInfo: String
    var norwegianInfo: String
    var polishInfo: String
    var portugueseInfo: String
    var romanianInfo: String
    var slovakInfo: String
    var thaiInfo: String
    var turkishInfo: String
    var ukrainianInfo: String
    var finnishInfo: String
    var frenchInfo: String
    var hindiInfo: String
    var croatianInfo: String
    var czechInfo: String
    var swedishInfo: String
    var japaneseInfo: String
    var russianInfo: String
}
