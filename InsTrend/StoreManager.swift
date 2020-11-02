//
//  StoreManager.swift
//  InsTrend
//
//  Created by mac on 22.03.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import StoreKit

class StoreManager: NSObject {
    class func didBayFullVersion() {
        UserDefaults.resetStandardUserDefaults()
    }
}
