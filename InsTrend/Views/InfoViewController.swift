//
//  InfoViewController.swift
//  InsTrend
//
//  Created by mac on 26.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

struct Trend: Decodable {
    var id : Int
    var author : String
    var imageUrl : String
}

class InfoViewController: UIViewController, UICollectionViewDataSource {
    
    var trends = [Trend]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return trends.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as!
            CustomCollectionViewCell

            cell.infoLbl.text = inform[indexPath.row].info.capitalized
            
            return cell
        }

}

