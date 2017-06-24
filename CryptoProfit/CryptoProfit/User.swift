//
//  User.swift
//  CryptoProfit
//
//  Created by Zachary Cheshire on 6/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation

class User {
    
    var username: String = ""
    var password: String = ""
    var positions: [Position] = []
    
    func getUsername() -> String {
        
        
        return username
        
    }
    
    func getPassword() -> String {
        
        
       return password
        
    }
    
    func getPositions() -> [Position] {
    
        return positions
    
    }
    
    func getTotalInvestment() -> Int {
        
        
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
