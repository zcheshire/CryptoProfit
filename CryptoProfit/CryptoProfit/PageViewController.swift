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
    var position: [Position] = []

    @IBOutlet var totalAmount: UILabel!
    
    @IBOutlet var profitAmount: UILabel!
    var tickerTitle: String? = ""
    
    @IBOutlet weak var posTable: UITableView!
    
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalAmount.text = "$\(model.getCalculator().getTotalValueForCoin(coin: self.tickerTitle!))"
        totalAmount.textColor = .white
        profitAmount.text = "$\(model.getCalculator().getProfitForCoin(coin: self.tickerTitle!))"
        profitAmount.textColor = .white
        // Do any additional setup after loading the view, typically from a nib.
        
        print(self.tickerTitle!)
        position = model.getCurrentUser().getPositionsForTicker(ticker: self.tickerTitle!)
        
        //setting background color of entire canvas
        self.view.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
        //removing emmpty cells from tickerTabel
        posTable.tableFooterView = UIView()
        
        //setting background color of tickerTable
        posTable.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
        //Creating Navigation Bar with Back and Crypto Name
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.size.width, height: 44))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: tickerTitle!);
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
    
    func backAction(_ sender: UIButton) {
        performSegue(withIdentifier: "backSegue", sender: Any?.self)
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
        for pos in position {
        cell.quanLabel.text = "\(pos.getPositionAmount())"
        cell.pricLabel.text = "\(pos.getCrptoPrice())"
        let total = pos.getPositionAmount() * pos.getCrptoPrice()
        cell.totLabel.text = "\(total)"
        cell.dateLabel.text = "6/27/17"
        }
        
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
