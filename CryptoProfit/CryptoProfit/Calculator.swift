//
//  Calculator.swift
//  CryptoProfit
//
//  Created by Zachary Cheshire on 6/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation

class Calculator {
    var initialPosition: Double = 0
    var currentPosition: Double = 0
    var coinType: String = ""
    var cryptoPrice: Double = 0
    var cryptoAmount: Double = 0
    var profit: Double = 0
    var closed: Double = 0
    var positions: [Positions] = []
    
    func getProfit() -> Double {
        do {
            
            positions = try context.fetch(Positions.fetchRequest())
            
        } catch {
            
            
            //handle error
        }
       
        for position in positions {
            if position.open { //If the position is a buy order
                coinType = position.coinType! //Get positions coin tpye
                cryptoPrice = position.cryptoPrice //Get coins price at time of order
                cryptoAmount = position.positionAmount //Gets amount of coin ordered
                initialPosition = initialPosition + (cryptoPrice * cryptoAmount) //Calculates usd of total amount invested
                currentPosition = currentPosition + 1 //+ (model.getCrpytoPrice(coinType) * cryptoAmount) //Calculates how much the position is currently worth
                profit = profit + (currentPosition - initialPosition) //Add difference of initial position value and current position value
            }
            
            if !position.open { //Check if position was a sell order
                
                coinType = position.coinType! //Get positions coin type
                cryptoPrice = position.cryptoPrice //Get coins price at time of sell order
                cryptoAmount = position.positionAmount //Get amount of coin sold
                closed = initialPosition - (cryptoPrice * cryptoAmount) // Gets total usd value of the sell position
                //currentPosition = currentPosition + 1 //+ (model.getCrpytoPrice(coinType) * cryptoAmount)
                profit = profit - closed //Subtract sold amount from total profit
                
            }
            
        }
        return profit
        
    }
    
    func getTotalInvestment(positions: [Position]) -> Int {
        
        return 0
    }
    
    
    
}
