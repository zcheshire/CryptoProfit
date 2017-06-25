//
//  ViewController.swift
//  CryptoProfit
//
//  Created by Zachary Cheshire on 6/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import UIKit

class TickerCellController: UITableViewCell {
    
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
}

class ViewController: UIViewController {
    
    let defaultTickers = ["BTC", "ETH", "ANS", "GNT", "SC"]
    let defaultPrices = ["2513.90", "313.75", "7.95", "0.45", "0.019"]
    
    @IBOutlet weak var tickerTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //setting background color of entire canvas
        self.view.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
        //removing emmpty cells from tickerTabel
        tickerTable.tableFooterView = UIView()
        
        //setting background color of tickerTable
        tickerTable.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tickerTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultTickers.count
    }
    
    func tableView(_ tickerTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Dequeueing array of default tickers to populate cells in table
        let cell = tickerTable.dequeueReusableCell(withIdentifier: "tickerCell", for: indexPath) as! TickerCellController

        //setting background color of cell
        cell.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
            
        //Filling cell tickerLabel with array index : need to replace with ticker object
        cell.tickerLabel.text = defaultTickers[indexPath.row]
        cell.priceLabel.text = "$" + defaultPrices[indexPath.row]
            
            
        //returning populated cell to tickerTable
        return cell
    
    }
    
    func tableView(_ tickerTable: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "DELETE") { action, index in
            print("deleted")
        }
//        delete.backgroundColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
        
        return [delete]
    }
    
    func tableView(_ tickerTable: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}