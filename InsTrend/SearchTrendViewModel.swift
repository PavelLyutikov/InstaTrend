

import UIKit

class SearchTrendViewModel {
    
    var searchTrendsArray = [TrendItemSearch]()
    var filteredTrendsArray = [TrendItemSearch]()
    
    private let networkManager = NetworkManager.shared
    
    func loadTrends(completion: @escaping () -> () = {}) {
        networkManager.loadISearchItems { [weak self] trends in
            guard let trends = trends else {return}
            
            // если обновлять не в main потоке будет ошибка
            DispatchQueue.main.async {
                
                self?.searchTrendsArray = trends
                completion()
            }
        }
    }
    
//    func makeProposition() {
//        let alert = UIAlertController(title: "Чтобы увидеть галлерею фотографий оформите пробный период", message: "Первые 3 дня бесплатно, далее всего за 1.49$/Месяц?", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Отмена", style: .destructive, handler: { (_) in
//        
//        }))
//        alert.addAction(UIAlertAction(title: "Попробовать", style: .default, handler: { (_) in
//            BuyProduct.shared.purchaseMyProduct(product: BuyProduct.shared.iapProducts[0])
//        }))
//        
//        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
//    }
//    
//    var hasPurchare: Bool {
//        BuyProduct.shared.nonConsumablePurchaseMade
//    }
    
    func filter(by name: String) {
        filteredTrendsArray = searchTrendsArray.filter{$0.name.lowercased().contains(name.lowercased())}
    }
       
}
