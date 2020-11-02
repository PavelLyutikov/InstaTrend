//
//  BuyViewController.swift
//  InsTrend
//
//  Created by mac on 29.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SnapKit
import SafariServices
import SwiftyStoreKit

class BuyViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size
    
    private let sharedSecret = "3c556d36c29e49fcacd8f8cea99983aa"
    private let productID = "com.space.insTrand.InsTrend.fullAccess"
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActivityIndicator()
        
        view.addSubview(activityIndicator)

        setupView()
        
        goButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(buttonCloseAction(sender:)), for: .touchUpInside)
        politickButton.addTarget(self, action: #selector(buttonPolitickAction(sender:)), for: .touchUpInside)
        serviceButton.addTarget(self, action: #selector(buttonServiceAction(sender:)), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(buttonRestoreAction(sender:)), for: .touchUpInside)
    }
//MARK: - SetupView
    func setupView() {
        infoLabel.isHidden = false
//        titleLabel.isHidden = false
        backgroundImage.isHidden = false
        imagePhoto.isHidden = false
    }
//MARK: - Background
    lazy var backgroundImage: UIImageView =  {
                
                var background = UIImageView(image: #imageLiteral(resourceName: "Untitled"))

                
                background.clipsToBounds = true
                background.contentMode = .scaleAspectFill
                background.layer.zPosition = -1
                self.view.addSubview(background)


                background.snp.makeConstraints { make in
                make.bottom.top.leading.trailing.equalToSuperview().inset(0)
                make.center.equalToSuperview()
    //                make.height.equalTo(UIScreen.main.bounds.height)
               // make.height.equalTo(300)
            }
                return background
            }()
//MARK: - ImagePhoto
    lazy var imagePhoto: UIImageView =  {
        
                var constant: CGFloat!
                var leadind: CGFloat!
                if totalSize.height >= 815 {
                        constant = -80
                        leadind = 0
                     } else if totalSize.height <= 700 {
                        constant = -160
                        leadind = 20
                     } else if totalSize.height == 812 {
                        constant = -100
                        leadind = 0
                     } else {
                        constant = -115
                        leadind = 0
                }
                
                var image = UIImageView(image: #imageLiteral(resourceName: "2020-07-29 22.36.33"))
                
                image.clipsToBounds = true
                image.contentMode = .scaleAspectFit
                image.layer.zPosition = -1
                self.view.addSubview(image)


                image.snp.makeConstraints { make in
                    make.top.equalToSuperview().inset(constant)
                    make.leading.trailing.equalToSuperview().inset(leadind)
//                make.centerY.equalToSuperview()
//                    make.leading.trailing.equalToSuperview()
               // make.height.equalTo(300)
            }
                return image
            }()
//MARK: - Info
        lazy var infoLabel: UILabel = {
            
                    var constant: CGFloat!
                    var size: CGFloat!
                    var leading: CGFloat!
                    if totalSize.height >= 815 {
                            constant = 200
                            size = 18
                            leading = 20
                         } else if totalSize.height <= 700 {
                            size = 15
                            constant = 160
                            leading = 3
                         } else if totalSize.height == 812 {
                            constant = 200
                            size = 16
                            leading = 20
                         } else {
                            size = 15
                            constant = 150
                            leading = 3
                    }
            
                    let title = UILabel()
                    title.font = .systemFont(ofSize: size, weight: .light)
                    title.text = NSLocalizedString("Вип: Если для Вас этого мало, с подпиской откроется доступ к полной галерее, которая будет обновляться для Вас каждый день. В галерее представлены отобранные фотографии с удобным поиском, где Вы можете найти новые идеи для фотографий и НИКАКОЙ РЕКЛАМЫ!", comment: "Описание подписки")
                    title.textColor = .black
                    title.textAlignment = .center
                    title.numberOfLines = 0
                    self.view.addSubview(title)
                    
                    title.snp.makeConstraints { make in
                        make.bottom.equalToSuperview().inset(constant)
                        make.leading.trailing.equalToSuperview().inset(leading)
        //                make.height.equalTo(100)
                    }
                    return title
                }()
    //MARK: Button
        @objc lazy var goButton: UIButton = {
            
//            var constant: CGFloat!
//            var width: CGFloat!
//            var height: CGFloat!
//             if totalSize.height >= 800 {
//                constant = 120
//                width = 300
//                height = 55
//            } else if totalSize.height >= 600 {
//                constant = 80
//                width = 300
//                height = 55
//            } else {
//                constant = 80
//                width = 300
//                height = 55
//            }
            
            var constant: CGFloat!
            var width: CGFloat!
            var height: CGFloat!
            if totalSize.height >= 815 {
                    constant = 120
                    width = 360
                    height = 50
                 } else if totalSize.height <= 700 {
                    constant = 100
                    width = 360
                    height = 45
                 } else if totalSize.height == 812 {
                    constant = 120
                    width = 300
                    height = 55
                 } else {
                    constant = 90
                    width = 400
                    height = 45
            }
            
            let btn = UIButton()
            
//            btn.setImage(#imageLiteral(resourceName: "buttonGo"), for: .normal)
//            btn.contentMode = .scaleAspectFit
            btn.setTitle(NSLocalizedString("3 дня бесплатно | далее 0.99$ / Месяц", comment: "Покупка"), for: .normal)
            btn.backgroundColor = #colorLiteral(red: 0.7262678146, green: 0.5196889639, blue: 0.2779648602, alpha: 1)
            btn.layer.cornerRadius = 25
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
    //            make.leading.trailing.equalToSuperview().inset(40)
                make.height.equalTo(height)
                make.width.equalTo(width)
                make.bottom.equalToSuperview().inset(constant)
            }
            
            return btn
        }()
        
        @objc func buttonAction(sender: UIButton) {
            activityIndicator.startAnimating()
            
            SwiftyStoreKit.purchaseProduct(productID, atomically: true) { [weak self] result in
                guard let self = self else { return }
                
                if case .success(let purchase) = result {
                    // Deliver content from server, then:
                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                    
                    let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: self.sharedSecret)
                    SwiftyStoreKit.verifyReceipt(using: appleValidator) { [weak self] result in
                        guard let self = self else { return }
                        
                        if case .success(let receipt) = result {
                            let purchaseResult = SwiftyStoreKit.verifySubscription(
                                ofType: .autoRenewable,
                                productId: self.productID,
                                inReceipt: receipt)
                            
                            switch purchaseResult {
                            case .purchased(_, _):
//                                self.goToRootViewController()
                                break
                            case .expired(_, _):
                                break
                            case .notPurchased:
                                break
                            }

                        } else {
                            // receipt verification error
                        }
                    }
                } else {
                    // purchase error
                }
            }
    }
        
        private func showErrorRestoreAlert() {
            let alert = UIAlertController(title: "Error", message: "An error occurred while restoring the purchase. Either it is expired or was not purchased", preferredStyle: .alert)
                
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            
            present(alert, animated: true, completion: nil)
        }
    
//MARK: ButtonClose
        @objc lazy var closeButton: UIButton = {
            

            var constant: CGFloat!
            var width: CGFloat!
            var height: CGFloat!
            var left: CGFloat!
            if totalSize.height >= 815 {
                    constant = 60
                    width = 30
                    height = 30
                    left = 30
                 } else if totalSize.height <= 700 {
                    constant = 25
                    width = 25
                    height = 25
                    left = 10
                 } else if totalSize.height == 812 {
                    constant = 60
                    width = 30
                    height = 30
                    left = 30
                 } else {
                    constant = 30
                    width = 30
                    height = 30
                    left = 10
            }
            
            let btn = UIButton()
            
            btn.setImage(#imageLiteral(resourceName: "Group 1"), for: .normal)
            btn.contentMode = .scaleAspectFill
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
//                make.centerX.equalToSuperview()
    //            make.leading.trailing.equalToSuperview().inset(40)
                make.height.equalTo(height)
                make.width.equalTo(width)
                make.top.equalToSuperview().inset(constant)
                make.leading.equalToSuperview().inset(left)
            }
            
            return btn
        }()
        
        @objc func buttonCloseAction(sender: UIButton) {
            
         let vc = RootTabBarViewController()

         vc.modalPresentationStyle = .fullScreen

         let transition = CATransition()
         transition.duration = 0.4
         transition.type = CATransitionType.push
         transition.subtype = CATransitionSubtype.fromBottom
         transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
         view.window!.layer.add(transition, forKey: kCATransition)

         present(vc, animated: false, completion: nil)
    }
    //MARK: - Politick
        @objc lazy var politickButton: UIButton = {
            
                var constant: CGFloat!
                var leading: CGFloat!
                 if totalSize.height >= 815 {
                    constant = 50
                    leading = 50
                 } else if totalSize.height >= 810 {
                     constant = 45
                     leading = 35
                 } else if totalSize.height >= 700 {
                    constant = 32
                    leading = 25
                 } else if totalSize.height >= 600 {
                     constant = 32
                     leading = 25
                 } else {
                    constant = 35
                    leading = 25
                }
                
            
                let btn = UIButton()
                
                btn.setTitle(NSLocalizedString("Политика конфиденциальности", comment: "Политика конфиденциальности"), for: .normal)
                btn.setAttributedTitle(.none, for: .normal)
                
                btn.setTitleColor(#colorLiteral(red: 0.7262678146, green: 0.5196889639, blue: 0.2779648602, alpha: 1), for: .normal)
                self.view.addSubview(btn)

                btn.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.bottom.equalToSuperview().inset(constant)
                }
                
                return btn
            }()
            
            @objc func buttonPolitickAction(sender: UIButton) {
               showSafariVC(for: "https://lyutikovpavel.github.io/politic.html")
            }
    //MARK: - Service
        @objc lazy var serviceButton: UIButton = {
            
                    var constant: CGFloat!
                     if totalSize.height >= 815 {
                        constant = 20
                     } else if totalSize.height >= 810 {
                     constant = 15
                     } else if totalSize.height >= 700 {
                     constant = 5
                     } else if totalSize.height >= 600 {
                         constant = 0
                     } else {
                        constant = 0
                    }
                    
                    let btn = UIButton()
                    
                    btn.setTitle(NSLocalizedString("Условия обслуживания", comment: "Условия обслуживания"), for: .normal)
                    btn.setAttributedTitle(.none, for: .normal)
                    
                    btn.setTitleColor(#colorLiteral(red: 0.7262678146, green: 0.5196889639, blue: 0.2779648602, alpha: 1), for: .normal)
                    self.view.addSubview(btn)

                    btn.snp.makeConstraints { make in
                        make.centerX.equalToSuperview()
    //                    make.trailing.equalToSuperview().inset(leading)

                        make.bottom.equalToSuperview().inset(constant)
                    }
                    
                    return btn
                }()
                
                @objc func buttonServiceAction(sender: UIButton) {
                   showSafariVC(for: "https://lyutikovpavel.github.io/politic.html")
                }
    //MARK: - Restore
        @objc lazy var restoreButton: UIButton = {

    //                var constant: CGFloat!
    //                 if totalSize.height >= 800 {
    //                    constant = 80
    //                } else if totalSize.height >= 600 {
    //                    constant = 35
    //                } else {
    //                    constant = 40
    //                }
            
                    var constant: CGFloat!
                     if totalSize.height >= 815 {
                        constant = 80
                     } else if totalSize.height >= 810 {
                     constant = 75
                     } else if totalSize.height >= 700 {
                     constant = 60
                     } else if totalSize.height >= 600 {
                         constant = 65
                     } else {
                        constant = 70
                    }
            
                    let btn = UIButton()
                    
                    btn.setTitle(NSLocalizedString("Восстановление покупок", comment: "Восстановление покупок"), for: .normal)
                    btn.setAttributedTitle(.none, for: .normal)
                    btn.setTitleColor(#colorLiteral(red: 0.7262678146, green: 0.5196889639, blue: 0.2779648602, alpha: 1), for: .normal)
                    self.view.addSubview(btn)

                    btn.snp.makeConstraints { make in
                        make.centerX.equalToSuperview()
                        make.bottom.equalToSuperview().inset(constant)
    //                    make.height.equalToSuperview().inset(1)
                    }
                    
                    return btn
                }()
                
                @objc func buttonRestoreAction(sender: UIButton) {
                    activityIndicator.startAnimating()

                    SwiftyStoreKit.restorePurchases(atomically: true) { [weak self] results in
                        guard let self = self else { return }

                        if results.restoredPurchases.count > 0 {
                            let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: self.sharedSecret)

                            SwiftyStoreKit.verifyReceipt(using: appleValidator) { [weak self] result in
                                guard let self = self else { return }

                                switch result {
                                case .success(let receipt):
                                    let purchaseResult = SwiftyStoreKit.verifySubscription(
                                        ofType: .autoRenewable,
                                        productId: self.productID,
                                        inReceipt: receipt)

                                    switch purchaseResult {
                                    case .purchased( _, _):
                                        self.goToRootViewController()
                                    case .expired( _, _):
                                        self.showErrorRestoreAlert()
                                    case .notPurchased:
                                        self.showErrorRestoreAlert()
                                    }
                                case .error( _):
                                    break
                                }

                                self.activityIndicator.stopAnimating()
                            }
                        } else {
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
    //MARK: - And
        lazy var titleLabel: UILabel = {
                    
                    var constant: CGFloat!
                     if totalSize.height >= 800 {
                        constant = 40
                    } else if totalSize.height >= 600 {
                        constant = 12
                    } else {
                        constant = -80
                    }
            
                    let title = UILabel()
                    title.font = .systemFont(ofSize: 18, weight: .light)
                    title.text = "and"
                    title.textColor = .black
                    title.textAlignment = .center
                    title.numberOfLines = 0
                    self.view.addSubview(title)
                    
                    title.snp.makeConstraints { make in
                        make.bottom.equalToSuperview().inset(constant)
                        make.centerX.equalToSuperview()
        //                make.height.equalTo(100)
                    }
                    return title
                }()
        
        func showSafariVC(for url: String) {
            guard let url = URL(string: url) else {
                return
            }
            
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true)
        }
        
        private func goToRootViewController(){
            
            let vc = RootTabBarViewController()

            vc.modalPresentationStyle = .fullScreen

            let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromBottom
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            view.window!.layer.add(transition, forKey: kCATransition)

            present(vc, animated: false, completion: nil)
        }
        
        private func setupActivityIndicator(){
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
            activityIndicator.center = self.view.center
            activityIndicator.style = .gray
            activityIndicator.layer.zPosition = 10
            activityIndicator.hidesWhenStopped = true
            activityIndicator.clipsToBounds = true
            
        }
}
