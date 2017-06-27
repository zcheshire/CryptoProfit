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
    
    var defaultTickers = ["","","","",""]
    var defaultPrices: [Double] = [0.0,0.0,0.0,0.0,0.0]
    @IBOutlet weak var tickerTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            model.refresh(tickers: model.getCurrentUser().getWatchList() , base: "USD")
            self.refresh()
        }

        
        // Do any additional setup after loading the view, typically from a nib.
        
        //setting background color of entire canvas
        self.view.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
        //removing emmpty cells from tickerTabel
        tickerTable.tableFooterView = UIView()
        
        //setting background color of tickerTable
        tickerTable.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
        //Creating Navigation Bar with Bookmark Placeholder (Menu) and Search
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.size.width, height: 44))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "Moon");
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        let searchItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: nil, action: #selector(getter: UIAccessibilityCustomAction.selector));
        navItem.rightBarButtonItem = searchItem;
        let bookmarkItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.bookmarks, target: nil, action: #selector(getter: UIAccessibilityCustomAction.selector));
        navItem.leftBarButtonItem = bookmarkItem;
        navBar.setItems([navItem], animated: false);
        navBar.barTintColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false
        
        
        
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Method to resfresh the table when the data is loaded
    func refresh() {
        var seperate: [String: Double]
        self.defaultTickers = []
        self.defaultPrices = []
        
        seperate = model.getData()
        for (k, v) in seperate {
            self.defaultTickers.append(k)
            self.defaultPrices.append(v)
        }
        self.tickerTable.reloadData()
        
        
    }


}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tickerTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Runs loop until the data is loaded from the api
        return defaultTickers.count

    }
    
    func tableView(_ tickerTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Dequeueing array of default tickers to populate cells in table
        let cell = tickerTable.dequeueReusableCell(withIdentifier: "tickerCell", for: indexPath) as! TickerCellController

        //setting background color of cell
        cell.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
            
        //Filling cell tickerLabel with array index : need to replace with ticker object
        cell.tickerLabel.text = defaultTickers[indexPath.row]
       let dp = defaultPrices[indexPath.row]
        cell.priceLabel.text = "$\(dp)"
        
            
        //returning populated cell to tickerTable
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Updating tickerTabel when reordering cells
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tickerTitle = defaultTickers[sourceIndexPath.row]
        let tickerPrice = defaultPrices[sourceIndexPath.row]
        defaultTickers.remove(at: sourceIndexPath.row)
        defaultPrices.remove(at: sourceIndexPath.row)
        defaultTickers.insert(tickerTitle, at: destinationIndexPath.row)
        defaultPrices.insert(tickerPrice, at: destinationIndexPath.row)
    }

    //Creating cell slide button for delete
    func tableView(_ tickerTable: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "DELETE") { action, index in
            print("deleted")
        }
//        delete.backgroundColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
        
        return [delete]
    }
    

}
