

import Foundation

class TrendsViewModel {
    
    var trendsArray = [TrendItem]()
    var timerManager = TimerManager.shared
    
    private let networkManager = NetworkManager.shared
    
    var timeNew = [TimeTrend]()
    
    func loadTrends(completion: @escaping () -> () = {}) {
        networkManager.loadTrendItems { [weak self] trends in
            guard let trends = trends else {return}
            DispatchQueue.main.async {
                self?.trendsArray = trends
                completion()
            }
        }
    }
    
    func loadTime() {
        networkManager.loadTime { [weak self] (timeTrend) in
            guard let timeTrend = timeTrend else {return}
            self?.timeNew = timeTrend
        }
    }
    
    func  loadEnglishInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.englishInfo ?? "")
            }
        }
    }
    func  loadArabicInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.arabicInfo ?? "")
            }
        }
    }
    func  loadHungarianInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.hungarianInfo ?? "")
            }
        }
    }
    func  loadVietnamInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.vietnamInfo ?? "")
            }
        }
    }
    func  loadGreekInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.greekInfo ?? "")
            }
        }
    }
    func  loadDanishInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.danishInfo ?? "")
            }
        }
    }
    func  loadHebrewInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.hebrewInfo ?? "")
            }
        }
    }
    func  loadIndonesianInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.indonesianInfo ?? "")
            }
        }
    }
    func  loadSpanishInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.spanishInfo ?? "")
            }
        }
    }
    func  loadItalianInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.italianInfo ?? "")
            }
        }
    }
    func  loadCatalanInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.catalanInfo ?? "")
            }
        }
    }
    func  loadChineseInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.chineseInfo ?? "")
            }
        }
    }
    func  loadKoreanInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.koreanInfo ?? "")
            }
        }
    }
    func  loadMalayInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.malayInfo ?? "")
            }
        }
    }
    func  loadGermanInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.germanInfo ?? "")
            }
        }
    }
    func  loadNetherlandsInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.netherlandsInfo ?? "")
            }
        }
    }
    func  loadNorwegianInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.norwegianInfo ?? "")
            }
        }
    }
    func  loadPolishInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.polishInfo ?? "")
            }
        }
    }
    func  loadPortugueseInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.portugueseInfo ?? "")
            }
        }
    }
    func  loadRomanianInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.romanianInfo ?? "")
            }
        }
    }
    func  loadSlovakInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.slovakInfo ?? "")
            }
        }
    }
    func  loadThaiInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.thaiInfo ?? "")
            }
        }
    }
    func  loadTurkishInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.turkishInfo ?? "")
            }
        }
    }
    func  loadUkrainianInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.ukrainianInfo ?? "")
            }
        }
    }
    func  loadFinnishInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.finnishInfo ?? "")
            }
        }
    }
    func  loadFrenchInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.frenchInfo ?? "")
            }
        }
    }
    func  loadHindiInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.hindiInfo ?? "")
            }
        }
    }
    func  loadCroatianInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.croatianInfo ?? "")
            }
        }
    }
    func  loadCzechInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.czechInfo ?? "")
            }
        }
    }
    func  loadSwedishInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.swedishInfo ?? "")
            }
        }
    }
    func  loadJapaneseInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.japaneseInfo ?? "")
            }
        }
    }
    
    func  loadRussianInfo(completion: @escaping (String) -> () = {_ in }) {
        networkManager.loadInfo { (infArray) in
            guard let infArray = infArray else {return}
            
            DispatchQueue.main.async {
                completion(infArray.first?.russianInfo ?? "")
            }
        }
    }
}
