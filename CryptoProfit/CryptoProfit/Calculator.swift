//
//  Calculator.swift
//  CryptoProfit
//
//  Created by Zachary Cheshire on 6/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation

class Calculator {

    private var positions: [Position] = []
    private var portfolioValue: Double = 0.0

    init() {
        self.portfolioValue = 0.0
    }
    
   /*
     Returns users total investment in usd based off of all open positions
 
     */
    func getTotalInvested() -> Double {
     return 0.0
    }
    
    /*
     Returns users current total portfolio value
     
     */
    func getPortfolioValue() -> Double {
        var data = model.getData()
        positions = model.getCurrentUser().getPositions()
        for position in positions {
                if position.isOpen() {
                    print(position.getPositionAmount())
                    print(position.getCoinType())
                    print(data[position.getCoinType()]!)
                portfolioValue += (position.getPositionAmount() * data[position.getCoinType()]!)
                }
            
        }
        
        return portfolioValue
    }
    
    /*
     Returns users current total proft
     
     */
    func getPortfolioProfit() -> Double {
        return 0.0
    }
    
    /*
     Returns users current total profit for a particular coin in usd
     
     */
    func getProfitForCoin(coin: String) -> Double {
        return 0.0
    }
    
    /*
     Returns users total investment for a particular coin in usd
     
     */
    func getTotalInvestmentForCoin(coin: String) -> Double {
        return 0.0
    }
    
    /*
     Returns users total number of coins for a particular coin
     
     */
    func getAmountForCoin(coin: String) -> Double {
        return 0.0
    }
    
    /*
     Returns users current market value for a particular coin
     
     */
    func getTotalValueForCoin(coin: String) -> Double {
        return 0.0
    }
    
    /*
     Returns array of tickers in the users watchlist
     
     */
    func getWatchList() -> [String] {
        return [""]
    }
    
    
}
