//
//  FullAuthorViewController.swift
//  InsTrend
//
//  Created by mac on 27.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class FullAuthorViewController: UIViewController {
    
    var trends = [Trend]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        let url = URL(string: "https://lyutikovpavel.github.io/Trend.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.trends = try JSONDecoder().decode([Trend].self, from: data!)
                } catch {
                    print("Parse Error")
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }.resume()
    }
}

extension FullAuthorViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return trends.count
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fullAuthorCell", for: indexPath) as!
            CustomCollectionViewCell
            
            cell.lblFull.text = trends[indexPath.row].author
            
            return cell
        }
}
