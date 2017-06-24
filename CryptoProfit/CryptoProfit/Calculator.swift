//
//  Calculator.swift
//  CryptoProfit
//
//  Created by Zachary Cheshire on 6/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation

class Calculator {
    
    func getProfit(positions: [Position]) -> Int {
        var initialPosition: Int
        var currentPosition: Int
        var coinType: String
        var cryptoPrice: Int
        var cryptoAmount: Int
        var profit: Int
        for position in positions {
            if position.isOpen() {
                coinType = position.getCoinType()
                cryptoPrice = position.getCrptoPrice()
                cryptoAmount = position.getPositionAmount()
                initialPosition = initialPosition + (cryptoPrice * cryptoAmount)
                currentPosition = currentPosition + 1 //+ (model.getCrpytoPrice(coinType) * cryptoAmount)
                profit = (currentPosition - initialPosition)
            }
            
            if !position.isOpen() {
                
                coinType = position.getCoinType()
                cryptoPrice = position.getCrptoPrice()
                cryptoAmount = position.getPositionAmount()
                initialPosition = initialPosition - (cryptoPrice * cryptoAmount)
                //currentPosition = currentPosition + 1 //+ (model.getCrpytoPrice(coinType) * cryptoAmount)
                profit = profit - initialPosition
                
            }
            
        }
        return profit
        
    }
    
    func getTotalInvestment(positions: [Position]) -> Int {
        <#function body#>
    }
    
    
}
