//
//  Position.swift
//  CryptoProfit
//
//  Created by Zachary Cheshire on 6/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase


class Position {
    
    private var coinType: String = ""
    private var cryptoPrice: Double = 0
    private var positionAmount: Double = 0
    private var open: Bool = true
    private var key: String
    private var ref: FIRDatabaseReference?
    
    init(coinType: String, cryptoPrice: Double, positionAmount: Double, open: Bool, key: String = "") {
        self.coinType = coinType
        self.cryptoPrice = cryptoPrice
        self.positionAmount = positionAmount
        self.open = open
        self.key = key
        self.ref = nil
    }
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        print("PRINTINT SNAP VALUE")
        print(snapshot.value!)
         let snapshotValue = snapshot.value as! [String: AnyObject]
            print("INITAL")
            print(snapshotValue)
            coinType = snapshotValue["name"] as! String
            cryptoPrice = snapshotValue["price"] as! Double
            positionAmount = snapshotValue["amount"] as! Double
            open = snapshotValue["open"] as! Bool
            
        

        ref = snapshot.ref
    }
    
    func getCoinType() -> String {
        return coinType
    }
    
    func getCrptoPrice() -> Double {
        return cryptoPrice
        
    }
    
    
    func getPositionAmount() -> Double {
        return positionAmount
    }
    
    func isOpen() -> Bool {
        return open
    }
    func toAnyObject() -> Any {
        return [
            "name": coinType,
            "price": cryptoPrice,
            "amount": positionAmount,
            "open": open
        ]
    }
    
    
}
