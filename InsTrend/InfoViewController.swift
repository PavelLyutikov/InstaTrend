

import UIKit
import SnapKit
import SafariServices
import SwiftyStoreKit
import MessageUI
import MailController

class InfoViewController: UIViewController, MFMailComposeViewControllerDelegate {

    let totalSize = UIScreen.main.bounds.size
    var activityIndicator = UIActivityIndicatorView()
    
    private let sharedSecret = "3c556d36c29e49fcacd8f8cea99983aa"
    private let productID = "com.space.insTrand.InsTrend.fullAccess"
//    let mail = MFMailComposeViewController()
    lazy var titleLabel: UILabel = {
        
        var fontSize: CGFloat!
        var top: CGFloat!
             if totalSize.height >= 815 {
                fontSize = 26
                top = 200
             } else if totalSize.height <= 700 {
                fontSize = 22
                top = 150
             } else if totalSize.height == 812 {
                fontSize = 22
                top = 200
             } else {
                fontSize = 22
                top = 200
        }
        
        let title = UILabel()
        title.font = UIFont(name: "SFNS Display", size: fontSize)
        
        title.text = NSLocalizedString("Мы хотим предложить Вам тематику для создания красивых фотографий. Каждые три дня Вы можете увидеть идеи, которые Вам помогут разнообразить Ваш профиль. Помимо этого вы можете оформить подписку и вам будет доступна общая галерея, которая будет Вас вдохновлять.", comment: "Информация о приложении")
        title.textAlignment = .center
        title.numberOfLines = 0
        title.textColor = .black
        self.view.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(100)
            make.top.equalToSuperview().inset(top)
        }
        
        return title
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActivityIndicator()
        
        view.addSubview(activityIndicator)
//        self.view.backgroundColor = UIColor.white
        setupViews()
//        self.view.backgroundColor = .white
        setupBackground()
        
        mailToButton.addTarget(self, action: #selector(buttonMailToAction(sender:)), for: .touchUpInside)
        politickButton.addTarget(self, action: #selector(buttonPolitickAction(sender:)), for: .touchUpInside)
        serviceButton.addTarget(self, action: #selector(buttonServiceAction(sender:)), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(buttonRestoreAction(sender:)), for: .touchUpInside)
        buttonClose.addTarget(self, action: #selector(buttonCloseAction(sender:)), for: .touchUpInside)
    }

    
    private func setupViews() {
        titleLabel.isHidden = false
    }
//MARK: - MailTo
    @objc lazy var mailToButton: UIButton = {
        
            var constant: CGFloat!
            var width: CGFloat!
            var height: CGFloat!
            var leading: CGFloat!
             if totalSize.height >= 815 {
                constant = 160
                leading = 50
                width = 290
                height = 30
             } else if totalSize.height >= 810 {
                 constant = 160
                 leading = 50
                 width = 290
                 height = 30
             } else if totalSize.height >= 700 {
                constant = 125
                leading = 50
                height = 30
                width = 290
             } else if totalSize.height >= 600 {
                 constant = 125
                leading = 50
                 height = 30
                width = 290
             } else {
                constant = 35
                leading = 50
                height = 30
                width = 180
            }
            
        
            let btn = UIButton()
            
            btn.setTitle(NSLocalizedString("Связаться с нами", comment: "Майл"), for: .normal)
            btn.setAttributedTitle(.none, for: .normal)
            btn.backgroundColor = #colorLiteral(red: 0.7262678146, green: 0.5196889639, blue: 0.2779648602, alpha: 1)
            btn.layer.cornerRadius = 15
            btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.view.addSubview(btn)

            btn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().inset(constant)
                make.width.equalTo(width)
                make.height.equalTo(height)
//                make.trailing.equalToSuperview().inset(leading)
            }
            
            return btn
        }()
        
        @objc func buttonMailToAction(sender: UIButton) {
            
            if let mailComposeViewController = MailController.shared.mailComposeViewController() {

                mailComposeViewController.setToRecipients(["savage.developer.team@gmail.com"])
                mailComposeViewController.setSubject("User InstaTrend")
                mailComposeViewController.setMessageBody("Hello!", isHTML: false)

                present(mailComposeViewController, animated:true, completion:nil)
            } else {
                print("Mail services are not available")
            }
//            if !MFMailComposeViewController.canSendMail() {
//                let composeVC = MFMailComposeViewController()
//                composeVC.mailComposeDelegate = self
//
//                // Configure the fields of the interface.
//                composeVC.setToRecipients(["savage.developer.team@gmail.com"])
//                composeVC.setSubject("User InstaTrend")
//                composeVC.setMessageBody("Hello!", isHTML: false)
//
//                // Present the view controller modally.
//                self.present(composeVC, animated: true, completion: nil)
//
//
//            } else {
//                print("Mail services are not available")
//
//                return
//            }
            
            
            
//           if MFMailComposeViewController.canSendMail() {
//
//
//                mail.mailComposeDelegate = self
//
//                mail.setToRecipients(["savage.developer.team@gmail.com"])
//
//                mail.setSubject("User InstaTrend")
//
//                mail.setMessageBody("", isHTML: true)
//
//                present(mail, animated: true)
//
//           }else{
//
//           print("Application is not able to send an email")
//
//               }
        }
    func mailComposeController(_controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

            _controller.dismiss(animated: true, completion: nil)

    }
        //MARK: - Politick
            @objc lazy var politickButton: UIButton = {
                
                    var constant: CGFloat!
                    var leading: CGFloat!
                    var width: CGFloat!
                    var height: CGFloat!
                     if totalSize.height >= 815 {
                        constant = 70
                        leading = 50
                        width = 290
                        height = 30
                     } else if totalSize.height >= 810 {
                         constant = 70
                         leading = 35
                        width = 290
                        height = 30
                     } else if totalSize.height >= 700 {
                        constant = 45
                        leading = 25
                        width = 290
                        height = 30
                     } else if totalSize.height >= 600 {
                         constant = 45
                         leading = 25
                        width = 290
                        height = 30
                     } else {
                        constant = 35
                        leading = 25
                        width = 180
                        height = 30
                    }
                    
                
                    let btn = UIButton()
                    
                    btn.setTitle(NSLocalizedString("Политика конфиденциальности", comment: "Политика конфиденциальности"), for: .normal)
                    btn.setAttributedTitle(.none, for: .normal)
                    btn.backgroundColor = #colorLiteral(red: 0.7262678146, green: 0.5196889639, blue: 0.2779648602, alpha: 1)
                    btn.layer.cornerRadius = 15
                    btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                    self.view.addSubview(btn)

                    btn.snp.makeConstraints { make in
                        make.centerX.equalToSuperview()
                        make.bottom.equalToSuperview().inset(constant)
                        make.width.equalTo(width)
                        make.height.equalTo(height)
//                        make.trailing.equalToSuperview().inset(leading)
                    }
                    
                    return btn
                }()
                
                @objc func buttonPolitickAction(sender: UIButton) {
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
                    var width: CGFloat!
                    var height: CGFloat!
                    var leading: CGFloat!
                     if totalSize.height >= 815 {
                        constant = 115
                        leading = 50
                        width = 290
                        height = 30
                     } else if totalSize.height >= 810 {
                     constant = 115
                     leading = 50
                     width = 290
                     height = 30
                     } else if totalSize.height >= 700 {
                     constant = 85
                        leading = 50
                        width = 290
                        height = 30
                     } else if totalSize.height >= 600 {
                         constant = 85
                        leading = 50
                        width = 290
                        height = 30
                     } else {
                        constant = 70
                        leading = 50
                        width = 180
                        height = 30
                    }
            
                    let btn = UIButton()
                    
                    btn.setTitle(NSLocalizedString("Восстановление покупок", comment: "Восстановление покупок"), for: .normal)
                    btn.setAttributedTitle(.none, for: .normal)
                    btn.backgroundColor = #colorLiteral(red: 0.7262678146, green: 0.5196889639, blue: 0.2779648602, alpha: 1)
                    btn.layer.cornerRadius = 15
                    btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                    self.view.addSubview(btn)

                    btn.snp.makeConstraints { make in
                        make.centerX.equalToSuperview()
                        make.bottom.equalToSuperview().inset(constant)
                        make.width.equalTo(width)
                        make.height.equalTo(height)
//                        make.leading.equalToSuperview().inset(leading)
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
    private func showErrorRestoreAlert() {
        let alert = UIAlertController(title: "Error", message: "An error occurred while restoring the purchase. Either it is expired or was not purchased", preferredStyle: .alert)
            
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alert, animated: true, completion: nil)
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
        //MARK: - Service
            @objc lazy var serviceButton: UIButton = {
                
                        var constant: CGFloat!
                        var height: CGFloat!
                        var width: CGFloat!
                        var leading: CGFloat!
                         if totalSize.height >= 815 {
                            constant = 25
                            leading = 50
                            width = 290
                            height = 30
                         } else if totalSize.height >= 810 {
                         constant = 25
                         leading = 50
                         width = 290
                         height = 30
                         } else if totalSize.height >= 700 {
                            constant = 5
                            leading = 50
                            width = 290
                            height = 30
                         } else if totalSize.height >= 600 {
                             constant = 5
                            leading = 50
                            width = 290
                            height = 30
                         } else {
                            constant = 0
                            leading = 50
                            width = 180
                            height = 30
                        }
                        
                        let btn = UIButton()
                        
                        btn.setTitle(NSLocalizedString("Условия обслуживания", comment: "Условия обслуживания"), for: .normal)
                        btn.setAttributedTitle(.none, for: .normal)
                        btn.backgroundColor = #colorLiteral(red: 0.7262678146, green: 0.5196889639, blue: 0.2779648602, alpha: 1)
                        btn.layer.cornerRadius = 15
                        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                        self.view.addSubview(btn)

                        btn.snp.makeConstraints { make in
                            make.centerX.equalToSuperview()
                            make.width.equalTo(width)
                            make.height.equalTo(height)
                            make.bottom.equalToSuperview().inset(constant)
//                            make.leading.equalToSuperview().inset(leading)
                        }
                        
                        return btn
                    }()
                    
                    @objc func buttonServiceAction(sender: UIButton) {
                       showSafariVC(for: "https://lyutikovpavel.github.io/politic.html")
                    }
//    MARK: - ButtnBar
         @objc lazy var buttonClose: UIButton = {
    
                    var rightSize: CGFloat!
                    var topSize: CGFloat!
                    if totalSize.height >= 800 {
                       rightSize = 20
                        topSize = 20
                   } else {
                       rightSize = 20
                        topSize = 20
                   }
    
                   let btn = UIButton()
    
                   btn.setImage(#imageLiteral(resourceName: "Group 1 (2)"), for: .normal)
                   btn.contentMode = .scaleAspectFit
//            btn.layer.zPosition = 30
                   self.view.addSubview(btn)
    
                   btn.snp.makeConstraints { make in
                       make.height.equalTo(15)
                       make.width.equalTo(50)
                       make.top.equalToSuperview().inset(topSize)
                    make.centerX.equalToSuperview()
//                    make.trailing.leading.equalToSuperview().inset(rightSize)
                   }
    
                   return btn
               }()

               @objc func buttonCloseAction(sender: UIButton) {

                dismiss(animated: true, completion: nil)
               }
        
    //MARK: - backgroundImage
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
        private func setupBackground() {
            self.backgroundImage.isHidden = false
        }
    
    func showSafariVC(for url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
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

