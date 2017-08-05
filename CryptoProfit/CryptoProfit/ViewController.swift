//
//  ViewController.swift
//  CryptoProfit
//
//  Created by Zachary Cheshire on 6/23/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class TickerCellController: UITableViewCell {
    
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
}

class ViewController: UIViewController {
    let userID = FIRAuth.auth()?.currentUser?.uid
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
        
        
        
    }()

    var seperate: [String: Double] = [:]
    var defaultTickers: [String] = ["","",""]
    var defaultPrices: [Double] = [0.0,0.0,0.0]

    @IBOutlet weak var tickerTable: UITableView!
    
    @IBOutlet weak var portfolioVal: UILabel!
    let watchListRef = ref.child("watchList")


    
    
    var vcPass: String = ""
    let blackView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        users = ref.child(userID!)
        
        print("ZONE2")
        print(model.getCurrentUser().getWatchList())
        
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { (timer) in
            model.refresh(tickers: model.getCurrentUser().getWatchList(), base: "USD")
            self.refresh()
        }
        
      
      
    
        portfolioVal.text = "$0"
      
    
        // Do any additional setup after loading the view, typically from a nib.
        
        //setting background color of entire canvas
        self.view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.15, alpha:1.0)
        
        //removing emmpty cells from tickerTabel
        tickerTable.tableFooterView = UIView()
        
        //setting background color of tickerTable
        tickerTable.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.15, alpha:1.0)
        
        //Creating Navigation Bar with Bookmark Placeholder (Menu) and Search
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.size.width, height: 44))
        self.view.addSubview(navBar);
        
        let logo = UIImage(named: "smallLogo")
        let imageView = UIImageView(image: logo)
        
        let navItem = UINavigationItem(title: "Selene");
        navItem.titleView = imageView
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        let searchItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(self.searchAction(_:)))
        navItem.rightBarButtonItem = searchItem;

        let menuItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(openMenu))
        navItem.leftBarButtonItem = menuItem;
        
        
        navBar.setItems([navItem], animated: false);
        navBar.barTintColor = UIColor(red:0.08, green:0.08, blue:0.15, alpha:1.0)
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false
        
        
        
    }
  
    func openMenu() -> Void {
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
//            collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))

            window.addSubview(blackView)
            window.addSubview(collectionView)
            blackView.frame = window.frame
            blackView.alpha = 0
            collectionView.frame = CGRect(x: -window.frame.width/2, y: 0, width: window.frame.width/2, height: window.frame.height)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: 0, width: self.collectionView.frame.width,height: self.collectionView.frame.height)
                
            })
        }
        

        
    }
    func handleDismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.collectionView.frame = CGRect(x: -(UIApplication.shared.keyWindow?.frame.width)!/2, y: 0, width:(UIApplication.shared.keyWindow?.frame.width)!/2, height: (UIApplication.shared.keyWindow?.frame.height)!)
            
        })
        blackView.alpha = 0
        
    }
    func searchAction(_ sender: UIButton) {
        performSegue(withIdentifier: "searchSegue", sender: Any?.self)
    }
    
    func logoutAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    //Method to resfresh the table when the data is loaded
    
    
    @objc func tableView(_ tickerTable: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tickerTable.cellForRow(at: indexPath as IndexPath)
        tickerTable.deselectRow(at: indexPath as IndexPath, animated: true)
        
        vcPass = model.getCurrentUser().getWatchList()[indexPath.row]
        
        performSegue(withIdentifier: "cellSegue", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let passData = vcPass
        if let destinationVC = segue.destination as? PageViewController {
            destinationVC.tickerTitle = passData
        }
    }
    
    func refresh() {
        
        self.defaultTickers = []
        self.defaultPrices = []
        seperate = model.getData()
        for (k, v) in seperate {
            self.defaultTickers.append(k)
            self.defaultPrices.append(v)
        }
        self.tickerTable.reloadData()
        let totalValue = String(format: "%.2f",model.getCalculator().getPortfolioValue())
        portfolioVal.text = "$\(totalValue)"

        
    }
    
    func tableView(_ tickerTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Runs loop until the data is loaded from the api
        return model.getCurrentUser().getWatchList().count

    }
    
    func tableView(_ tickerTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Dequeueing array of default tickers to populate cells in table
        let cell = tickerTable.dequeueReusableCell(withIdentifier: "tickerCell", for: indexPath) as! TickerCellController

        //setting background color of cell
        cell.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.15, alpha:1.0)
        
            
        //Filling cell tickerLabel with array index : need to replace with ticker object
        cell.tickerLabel.text = model.getCurrentUser().getWatchList()[indexPath.row]
         let dp = seperate[model.getCurrentUser().getWatchList()[indexPath.row]]
        if dp != nil {
        cell.priceLabel.text = ("\(dp!)")
        } else {
         cell.priceLabel.text = "0"
        }
        
            
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
        model.getCurrentUser().setWatchList(watchList: defaultTickers)
        
    }

    //Creating cell slide button for delete
    func tableView(_ tickerTable: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "DELETE") { action, index in
            var tickers = model.getCurrentUser().getWatchList()
            print("ENTER")
            tickers.remove(at: index.item)
            model.getCurrentUser().setWatchList(watchList: tickers)
            model.deleteTicker()
            self.refresh()
            tickerTable.reloadData()
        }
//        delete.backgroundColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
        
        return [delete]
    }
    

}
