//
//  RootTabBarViewController.swift
//  InsTrend
//
//  Created by Вячеслав Кукин on 31.05.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController {
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        loadViews()
    }
    
@objc func buttonAction(sender: UIButton) {


    }
    
    //VIEW
    func loadViews () {
        
        let trendsCollectionScreen = UINavigationController(rootViewController: TrendsViewController())
        let searchScreen = UINavigationController(rootViewController: SearchTrendsViewController())
        
        
        let profileStoryboard = UIStoryboard(name: "InstagramApi", bundle: nil)
        let vc = profileStoryboard.instantiateViewController(withIdentifier: "InstagramApiNavigation")
        
        
        let infoScreen = InfoViewController()
        
    //itemBar
        trendsCollectionScreen.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)

        searchScreen.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
//        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 2)
        vc.tabBarItem = UITabBarItem(title: "Планировщик", image: #imageLiteral(resourceName: "photo "), tag: 2)
        infoScreen.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 2)
        
        viewControllers = [trendsCollectionScreen, searchScreen, vc]
        
        
    }
//BAR
    private func setupTabBar() {
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowColor = UIColor.clear.cgColor
        tabBar.layer.shadowOpacity = 0.3
        tabBar.tintColor = #colorLiteral(red: 0.7673814893, green: 0.6643878222, blue: 0.5294302702, alpha: 1)
        tabBar.backgroundColor = #colorLiteral(red: 1, green: 0.8638570653, blue: 0.6954465771, alpha: 1)
    }
}
