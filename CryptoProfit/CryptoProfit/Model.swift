//
//  Model.swift
//  CryptoProfit
//
//  Created by Jack Bonaguro on 6/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation

public class Model {
    private var url: String = ""
    
    private var data: [String: String] = [:]
    
    public func Model(){
    }
    
    public func refresh(tickers: [String], base: String){
        var fsyms = ""
         url = "https://min-api.cryptocompare.com/data/pricemulti?"
        //var result = ""
        
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
                guard let responseDict = responseObject as? NSDictionary else {
                    return
                }
                dump(responseDict)
                self.data = responseDict as! [String : String]
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    public func getPrices()-> [String: String] {
        return self.data
    }
}
