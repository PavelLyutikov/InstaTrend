//
//  DetailsTrendViewController.swift
//  InsTrend
//
//  Created by Вячеслав Кукин on 31.05.2020.
//  Copyright © 2020 mac. All rights reserved.
//
//FULSCREEn
import UIKit
import Kingfisher
import SafariServices

class DetailsTrendViewController: UIViewController {
    
    var trends = [TrendItem]()
    
    let totalSize = UIScreen.main.bounds.size

//    MARK: - CloseButton
             @objc lazy var closeButton: UIButton = {
        
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
 //ViewImage
    lazy var imageView: UIImageView =  {
        var imgView = UIImageView()
        
    
        imgView.layer.cornerRadius = 20
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFit

        self.view.addSubview(imgView)
        
        imgView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(2)
            make.center.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 16)
//            make.height.equalTo(300)
        }
        return imgView
    }()
//MARK: - Autor
    lazy var authorLabel: UILabel = {
        
            var bottom: CGFloat!
            var leading: CGFloat!
            var size: CGFloat!
             if totalSize.height >= 815 {
                bottom = 60
                leading = 20
                size = 20
             } else if totalSize.height <= 700 {
                bottom = 35
                leading = 10
                size = 18
             } else if totalSize.height == 812 {
                bottom = 50
                leading = 20
                size = 20
             } else {
                bottom = 35
                leading = 10
                size = 18
            }
        
        let authorLbl = UILabel()
        authorLbl.textAlignment = .right
        authorLbl.textColor = .black
//        authorLbl.text = NSLocalizedString("", comment: "Автор")
        authorLbl.font = UIFont(name: "SFNS Display", size: size)
        
        self.view.addSubview(authorLbl)
        
        authorLbl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bottom)
            make.leading.trailing.equalToSuperview().inset(leading)
            make.height.equalTo(25)
        }
        
        return authorLbl
        
//        let authorText = UILabel()
//        authorText.textAlignment = .right
//        authorText.textColor = .black
//        authorText.text = "Aвтор:"
//        authorText.font = UIFont(name: "SFNS Display", size: size)
//
//        self.view.addSubview(authorText)
//
//        authorText.snp.makeConstraints { make in
//            make.bottom.equalToSuperview().inset(bottom)
//            make.trailing.leading.equalTo(authorLbl.snp.leading)//.offset(10)
//            make.height.equalTo(25)
//        }
//
//        return authorText
    }()
    lazy var authorLabelText: UILabel = {
        
            var bottom: CGFloat!
            var leading: CGFloat!
            var size: CGFloat!
             if totalSize.height >= 815 {
                bottom = 60
                leading = -20
                size = 20
             } else if totalSize.height <= 700 {
                bottom = 35
                leading = 10
                size = 18
             } else if totalSize.height == 812 {
                bottom = 50
                leading = 20
                size = 20
             } else {
                bottom = 35
                leading = 10
                size = 18
            }
        
        let authorText = UILabel()
        authorText.textAlignment = .right
        authorText.textColor = .black
        authorText.text = NSLocalizedString("Автор:", comment: "Автор")
        authorText.font = UIFont(name: "SFNS Display", size: size)

        self.view.addSubview(authorText)

        authorText.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bottom)
//            make.width.equalTo(authorLabel.snp.width).offset(10)
            make.leading.trailing.equalTo(authorLabel.snp.leading)
            make.height.equalTo(25)
        }

        return authorText
    }()
//MARK: - Istok
    lazy var textLink: String = {
        let textLinkSf = String()
        
        return textLinkSf
    }()
    
    lazy var sourceLabel: UILabel = {
        
        var bottom: CGFloat!
        var leading: CGFloat!
        var size: CGFloat!
         if totalSize.height >= 815 {
            bottom = 70
            leading = 20
            size = 20
         } else if totalSize.height <= 700 {
            bottom = 35
            leading = 10
            size = 18
         } else if totalSize.height == 812 {
            bottom = 70
            leading = 20
            size = 20
         } else {
            bottom = 55
            leading = 10
            size = 18
        }
        
        let srcLabel = UILabel()
//        srcLabel.text = "Instagram"
        srcLabel.textAlignment = .right
        srcLabel.textColor = .black
        srcLabel.font = UIFont(name: "SFNS Display", size: size)
        
        self.view.addSubview(srcLabel)
        
        srcLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(leading)
            make.height.equalTo(25)
        }
        return srcLabel
    }()
//MARK: - ButtonGoInstagram
    @objc lazy var instagramButton: UIButton = {
                
                var bottom: CGFloat!
                if totalSize.height >= 815 {
                    bottom = 130
                 } else if totalSize.height <= 700 {
                    bottom = 60
                 } else if totalSize.height == 812 {
                    bottom = 115
                 } else {
                    bottom = 65
                }
                
            
                let btn = UIButton()
                
                btn.setTitle(NSLocalizedString("Посмотреть Instagram автора", comment: "Посмотреть Instagram автора"), for: .normal)
                btn.setAttributedTitle(.none, for: .normal)
                
                btn.setTitleColor(#colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1), for: .normal)
                self.view.addSubview(btn)

                btn.snp.makeConstraints { make in
//                 make.top.equalTo(imageView.snp.bottom).offset(300)
                    make.bottom.equalToSuperview().inset(bottom)
                    make.centerX.equalToSuperview()
//                 make.leading.trailing.equalToSuperview().inset(4)
                 make.height.equalTo(25)
                }
                
                return btn
            }()
            
            @objc func buttonInstagramAction(sender: UIButton) {
                showSafariVC(for: "https://www.instagram.com/\(textLink)/")
            }
    
            func showSafariVC(for url: String) {
                guard let url = URL(string: url) else {
                    return
                }
                
                let safariVC = SFSafariViewController(url: url)
                present(safariVC, animated: true)
            }
//MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        authorLabelText.isHidden = false
        self.view.backgroundColor = .white
        
//Button
        instagramButton.addTarget(self, action: #selector(buttonInstagramAction(sender:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(buttonCloseAction(sender:)), for: .touchUpInside)
    }
//Trend
    func initData(img: URL, author: String, source: String) {
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: img)
        }
//        self.imageView.image = img
        self.authorLabel.text = NSLocalizedString("Автор:", comment: "Автор") + "\(author)"
        self.sourceLabel.text = NSLocalizedString("Источник: Instagram", comment: "Источник")
        self.textLink = "\(source)"
    }
//Serch
    func initData(imgURL: URL, author: String, source: String) {
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: imgURL)
        }
        self.authorLabel.text = "Автор: \(author)"
        self.sourceLabel.text = NSLocalizedString("Источник: Instagram", comment: "Источник")
        self.textLink = "\(source)"
    }
    
    private func setupUI() {
        self.imageView.isHidden = false
    }
}

