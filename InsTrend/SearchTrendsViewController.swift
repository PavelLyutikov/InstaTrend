

import UIKit
import SwiftyStoreKit

class SearchTrendsViewController: UIViewController {
    
    var activityIndicator = UIActivityIndicatorView()

    private let viewModel: SearchTrendViewModel = SearchTrendViewModel()

//searcBar
    lazy var customSearchController: UISearchController = {
        let srchController = UISearchController()
        
        switch Locale.current.languageCode {
        case "ar":
            srchController.searchBar.placeholder = "البحث عن الإلهام"
        case "hu":
            srchController.searchBar.placeholder = "Inspiráció keresése"
        case "vi":
            srchController.searchBar.placeholder = "Tìm cảm hứng"
        case "el":
            srchController.searchBar.placeholder = "Αναζήτηση έμπνευσης"
        case "da":
            srchController.searchBar.placeholder = "Søgen efter inspiration"
        case "he":
            srchController.searchBar.placeholder = "חיפוש ההשראה"
        case "id":
            srchController.searchBar.placeholder = "Pencarian inspirasi"
        case "es":
            srchController.searchBar.placeholder = "Buscando inspiración"
        case "it":
            srchController.searchBar.placeholder = "Trovare ispirazione"
        case "ca":
            srchController.searchBar.placeholder = "La recerca de la inspiració"
        case "zh-Hant":
            srchController.searchBar.placeholder = "寻找灵感"
        case "ko":
            srchController.searchBar.placeholder = "영감 검색"
        case "ms":
            srchController.searchBar.placeholder = "Mencari inspirasi"
        case "de":
            srchController.searchBar.placeholder = "Suche nach Inspiration"
        case "nl":
            srchController.searchBar.placeholder = "Zoeken naar inspiratie"
        case "nb":
            srchController.searchBar.placeholder = "Søk inspirasjon"
        case "pl":
            srchController.searchBar.placeholder = "Poszukiwanie inspiracji"
        case "pt":
            srchController.searchBar.placeholder = "Inspire-se"
        case "ro":
            srchController.searchBar.placeholder = "Găsirea inspirației"
        case "sk":
            srchController.searchBar.placeholder = "Hľadanie inšpirácie"
        case "th":
            srchController.searchBar.placeholder = "การค้นหาของแรงบันดาลใจ"
        case "tr":
            srchController.searchBar.placeholder = "İlham bulma"
        case "uk":
            srchController.searchBar.placeholder = "Пошук натхнення"
        case "fi":
            srchController.searchBar.placeholder = "Inspiraation etsintä"
        case "fr":
            srchController.searchBar.placeholder = "Trouver l'inspiration"
        case "hi":
            srchController.searchBar.placeholder = "प्रेरणा की खोज"
        case "hr":
            srchController.searchBar.placeholder = "Pronalaženje inspiracije"
        case "cs":
            srchController.searchBar.placeholder = "Hledání inspirace"
        case "sv":
            srchController.searchBar.placeholder = "Sökning av inspiration"
        case "ja":
            srchController.searchBar.placeholder = "インスピレーション"
        case "ru":
            srchController.searchBar.placeholder = "Поиск вдохновения"
        default:
            srchController.searchBar.placeholder = "Search of inspiration"
        }
//        srchController.searchBar.placeholder = "Поиск вдохновения"
        srchController.searchResultsUpdater = self
        srchController.searchBar.backgroundColor = .white
        
        srchController.obscuresBackgroundDuringPresentation = false
        
        // нужно устанавливать чтобы statusBar не был черным
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
        
        return srchController
    }()

//MARK: - CollectionView
    lazy var collectictionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3 - 14),
                                 height: (UIScreen.main.bounds.width / 3 - 14))
  
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: "ImageCollectionCell")
        collectionView.isScrollEnabled = true
        layout.scrollDirection = .vertical
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.layer.cornerRadius = 5
        collectionView.contentMode = .scaleToFill
        collectionView.isUserInteractionEnabled = true
        
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        return collectionView
    }()
 
    //встроенная
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        viewModel.hasPurchare ? loadData() : viewModel.makeProposition()
//    }
//MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActivityIndicator()
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "3c556d36c29e49fcacd8f8cea99983aa")

        SwiftyStoreKit.verifyReceipt(using: appleValidator) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let receipt):
                let productId = "com.space.insTrand.InsTrend.fullAccess"
                let purchaseResult = SwiftyStoreKit.verifySubscription(
                    ofType: .autoRenewable,
                    productId: productId,
                    inReceipt: receipt)

                switch purchaseResult {
                case .purchased( _, _):

                    self.loadData()
                    self.collectictionView.delegate = self
                    self.collectictionView.dataSource = self

//                    self.view.backgroundColor = .white
                    
                case .expired( _, _):
                    self.showBuyScreen()

                case .notPurchased:
                    self.showBuyScreen()

                }

            case .error( _):
                self.showBuyScreen()

            }

            self.activityIndicator.stopAnimating()
        }
        
        
        self.navigationItem.searchController = self.customSearchController
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        self.view.backgroundColor = .white
    }
    
    private func showBuyScreen() {
        
        let vc = BuyViewController()

        vc.modalPresentationStyle = .fullScreen

        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        view.window!.layer.add(transition, forKey: kCATransition)

        present(vc, animated: false, completion: nil)
    }
    
    private func setupActivityIndicator(){
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        activityIndicator.center = self.view.center
        activityIndicator.style = .gray
        activityIndicator.hidesWhenStopped = true
    }
//MARK: - backgroundImage
//            lazy var backgroundImage: UIImageView =  {
//
//                var background = UIImageView(image: #imageLiteral(resourceName: "Rectangle 9"))
//
//
//                background.clipsToBounds = true
//                background.contentMode = .scaleAspectFill
//                background.layer.zPosition = -1
//                self.view.addSubview(background)
//
//
//                background.snp.makeConstraints { make in
//                make.bottom.top.leading.trailing.equalToSuperview().inset(0)
//                make.center.equalToSuperview()
//    //                make.height.equalTo(UIScreen.main.bounds.height)
//               // make.height.equalTo(300)
//            }
//                return background
//            }()
//        private func setupBackground() {
//            self.backgroundImage.isHidden = false
//        }
    
    private func loadData() {
        viewModel.loadTrends { self.collectictionView.reloadData() }
    }
}


// MARK: - Extension for searchController
extension SearchTrendsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = customSearchController.searchBar.text {
            self.viewModel.filter(by: searchText)
            self.collectictionView.reloadData()
        }
    }
}


// MARK: - Extension for collectionView
extension SearchTrendsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    //goFulView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let detailsView = DetailsTrendViewController()
        if customSearchController.isActive {

            let imageURL = self.viewModel.filteredTrendsArray[indexPath.row].getURL()

            detailsView.initData(imgURL: imageURL!, author: self.viewModel.filteredTrendsArray[indexPath.row].author,
                                 source: self.viewModel.filteredTrendsArray[indexPath.row].source)
        } else {
            let imageURL = self.viewModel.searchTrendsArray[indexPath.row].getURL()
            
            detailsView.initData(imgURL: imageURL!, author: self.viewModel.searchTrendsArray[indexPath.row].author,
                                 source: self.viewModel.searchTrendsArray[indexPath.row].source)
        }
        
        let transition = CATransition()
           transition.duration = 0.5
        transition.type = CATransitionType.fade
           transition.subtype = CATransitionSubtype.fromTop
           transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
           view.window!.layer.add(transition, forKey: kCATransition)
        
        self.navigationController?.present(detailsView, animated: true, completion: nil)
    }
    //колво яч
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        customSearchController.isActive ? viewModel.filteredTrendsArray.count : viewModel.searchTrendsArray.count
    }
//ячей
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as!
          ImageCollectionCell
        
        var trendToShow: URL?
        
        if customSearchController.isActive {
            guard viewModel.filteredTrendsArray.count > indexPath.row else {return cell}
            trendToShow = viewModel.filteredTrendsArray[indexPath.row].getURL()
        } else {
            guard viewModel.searchTrendsArray.count > indexPath.row else {return cell}
            trendToShow = viewModel.searchTrendsArray[indexPath.row].getURL()
        }
        
        if let trendToShow = trendToShow {
            cell.setImage(trendToShow)
        }

        return cell
    }
    

}
