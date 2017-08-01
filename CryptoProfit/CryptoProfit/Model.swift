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
    
    var data: [String: [String: Any]] = [:]
    var Tickers: [String: String] = [:]
    //private var tickers: [String] = []
    private var prices: [Double] = []
    private var currentUser = User(username: "Zac", password: "123", positions: [], tickers: [])
  
    
    func setCurrentUser(user: User) -> Void {
        self.currentUser = user
    }
    func getCurrentUser() -> User {
        return self.currentUser
    }
    func getCalculator() -> Calculator {
        let calculator = Calculator()
        return calculator
    }
    func addTickerToDataBase() -> Void {
         watch.setValue(model.getCurrentUser().getWatchList())
         model.refresh(tickers: model.getCurrentUser().getWatchList(), base: "USD")


        
    }
    func deleteTicker() -> Void {
        
        
        watch.setValue(model.getCurrentUser().getWatchList())

        
    }
    
    public func refresh(tickers: [String], base: String){
        print("TICKERS IN REFRESH")
        print(tickers)
        var fsyms = ""
         url = "https://min-api.cryptocompare.com/data/pricemulti?"
        //var result = ""
        //self.tickers = tickers
        
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
                    print("WRONG")
                    return
                }
                self.data = responseDict
                

               
                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    public func register(username: String, password: String){
        url = "ec2-34-229-81-117.compute-1.amazonaws.com/register"
        //var result = ""
        //self.tickers = tickers
        
        let urlString = URL(string: url)
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
                    print("WRONGg")
                    return
                }
                self.data = responseDict
                
                
                
                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    public func getTickers(){
        url = "https://www.cryptocompare.com/api/data/coinlist/"
    
        let path = url
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
                guard let responseDictionary = responseObject as? [String: Any] else {
                    print("WRONGby")
                    return
                }
                let temp = responseDictionary["Data"] as! [String: [String: String]]
                for (_, v) in temp {
                    self.Tickers[v["CoinName"]!] = v["FullName"]
                    
                }
                
                
                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    public func getData()-> [String: Double] {
        var tickersWithPrices: [String: Double] = [:]
        for (k, v) in self.data {
            tickersWithPrices[k] = v["USD"] as? Double
            print(v["USD"]!)
        }
        return tickersWithPrices
    }
    func getAllTickers() -> [String: String] {
        print(self.Tickers)
      return self.Tickers
   }
}
