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
        url = "https://min-api.cryptocompare.com/data/price?"
    }
    
    public func refresh(base: String, tickers: [String]){
        var path = url + "fsym=" + base + "&tsyms="
        //var result = ""
        
        for (index, t) in tickers.enumerated() {
            if (index < tickers.count - 1) {
                path += t + ","
            } else {
                path += t
            }
        }
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
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("Response: \(dataString)")
            self.data[base] = dataString as String?
        }
        task.resume()
    }
    
    public func getData(base: String)-> String {
        return self.data[base]!
    }
}
