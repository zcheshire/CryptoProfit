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
        print("IN METHIOD")
        print(model.getCurrentUser().getPositions())
        print(model.getCurrentUser().getPositions().count)
        positions = model.getCurrentUser().getPositions()
        for position in positions {
                if position.isOpen() && data[position.getCoinType()] != nil {
                    print(position.getPositionAmount())
                    print(position.getCoinType())
                    print(position.getCrptoPrice())
                    //print(data[position.getCoinType()]!)
                portfolioValue += (position.getPositionAmount() * data[position.getCoinType()]!)
                } else {
                    if data[position.getCoinType()] != nil {
                portfolioValue -= (position.getPositionAmount() * data[position.getCoinType()]!)
                    }
            }
        }
        print(portfolioValue)
        return portfolioValue
    }
    
    /*
     Returns users current total proft
     
     */
    func getPortfolioProfit() -> Double {
        return 0.0
    }
    func getAmountOfCoins(coin: String) -> Double {
        let pos = model.getCurrentUser().getPositionsForTicker(ticker: coin)
        var amount = 0.0
        for position in pos {
            if position.isOpen() {
                amount += position.getPositionAmount()

            } else {
                
                amount -= position.getPositionAmount()
                
            }
            
        }
        return amount
        
    }
    
    /*
     Returns users current total profit for a particular coin in usd
     
     */
    func getProfitForCoin(coin: String) -> Double {
        let currentWorth = getTotalValueForCoin(coin: coin)
        var initialInvestment = 0.0
        let pos = model.getCurrentUser().getPositionsForTicker(ticker: coin)
        for pos in pos {
            
            if pos.isOpen() {
                
                initialInvestment += pos.getPositionAmount() * pos.getCrptoPrice()
                
            } else {
                
                initialInvestment -= pos.getPositionAmount() * pos.getCrptoPrice()
                
            }
            
        }
        return currentWorth - initialInvestment
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
        var data = model.getData()
        portfolioValue = 0.0
        positions = model.getCurrentUser().getPositionsForTicker(ticker: coin)
        for position in positions {
            if position.isOpen() {
                print(position.getPositionAmount())
                print(position.getCoinType())
                print(data[position.getCoinType()]!)
                portfolioValue += (position.getPositionAmount() * data[position.getCoinType()]!)
            } else {
                
                 portfolioValue -= (position.getPositionAmount() * data[position.getCoinType()]!)
                
            }
            
        }
        
        return portfolioValue
    }
    
    /*
     Returns array of tickers in the users watchlist
     
     */
    func getWatchList() -> [String] {
        return [""]
    }
    
    
}
