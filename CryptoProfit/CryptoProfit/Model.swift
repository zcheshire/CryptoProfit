//
//  Model.swift
//  CryptoProfit
//
//  Created by Jack Bonaguro on 6/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation

var model = Model()

public class Model {
    private var url: String = ""
    
    private var data: [String: [String: Any]] = [:]
    private var tickers: [String] = []
    private var prices: [Double] = []
    private var currentUser = User(username: "Jim", password: "123", positions: [], tickers: ["ETH","BTC","SC","ANS","GNT"])
    
    public func Model(){
    }
    
    func setCurrentUser(user: User) -> Void {
        self.currentUser = user
    }
    func getCurrentUser() -> User {
        return self.currentUser
    }
    
    public func refresh(tickers: [String], base: String){
        var fsyms = ""
         url = "https://min-api.cryptocompare.com/data/pricemulti?"
        //var result = ""
        self.tickers = tickers
        
        for (index, t) in tickers.enumerated() {
            if (index < tickers.count - 1) {
                fsyms += t + ","
            } else {
                fsyms += t
            }
        }
         let path = url + "fsyms=" + fsyms + "&tsyms=" + base
        print(path)
        
        let urlString = URL(string: path)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: urlString!)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                print("HTTP Error")
                return
            }
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                guard let responseDict = responseObject as? [String: [String: Any]] else {
                    return
                }
                print(responseDict)
                
                self.data = responseDict

               
                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    public func getData()-> [String: Double] {
        var tickersWithPrices: [String: Double] = [:]
        for (k, v) in data {
            tickersWithPrices[k] = v["USD"] as? Double
            print(v["USD"]!)
        }
        return tickersWithPrices
    }
    
}
