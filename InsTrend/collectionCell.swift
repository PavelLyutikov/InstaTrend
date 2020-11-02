//
//  collectionCell.swift
//  InsTrend
//
//  Created by mac on 30.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class collectionCell {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inform.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCell", for: indexPath) as!
        CustomCollectionViewCell

        
        cell.infoLbl.text = inform[indexPath.row].info.capitalized
        
        return cell
    }
    
}
