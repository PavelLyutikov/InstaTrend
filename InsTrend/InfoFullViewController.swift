//
//  InfoFullViewController.swift
//  InsTrend
//
//  Created by mac on 11.06.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class InfoFullViewController: UIViewController {
    
    let totalSize = UIScreen.main.bounds.size
    private let viewModel: TrendsViewModel = TrendsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        loadData()
    }
 //MARK: - setupViews
        private func setupViews() {
            titleBackground.isHidden = false
            titleLabel.isHidden = false

        }
    
    lazy var titleLabel: UILabel = {
            let title = UILabel()
            title.font = UIFont(name: "SFNS Display", size: 23)
//            title.text = "Что может лучше, чем свежая и вкусная  пицца 🍕\nлан такой: заказываем, делаем красивое фото и наслаждаемся 😉"
            title.textAlignment = .center
        title.textColor = .black
        title.layer.cornerRadius = 90
            title.numberOfLines = 0
            self.view.addSubview(title)
            
            title.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(400)
            }
            return title
        }()
    private func loadData() {
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
    lazy var titleBackground: UIImageView = {
        
        var fontSize: CGFloat!
         var bottomIndent: CGFloat!
         if totalSize.height >= 800 {
            bottomIndent = 0
        } else {
            bottomIndent = 100
        }
        
        let title = UIImageView()
        title.image = #imageLiteral(resourceName: "Untitled")
        title.contentMode = .scaleToFill
        title.layer.cornerRadius = 20
        title.layer.masksToBounds = true
        self.view.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.bottom.equalTo(bottomIndent)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(500)
        }
        return title
    }()
}
