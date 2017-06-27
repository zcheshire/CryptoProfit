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
    private var positions: [Positions] = []
    var coinCount: [String: Double] = [:]
    
    init(username: String, password: String, positions: [Positions]) {
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
    
    func getPositions() -> [Positions] {
    
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
    
    func addPosition(position: Positions) -> Void {
        self.positions.append(position)
        
    }
    
    func calculatePosition() -> Calculator {
        
        let calc = Calculator(positions: getPositions())
        return calc
        
    }
    
    
    
    
    
}
