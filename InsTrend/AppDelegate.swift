//
//  AppDelegate.swift
//  InsTrend
//
//  Created by mac on 17.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase
import SwiftyStoreKit
import YandexMobileMetrica

//ca-app-pub-9138643120126724~3413349139
@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                case .failed, .purchasing, .deferred:
                    break
                @unknown default:
                    break
                }
            }
        }
        
        FirebaseApp.configure()
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        startViewController()
        setAppearence()
        
            let configuration = YMMYandexMetricaConfiguration.init(apiKey: "6d0077c6-39e2-4e5b-aa94-c12f5b4ad126")
            YMMYandexMetrica.activate(with: configuration!)
        

        UIApplication.shared.statusBarStyle = .darkContent
        
        return true
    }

    func startViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
//        window?.rootViewController = RootTabBarViewController()
        
        //Bar
        
        if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
                   window?.rootViewController = PreviewViewController()
            UserDefaults.standard.set(true, forKey: "defaultsLockOne")
            UserDefaults.standard.set(true, forKey: "defaultsLockTwo")
            UserDefaults.standard.set(true, forKey: "defaultsLockThree")
//                    defaults.set(true, forKey: "isSelected")
//                    defaultsTwo.set(true, forKey: "isSelectedTwo")
//                    defaultsThree.set(true, forKey: "isSelectedThree")
               } else {
                   window?.rootViewController = RootTabBarViewController()
               }
               UserDefaults.standard.set(true, forKey: "isFirstLaunch")
    }
    
    func setAppearence() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.9686265588, green: 0.9647503495, blue: 0.9645444751, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        
        UITabBar.appearance().backgroundColor = #colorLiteral(red: 1, green: 0.8638570653, blue: 0.6954465771, alpha: 1)
//        UITabBar.appearance().tintColor = UIColor.white
    

    }


}

