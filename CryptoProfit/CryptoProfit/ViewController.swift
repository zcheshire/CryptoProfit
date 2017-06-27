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
    
    var defaultTickers = ["BTC", "ETH", "ANS", "GNT", "SC"]
    var defaultPrices = [""]
    var model = Model()
    
    @IBOutlet weak var tickerTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        model.refresh(tickers: defaultTickers, base: "USD")
        //for (key, value) in model.getData() {
          //  print(value)
            //defaultPrices.append(value)
            
        //}
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //setting background color of entire canvas
        self.view.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
        //removing emmpty cells from tickerTabel
        tickerTable.tableFooterView = UIView()
        
        //setting background color of tickerTable
        tickerTable.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
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
