//
//  ModelTests.swift
//  CryptoProfit
//
//  Created by Zachary Cheshire on 6/26/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation

class ModelTests {
    var results: String = ""
    var model = Model()
    func callAPI(tickers: [String], base: String) -> Void {
        model.refresh(tickers: tickers, base: base)
    }
    
}
