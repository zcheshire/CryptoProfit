//
//  CryptoProfitTests.swift
//  CryptoProfitTests
//
//  Created by Jack Bonaguro on 6/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import XCTest

class CryptoProfitTests: XCTestCase {
    
    private var model: Backend.Model!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.model = Backend.Model()
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
