//
//  PreviewViewController.swift
//  InsTrend
//
//  Created by mac on 01.08.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SnapKit
import SafariServices
import SwiftyStoreKit
import UserNotifications

class PreviewViewController: UIViewController {

    let totalSize = UIScreen.main.bounds.size
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        
        notificationButton.addTarget(self, action: #selector(buttonNotificationAction(sender:)), for: .touchUpInside)
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
            }
                return background
            }()
//MARK: - ImagePhoto
    lazy var imagePhoto: UIImageView =  {
        
                var constant: CGFloat!
                if totalSize.height >= 815 {
                        constant = -80
                     } else if totalSize.height <= 700 {
                        constant = -145
                     } else if totalSize.height == 812 {
                        constant = -100
                     } else {
                        constant = -115
                }
                
                var image = UIImageView(image: #imageLiteral(resourceName: "Simulator Screen Shot - iPhone Xʀ - 2020-08-01 at 01.14.36"))
                
                image.clipsToBounds = true
                image.contentMode = .scaleAspectFit
                image.layer.zPosition = -1
                self.view.addSubview(image)


                image.snp.makeConstraints { make in
                    make.top.equalToSuperview().inset(constant)
                    make.leading.trailing.equalToSuperview().inset(0)
            }
                return image
            }()
//MARK: - Info
        lazy var infoLabel: UILabel = {
            
                    var constant: CGFloat!
                    var size: CGFloat!
                    var leading: CGFloat!
                    if totalSize.height >= 815 {
                            constant = 180
                            size = 20
                            leading = 40
                         } else if totalSize.height <= 700 {
                            size = 17
                            constant = 130
                            leading = 15
                         } else if totalSize.height == 812 {
                            constant = 200
                            size = 16
                            leading = 20
                         } else {
                            size = 18
                            constant = 150
                            leading = 15
                    }
            
                    let title = UILabel()
                    title.font = .systemFont(ofSize: size, weight: .light)
                    title.text = NSLocalizedString("БЕСПЛАТНО: Ищите новые идеи? Каждые 3 дня мы будем обновлять их для Вас, таймер в нижней части подскажет сколько осталось времени до следующего обновления.", comment: "Описание превью")
                    title.textColor = .black
                    title.textAlignment = .center
                    title.numberOfLines = 0
                    self.view.addSubview(title)
                    
                    title.snp.makeConstraints { make in
                        make.bottom.equalToSuperview().inset(constant)
                        make.leading.trailing.equalToSuperview().inset(leading)
                    }
                    return title
                }()
    
//MARK: Button
        @objc lazy var goButton: UIButton = {
            var constant: CGFloat!
            var width: CGFloat!
            var height: CGFloat!
            if totalSize.height >= 815 {
                    constant = 80
                    width = 300
                    height = 55
                 } else if totalSize.height <= 700 {
                    constant = 50
                    width = 260
                    height = 45
                 } else if totalSize.height == 812 {
                    constant = 80
                    width = 300
                    height = 55
                 } else {
                    constant = 60
                    width = 300
                    height = 55
            }
            
            let btn = UIButton()
            
            btn.setTitle(NSLocalizedString("Продолжить", comment: "Продолжить"), for: .normal)
            btn.backgroundColor = #colorLiteral(red: 0.7262678146, green: 0.5196889639, blue: 0.2779648602, alpha: 1)
            btn.layer.cornerRadius = 25
            self.view.addSubview(btn)
            
            btn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.height.equalTo(height)
                make.width.equalTo(width)
                make.bottom.equalToSuperview().inset(constant)
            }
            
            return btn
        }()
        
        @objc func buttonAction(sender: UIButton) {
                   goToBuyViewController()
    }
//MARK: - NotificationButton
    @objc lazy var notificationButton: UIButton = {
            var constant: CGFloat!
            var width: CGFloat!
            var height: CGFloat!
            if totalSize.height >= 815 {
                    constant = 80
                    width = 300
                    height = 55
                 } else if totalSize.height <= 700 {
                    constant = 50
                    width = 260
                    height = 45
                 } else if totalSize.height == 812 {
                    constant = 80
                    width = 300
                    height = 55
                 } else {
                    constant = 60
                    width = 300
                    height = 55
            }
            
            let btn = UIButton()
            
            btn.setTitle(NSLocalizedString("Разрешить уведомления", comment: "Разрешить уведомления"), for: .normal)
            btn.backgroundColor = #colorLiteral(red: 0.7262678146, green: 0.5196889639, blue: 0.2779648602, alpha: 1)
            btn.layer.cornerRadius = 25
            self.view.addSubview(btn)
            
            btn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.height.equalTo(height)
                make.width.equalTo(width)
                make.bottom.equalToSuperview().inset(constant)
            }
            
            return btn
        }()
        
        @objc func buttonNotificationAction(sender: UIButton) {
                   enableNotification()
            goButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
    }
    func enableNotification() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { (settings) in
                print(settings)
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
    }

    //MARK: - And
//        lazy var titleLabel: UILabel = {
//
//                    var constant: CGFloat!
//                     if totalSize.height >= 800 {
//                        constant = 40
//                    } else if totalSize.height >= 600 {
//                        constant = 12
//                    } else {
//                        constant = -80
//                    }
//
//                    let title = UILabel()
//                    title.font = .systemFont(ofSize: 18, weight: .light)
//                    title.text = "and"
//                    title.textColor = .black
//                    title.textAlignment = .center
//                    title.numberOfLines = 0
//                    self.view.addSubview(title)
//
//                    title.snp.makeConstraints { make in
//                        make.bottom.equalToSuperview().inset(constant)
//                        make.centerX.equalToSuperview()
//        //                make.height.equalTo(100)
//                    }
//                    return title
//                }()
        
        private func goToBuyViewController(){
            
            let vc = BuyViewController()

            vc.modalPresentationStyle = .fullScreen

            let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            view.window!.layer.add(transition, forKey: kCATransition)

            present(vc, animated: false, completion: nil)
        }
}
