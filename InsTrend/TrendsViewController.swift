

import UIKit
import SnapKit
import GoogleMobileAds
import UserNotifications

//var lockOn: Bool = true

//var defaults = UserDefaults.standard
//var state = defaults.bool(forKey: "isSelected")
//
//var defaultsTwo = UserDefaults.standard
//var stateTwo = defaultsTwo.bool(forKey: "isSelectedTwo")
//
//var defaultsThree = UserDefaults.standard
//var stateThree = defaultsThree.bool(forKey: "isSelectedThree")

class TrendsViewController: UIViewController {
    
    let defaultsLockOne = UserDefaults.standard.bool(forKey: "defaultsLockOne")
    let defaultsLockTwo = UserDefaults.standard.bool(forKey: "defaultsLockTwo")
    let defaultsLockThree = UserDefaults.standard.bool(forKey: "defaultsLockThree")
    
    private let viewModel: TrendsViewModel = TrendsViewModel()
    
    var addManager: AddsM?
    var timer: Timer?
    let lockOne = UIButton()
    let lockTwo = UIButton()
    let lockThree = UIButton()
    
    let totalSize = UIScreen.main.bounds.size
    let notificationCenter = UNUserNotificationCenter.current()
//    let barInfo = UIImage(named: "info-1")

//InfView
    lazy var titleLabel: UILabel = {
        

        
        var fontSize: CGFloat!
        var labelHeight: CGFloat!
        var topInset: CGFloat!
             if totalSize.height >= 815 {
                fontSize = 23
                labelHeight = 80
                topInset = 25
             } else if totalSize.height <= 700 {
                fontSize = 20
                labelHeight = 60
                topInset = 25
             } else if totalSize.height == 812 {
                fontSize = 20
                labelHeight = 60
                topInset = 30
             } else {
                fontSize = 20
                labelHeight = 60
                topInset = 25
        }
        
        let title = UILabel()
        title.font = UIFont(name: "SFNS Display", size: fontSize)
        title.textColor = .black
//        title.text = "Что может лучше, чем свежая и вкусная  пицца 🍕\nПлан такой: заказываем, делаем красивое фото и наслаждаемся 😉"
        title.textAlignment = .center
        title.numberOfLines = 0
        self.view.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(topInset)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(labelHeight)
        }
        return title
    }()
//MARK: - ButtnBar
//     @objc lazy var buttonBar: UIButton = {
//
//                var rightSize: CGFloat!
//                var topSize: CGFloat!
//                if totalSize.height >= 800 {
//                   rightSize = 20
//                    topSize = -10
//               } else {
//                   rightSize = 20
//                    topSize = 30
//               }
//
//               let btn = UIButton()
//
//               btn.setImage(#imageLiteral(resourceName: "info"), for: .normal)
//               btn.contentMode = .scaleAspectFit
//        btn.layer.zPosition = 30
//               self.view.addSubview(btn)
//
//               btn.snp.makeConstraints { make in
//                   make.height.equalTo(30)
//                   make.width.equalTo(30)
//                   make.top.equalToSuperview().inset(topSize)
//                   make.trailing.equalToSuperview().inset(rightSize)
//               }
//
//               return btn
//           }()

           @objc func buttonBarAction(sender: UIButton) {

               let vc = InfoViewController()

//             vc.modalPresentationStyle = .fullScreen

               let transition = CATransition()
               transition.duration = 0.5
               transition.type = CATransitionType.fade
               transition.subtype = CATransitionSubtype.fromTop
               transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
               view.window!.layer.add(transition, forKey: kCATransition)

               present(vc, animated: true, completion: nil)

                   }

//MARK: - InstatrendLabel
    lazy var insLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "SFNS Display", size: 28)
        title.text = "InstaTrend"
        title.textColor = .black
        title.textAlignment = .center 

        self.view.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.height.equalTo(50)
//            make.width.equalTo(200)
        }
        
        return title
    }()

//MARK: - Time Trend
    lazy var newTrendLabel: UILabel = {
        
        
        var fontSize: CGFloat!
        var bottomSize: CGFloat!
        var topInset: CGFloat!
             if totalSize.height >= 815 {
                fontSize = 34
                bottomSize = 0
             } else if totalSize.height <= 700 {
                fontSize = 27
                bottomSize = -25
             } else if totalSize.height == 812 {
                fontSize = 35
                bottomSize = 0
             } else {
                fontSize = 30
                bottomSize = -25
        }
        
        let timerLabel = UILabel()
        timerLabel.font = UIFont(name: "SFNS Display", size: fontSize)
//        timerLabel.font = .systemFont(ofSize: 40, weight: .regular)
//        timerLabel.text = "07 : 49 : 09"
        timerLabel.textAlignment = .center
        timerLabel.textColor = .black
        timerLabel.numberOfLines = 0
        self.view.addSubview(timerLabel)
        
        
        
        timerLabel.snp.makeConstraints { make in

            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(bottomSize)
            make.height.equalTo(100)
        }
        return timerLabel
    }()
        lazy var newTrendTextLabel: UILabel = {
            
            

            var fontSize: CGFloat!
            var bottomSize: CGFloat!
                 if totalSize.height >= 815 {
                    fontSize = 28
                    bottomSize = 75
                 } else if totalSize.height <= 700 {
                    fontSize = 26
                    bottomSize = 45
                 } else if totalSize.height == 812 {
                    fontSize = 25
                    bottomSize = 75
                 } else {
                    fontSize = 26
                    bottomSize = 45
            }
            
            let timerLabel = UILabel()
            
            timerLabel.font = UIFont(name: "SFNS Display", size: fontSize)
            timerLabel.text = NSLocalizedString("Новый тренд через:", comment: "Новый тренд через")
            timerLabel.textAlignment = .center
            timerLabel.textColor = .black
            timerLabel.numberOfLines = 0
            self.view.addSubview(timerLabel)
            
            timerLabel.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).inset(bottomSize)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(60)
            }
            return timerLabel
        }()
//MARK: - CollectionView
    
    lazy var collectictionView: UICollectionView = {
        
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        let itemWidth = ((UIScreen.main.bounds.width - 32) / 3 - 2)
        layout.itemSize = CGSize(width: itemWidth + 1, height: itemWidth)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: "ImageCollectionCell")
        collectionView.isScrollEnabled = true
        layout.scrollDirection = .vertical
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.contentMode = .scaleToFill
        collectionView.isUserInteractionEnabled = true
        self.view.addSubview(collectionView)
 
         if totalSize.height >= 800 {
            

        } else if totalSize.height <= 700 {
                
             } else {
                
        }
        var topInset: CGFloat!
        
             if totalSize.height >= 815 {
                topInset = 150
             } else if totalSize.height <= 700 {
                topInset = 100
                
             } else if totalSize.height == 812 {
                topInset = 130
                
                
             } else {
                topInset = 120
        }
        
        //Size
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topInset)
//            make.center.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(13)
            
            // 36 = 32 - 4
            make.height.equalTo((UIScreen.main.bounds.width - 28))
        }
        
        return collectionView
    }()

//MARK: - LockButton
    //OneButton
    lazy var lockOneButton: UIButton = {
        lockOne.setImage(#imageLiteral(resourceName: "Group 1-1"), for: .normal)
                lockOne.clipsToBounds = true
                lockOne.contentMode = .scaleToFill
                lockOne.layer.zPosition = 30
//                lockOne.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                lockOne.layer.shadowRadius = 10
//                lockOne.layer.shadowOffset = CGSize(width: 0, height: 0)
//                lockOne.layer.shadowOpacity = 50
                lockOne.clipsToBounds = false
                self.view.addSubview(lockOne)
        
            var bottomInset: CGFloat!
            var leadingInset: CGFloat!
            var sizeWidth: CGFloat!
            var sizeHeight: CGFloat!
             if totalSize.height >= 815 {
                bottomInset = 275
                leadingInset = 1
                sizeWidth = 150
                sizeHeight = 130
             } else if totalSize.height <= 700 {
                bottomInset = 160
                leadingInset = 5
                sizeWidth = 128
                sizeHeight = 112
             } else if totalSize.height == 812 {
                bottomInset = 250
                leadingInset = 4
                sizeWidth = 130
                sizeHeight = 115
             } else {
                bottomInset = 170
                leadingInset = 5
                sizeWidth = 140
                sizeHeight = 125
        }
        
            lockOne.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(leadingInset)
                make.bottom.equalToSuperview().inset(bottomInset)
                make.height.equalTo(sizeHeight)
                make.width.equalTo(sizeWidth)
                    }
            return lockOne
    }()
    @objc func lockOneButtonAction(sender: UIButton) {
        
        if self.addManager?.interstitial.isReady ?? false {
            
            addManager?.interstitial.present(fromRootViewController: self)
//            lockOneButton.isHidden = true
            lockOne.removeFromSuperview()
            UserDefaults.standard.set(false, forKey: "defaultsLockOne")
//            defaults.set(false, forKey: "isSelected")

         }
    }
    func spawnLockOneButton() {
        if defaultsLockOne == true {
            lockOneButton.addTarget(self, action: #selector(lockOneButtonAction(sender:)), for: .touchUpInside)
        }
    }
    //TwoButton
    lazy var lockTwoButton: UIButton = {
        lockTwo.setImage(#imageLiteral(resourceName: "Group 1-1"), for: .normal)
                lockTwo.clipsToBounds = true
                lockTwo.contentMode = .scaleToFill
                lockTwo.layer.zPosition = 30
//                lockTwo.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                lockTwo.layer.shadowRadius = 10
//                lockTwo.layer.shadowOffset = CGSize(width: 0, height: 0)
//                lockTwo.layer.shadowOpacity = 50
                lockTwo.clipsToBounds = false
                self.view.addSubview(lockTwo)
        
                var bottomInset: CGFloat!

                    var sizeWidth: CGFloat!
                    var sizeHeight: CGFloat!
                     if totalSize.height >= 815 {
                        bottomInset = 275
        
                        sizeWidth = 150
                        sizeHeight = 130
                     } else if totalSize.height <= 700 {
                        bottomInset = 160
                       
                        sizeWidth = 128
                        sizeHeight = 112
                     } else if totalSize.height == 812 {
                        bottomInset = 250
                  
                        sizeWidth = 130
                        sizeHeight = 115
                     } else {
                        bottomInset = 170
                       
                        sizeWidth = 140
                        sizeHeight = 125
                }
        
            lockTwo.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().inset(bottomInset)
                make.height.equalTo(sizeHeight)
                make.width.equalTo(sizeWidth)
                    }
            return lockTwo
    }()
    @objc func lockTwoButtonAction(sender: UIButton) {
        
        if self.addManager?.interstitial.isReady ?? false {
            
            addManager?.interstitial.present(fromRootViewController: self)
//            lockTwoButton.isHidden = true
            lockTwo.removeFromSuperview()
//            defaultsTwo.set(false, forKey: "isSelectedTwo")
            UserDefaults.standard.set(false, forKey: "defaultsLockTwo")

         }
    }
    func spawnLockTwoButton() {
        if defaultsLockTwo == true {
            lockTwoButton.addTarget(self, action: #selector(lockTwoButtonAction(sender:)), for: .touchUpInside)
        }
    }
    //ThreeButton
    lazy var lockThreeButton: UIButton = {
        lockThree.setImage(#imageLiteral(resourceName: "Group 1-1"), for: .normal)
                lockThree.clipsToBounds = true
                lockThree.contentMode = .scaleToFill
                lockThree.layer.zPosition = 30
//                lockThree.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                lockThree.layer.shadowRadius = 10
//                lockThree.layer.shadowOffset = CGSize(width: 0, height: 0)
//                lockThree.layer.shadowOpacity = 50
                lockThree.clipsToBounds = false
                self.view.addSubview(lockThree)
        
                var bottomInset: CGFloat!
                    var trailingInset: CGFloat!
                    var sizeWidth: CGFloat!
                    var sizeHeight: CGFloat!
                     if totalSize.height >= 815 {
                        bottomInset = 275
                        trailingInset = 1
                        sizeWidth = 150
                        sizeHeight = 130
                     } else if totalSize.height <= 700 {
                        bottomInset = 160
                        trailingInset = 5
                        sizeWidth = 128
                        sizeHeight = 112
                     } else if totalSize.height == 812 {
                        bottomInset = 250
                        trailingInset = 4
                        sizeWidth = 130
                        sizeHeight = 115
                     } else {
                        bottomInset = 170
                        trailingInset = 5
                        sizeWidth = 140
                        sizeHeight = 125
                }
        
            lockThree.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(trailingInset)
                make.bottom.equalToSuperview().inset(bottomInset)
                make.height.equalTo(sizeHeight)
                make.width.equalTo(sizeWidth)
                    }
            return lockThree
    }()
    @objc func lockThreeButtonAction(sender: UIButton) {
        
        if self.addManager?.interstitial.isReady ?? false {
            
            addManager?.interstitial.present(fromRootViewController: self)
//            lockThreeButton.isHidden = true
            lockThree.removeFromSuperview()
//            defaultsThree.set(false, forKey: "isSelectedThree")

            UserDefaults.standard.set(false, forKey: "defaultsLockThree")
         }
    }
    func spawnLockThreeButton() {
        if defaultsLockThree == true {
            lockThreeButton.addTarget(self, action: #selector(lockThreeButtonAction(sender:)), for: .touchUpInside)
        }
    }
//MARK: - goInfoFull
    //OneButton
    lazy var goInfoFull: UIButton = {
                let btn = UIButton()
                btn.clipsToBounds = true
                btn.contentMode = .scaleToFill
                btn.clipsToBounds = false
                self.view.addSubview(btn)
        
            btn.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).inset(25)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(100)
                    }
            return btn
    }()
    @objc func goInfoFullAction(sender: UIButton) {
        
        let vc = InfoFullViewController()

        present(vc, animated: true, completion: nil)
    }
    
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addManager = AddsM(controller: self)
        
        loadData()
        setupViews()
        setupDelegates()
        startTimer()
        spawnLockOneButton()
        spawnLockTwoButton()
        spawnLockThreeButton()
        goInfoFull.addTarget(self, action: #selector(goInfoFullAction(sender:)), for: .touchUpInside)
        
        sendNotification()
        
        timerAction()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerAction() {
        if viewModel.timerManager.totalSeconds <= 0 {
            viewModel.timerManager.totalSeconds = viewModel.timerManager.setIntervalCount()
            
            UserDefaults.standard.set(true, forKey: "defaultsLockOne")
            UserDefaults.standard.set(true, forKey: "defaultsLockTwo")
            UserDefaults.standard.set(true, forKey: "defaultsLockThree")
            lockTrue()
        }
        
        viewModel.timerManager.totalSeconds -= 1
        
        self.newTrendLabel.text = " \(viewModel.timerManager.format(totalSeconds: viewModel.timerManager.totalSeconds))"
    }
    
    func lockTrue() {
        UserDefaults.standard.set(true, forKey: "defaultsLockOne")
        UserDefaults.standard.set(true, forKey: "defaultsLockTwo")
        UserDefaults.standard.set(true, forKey: "defaultsLockThree")
    }
    
    func sendNotification() {
            
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("Новый тренд уже в приложение!", comment: "Новый тренд")
        content.body = NSLocalizedString("Предлагаем Вам ознакомиться с новой подборкой фотографий в нашем приложении.", comment: "Новый тренд текст")
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: viewModel.timerManager.totalSeconds, repeats: true)
        
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription)
        }
    }

    
    private func loadData() {
        viewModel.loadTrends { [weak self] in
            self?.collectictionView.reloadData()
        }
        
        switch Locale.current.languageCode {
        case "ar":
            viewModel.loadArabicInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "hu":
            viewModel.loadHungarianInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "vi":
            viewModel.loadVietnamInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "el":
            viewModel.loadGreekInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "da":
            viewModel.loadDanishInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "he":
            viewModel.loadHebrewInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "id":
            viewModel.loadIndonesianInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "es":
            viewModel.loadSpanishInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "it":
            viewModel.loadItalianInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "ca":
            viewModel.loadCatalanInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "zh-Hant":
            viewModel.loadChineseInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "ko":
            viewModel.loadKoreanInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "ms":
            viewModel.loadMalayInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "de":
            viewModel.loadGermanInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "nl":
            viewModel.loadNetherlandsInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "nb":
            viewModel.loadNorwegianInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "pl":
            viewModel.loadPolishInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "pt":
            viewModel.loadPortugueseInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "ro":
            viewModel.loadRomanianInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "sk":
            viewModel.loadSlovakInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "th":
            viewModel.loadThaiInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "tr":
            viewModel.loadTurkishInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "uk":
            viewModel.loadUkrainianInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "fi":
            viewModel.loadFinnishInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "fr":
            viewModel.loadFrenchInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "hi":
            viewModel.loadHindiInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "hr":
            viewModel.loadCroatianInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "cs":
            viewModel.loadCzechInfo { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "sv":
            viewModel.loadSwedishInfo { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "ja":
            viewModel.loadJapaneseInfo { [weak self] inf in
                self?.titleLabel.text = inf
            }
        case "ru":
            viewModel.loadRussianInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        default:
            viewModel.loadEnglishInfo() { [weak self] inf in
                self?.titleLabel.text = inf
            }
        }
    }
 //MARK: - setupViews
    private func setupViews() {
        navigationItem.titleView = insLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.bookmarks, target: self, action: #selector(buttonBarAction(sender:)))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "info"), style: .done, target: self, action: #selector(buttonBarAction(sender:)))
        
        self.view.backgroundColor = UIColor.white
        newTrendLabel.isHidden = false
        newTrendTextLabel.isHidden = false
        titleLabel.isHidden = false
//        buttonBar.isHidden = false
    }
    private func setupDelegates() {
        collectictionView.delegate = self
        collectictionView.dataSource = self
    }
    
}

extension TrendsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.trendsArray.count
    }
//ячейка
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell",
                for: indexPath) as! ImageCollectionCell
        
        guard let url = viewModel.trendsArray[indexPath.row].getURL() else {return cell}
        cell.setImage(url)
        
        return cell
    }
    
    
//goFullView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cells = collectionView.visibleCells
        
        guard cells.count > indexPath.row else {return}

//        let cell = cells[indexPath.row] as! ImageCollectionCell
//        guard let image = cell.imageView.image else {return}

        let detailsView = DetailsTrendViewController()
        
        let image = self.viewModel.trendsArray[indexPath.row].getURL()

        detailsView.initData(img: image!, author: self.viewModel.trendsArray[indexPath.row].author,
                             source: self.viewModel.trendsArray[indexPath.row].source)
        
        
            let transition = CATransition()
               transition.duration = 0.5
               transition.type = CATransitionType.fade
               transition.subtype = CATransitionSubtype.fromTop
               transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
               view.window!.layer.add(transition, forKey: kCATransition)
        
              self.navigationController?.present(detailsView, animated: true, completion: nil)
    }
}

extension TrendsViewController: GADInterstitialDelegate {

    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
      print("interstitialDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
      print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
      print("interstitialWillPresentScreen")
    }

    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
      print("interstitialWillDismissScreen")
    }

    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        addManager?.interstitial = self.addManager?.createAndLoadInterstitial(viewController: self)
        print("interstitialDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
      print("interstitialWillLeaveApplication")
    }
}
