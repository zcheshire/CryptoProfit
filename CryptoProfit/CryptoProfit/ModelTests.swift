//
//  ModelTests.swift
//  CryptoProfit
//
//  Created by Jack Bonaguro on 6/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation
import UIKit
import XCTest

class ModelTests: XCTestCase {
    var model: BackendModel!
    
    func ModelTests() {
        
    }
    override func setUp() {
        super.setUp()
        
        self.model = Backend.Model()!
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func TestRefresh(){
        self.model.refresh(base: "USD", tickers: ["ETH", "BTC", "ANS"])
        print(self.model.getData(base: "USD"))
        XCTAssert(self.model.getData(base: "USD"))
    }
};
