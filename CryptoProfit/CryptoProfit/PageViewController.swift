//
//  PageViewController.swift
//  CryptoProfit
//
//  Created by Ash Bhimasani on 6/25/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import UIKit

class PositionCellController: UITableViewCell {
    
    //Static
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var date: UILabel!
    
    //Dynamic
    @IBOutlet weak var posType: UIImageView!
    @IBOutlet weak var quanLabel: UILabel!
    @IBOutlet weak var pricLabel: UILabel!
    @IBOutlet weak var totLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}

class PageViewController: UIViewController {
    
    @IBOutlet weak var posTable: UITableView!
    
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //setting background color of entire canvas
        self.view.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
        //removing emmpty cells from tickerTabel
        posTable.tableFooterView = UIView()
        
        //setting background color of tickerTable
        posTable.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
        //Creating Navigation Bar with Back and Crypto Name
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.size.width, height: 44))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "ETH - Ethereum");
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
//        let backButton = UIButton(type: .custom)
//        backButton.setImage(UIImage(named: "BackButton.png"), for: .normal)
//        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
//        navItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(self.backAction(_:)))

        navBar.setItems([navItem], animated: false);
        navBar.barTintColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false

    }
    
    @IBAction func backAction(_ sender: UIButton) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ posTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ posTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Dequeueing array of default tickers to populate cells in table
        let cell = posTable.dequeueReusableCell(withIdentifier: "posCell", for: indexPath) as! PositionCellController
        
        //setting background color of cell
        cell.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
        let posCircle: UIImage = UIImage(named: "openPos.png")!
        cell.posType.image = posCircle
        
        cell.quantity.text = "Quantity"
        cell.price.text = "Price $"
        cell.total.text = "Total $"
        cell.date.text = "Date"
        
        cell.quanLabel.text = "2.038"
        cell.pricLabel.text = "230.00"
        cell.totLabel.text = "500"
        cell.dateLabel.text = "6/27/17"
        
        //returning populated cell to tickerTable
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Updating tickerTabel when reordering cells
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        
    }
    
    //Creating cell slide button for delete
    func tableView(_ posTable: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "EDIT") { action, index in
            print("edited")
        }
        edit.backgroundColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
        
        return [edit]
    }
    
    
}
