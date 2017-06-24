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
    private var cryptoPrice: Int = 0
    private var usdPrice: Int = 0
    private var positionAmount: Int = 0
    private var positionPrice: Int = 0
    private var open: Bool = true
    
    init(coinType: String, cryptoPrice: Int, usdPrice: Int, positionAmount: Int, positionPrice: Int, open: Bool) {
        self.coinType = coinType
        self.cryptoPrice = cryptoPrice
        self.usdPrice = usdPrice
        self.positionAmount = positionAmount
        self.positionPrice = positionPrice
        self.open = open
    }
    
    func getCoinType() -> String {
        return coinType
    }
    
    func getCrptoPrice() -> Int {
        return cryptoPrice
        
    }
    
    func getUsdPrice() -> Int {
        return usdPrice
        
    }
    
    func getPositionAmount() -> Int {
        return positionAmount
    }
    
    func getPositionPrice() -> Int {
        return positionPrice
    }
    func isOpen() -> Bool {
        return open
    }
    
    
    
    
    
    
}
