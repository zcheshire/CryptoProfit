//
//  Position.swift
//  CryptoProfit
//
//  Created by Zachary Cheshire on 6/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation

class Position {
    
    private var coinType: String = ""
    private var cryptoPrice: Double = 0
    private var positionAmount: Double = 0
    private var open: Bool = true
    
    init(coinType: String, cryptoPrice: Double, positionAmount: Double, open: Bool) {
        self.coinType = coinType
        self.cryptoPrice = cryptoPrice
        self.positionAmount = positionAmount
        self.open = open
    }
    
    func getCoinType() -> String {
        return coinType
    }
    
    func getCrptoPrice() -> Double {
        return cryptoPrice
        
    }
    
    
    func getPositionAmount() -> Double {
        return positionAmount
    }
    
    func isOpen() -> Bool {
        return open
    }
    
    
}
