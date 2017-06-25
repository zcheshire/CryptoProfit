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
    var coinCount: [String: Double] = [:]
    
    init(username: String, password: String, positions: [Position]) {
        self.username = username
        self.password = password
        self.positions = positions
        let user = Users(context: context)
        user.username = username
        user.password = password
        appDelegate.saveContext()
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
    
    func getCoinCount() -> [String: Double] {
        var coinType: String
        var cryptoAmount: Double
        for position in positions {
            if position.isOpen() { //If the position is a buy order
                coinType = position.getCoinType() //Get positions coin tpye
                cryptoAmount = position.getPositionAmount() //Gets amount of coin ordered
                coinCount[coinType] = coinCount[coinType]! + cryptoAmount
            }
            
            if !position.isOpen() { //Check if position was a sell order
                
                coinType = position.getCoinType() //Get positions coin tpye
                cryptoAmount = position.getPositionAmount() //Gets amount of coin ordered
                coinCount[coinType] = coinCount[coinType]! - cryptoAmount
                
            }
            
        }
        return coinCount
    }
    
    
    
    
    
}
