

import Foundation

class NetworkManager {
    
    private init() {}
    
    static let shared = NetworkManager()
    
    private func genlLoader<T: Codable>(enpoint: Endpoint, completion: @escaping (([T]?) -> Void)) {
        guard let url = enpoint.url else {assertionFailure("Error with enpoint"); completion(nil); return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil, data != nil else {
                assertionFailure(error?.localizedDescription ?? "")
                completion(nil); return
            }
            
            do {
                let items = try JSONDecoder().decode([T].self, from: data!)
                completion(items)
            } catch {
                assertionFailure("Failed with decoding model")
                completion(nil)
            }
        }.resume()
    }
    
    func loadISearchItems(completion: @escaping (([TrendItemSearch]?) -> Void)) {
        self.genlLoader(enpoint: .search, completion: completion)
    }
    
    func loadTrendItems(completion: @escaping (([TrendItem]?) -> Void)) {
        self.genlLoader(enpoint: .trendItems, completion: completion)
    }
    
    func loadTime(completion: @escaping (([TimeTrend]?) -> Void)) {
        self.genlLoader(enpoint: .timer, completion: completion)
    }
    
    func loadInfo(completion: @escaping (([Info]?) -> Void)) {
        self.genlLoader(enpoint: .info, completion: completion)
    }
    
    private enum Endpoint {
        
        case search
        case trendItems
        case info
        case timer
        
        private var server: String {"https://lyutikovpavel.github.io/"}
        
        var url: URL? {
            switch self {
            case .search:
                return URL(string: server + "search.json")
            case .trendItems:
                return URL(string: server + "Trend.json")
            case .info:
                return URL(string: server + "info.json")
            case .timer:
                return URL(string: server + "time.json")
            }
        }
    }
    
}
