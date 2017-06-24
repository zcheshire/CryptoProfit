//
//  Calculator.swift
//  CryptoProfit
//
//  Created by Zachary Cheshire on 6/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation

class Calculator {
    var initialPosition: Int = 0
    var currentPosition: Int = 0
    var coinType: String = ""
    var cryptoPrice: Int = 0
    var cryptoAmount: Int = 0
    var profit: Int = 0
    var closed: Int = 0
    
    func getProfit(positions: [Position]) -> Int {
       
        for position in positions {
            if position.isOpen() { //If the position is a buy order
                coinType = position.getCoinType() //Get positions coin tpye
                cryptoPrice = position.getCrptoPrice() //Get coins price at time of order
                cryptoAmount = position.getPositionAmount() //Gets amount of coin ordered
                initialPosition = initialPosition + (cryptoPrice * cryptoAmount) //Calculates usd of total amount invested
                currentPosition = currentPosition + 1 //+ (model.getCrpytoPrice(coinType) * cryptoAmount) //Calculates how much the position is currently worth
                profit = profit + (currentPosition - initialPosition) //Add difference of initial position value and current position value
            }
            
            if !position.isOpen() { //Check if position was a sell order
                
                coinType = position.getCoinType() //Get positions coin type
                cryptoPrice = position.getCrptoPrice() //Get coins price at time of sell order
                cryptoAmount = position.getPositionAmount() //Get amount of coin sold
                closed = initialPosition - (cryptoPrice * cryptoAmount) // Gets total usd value of the sell position
                //currentPosition = currentPosition + 1 //+ (model.getCrpytoPrice(coinType) * cryptoAmount)
                profit = profit - closed //Subtract sold amount from total profit
                
            }
            
        }
        return profit
        
    }
    
    func getCoins(positions: [Position]) -> Int {
        cryptoAmount = 0
        for position in positions {
            
            if position.isOpen() {
                cryptoAmount = cryptoAmount + position.getPositionAmount()
                
            }
            
            if !position.isOpen() {
                cryptoAmount = cryptoAmount - position.getPositionAmount()
                
            }
            
        }
        return cryptoAmount
    }
    
    
}
