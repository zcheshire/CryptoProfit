//
//  User.swift
//  CryptoProfit
//
//  Created by Zachary Cheshire on 6/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation

class User {
    
    private var username: String = ""
    private var password: String = ""
    private var positions: [Position] = []
    private var watchListTickers = ["ETH","BTC","SC","ANS","GNT"]
    
    init(username: String, password: String, positions: [Position], tickers: [String]) {
        self.username = username
        self.watchListTickers = tickers
        self.password = password
        self.positions = positions
    }
    
    func getWatchList() -> [String] {
        return watchListTickers
    }
    func addTicker(ticker: String) -> Void {
        self.watchListTickers.append(ticker)
    }
    
    func getUsername() -> String {
        
        
        return username
        
    }
    
    func getPassword() -> String {
        
        
       return password
        
    }
    
    func getPositions() -> [Position] {
    
        return positions
    
    }
    
    func getTotalInvestment() -> Double {
        
        
      return 0
        
    }
    
    func setUsername(username: String) -> Void {
        self.username = username
    }
    
    func setPassword(password: String) -> Void {
        self.password = password
    }
    
    func addPosition(position: Position) -> Void {
        self.positions.append(position)
        
    }
    
    
    
    
    
    
}
