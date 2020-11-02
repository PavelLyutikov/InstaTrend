//
//  infoJson.swift
//  InsTrend
//
//  Created by mac on 30.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class infoJson {
    
    let url = URL(string: "https://lyutikovpavel.github.io/info.json")
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
        
        if error == nil {
            
            do {
                self.inform = try JSONDecoder().decode([Info].self, from: data!)
            } catch {
                print("Parse Error")
            }
            DispatchQueue.main.async {
                self.infView.reloadData()
            }
        }
        
    }.resume()
}
