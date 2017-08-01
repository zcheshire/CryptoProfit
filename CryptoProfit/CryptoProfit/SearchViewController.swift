//
//  SearchViewController.swift
//  CryptoProfit
//
//  Created by Ash Bhimasani on 6/28/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation

import UIKit

class SearchCellController: UITableViewCell {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var ticker: UILabel!
    @IBOutlet weak var addTicker: UIButton!
    
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTable: UITableView!

    var tickerDict: [String: String] = model.getAllTickers()
    
    var searchList: [String] = []
    
    var searchActive: Bool = false
    
    var filteredSearch: [String] = []
    
    //let searchController = UISearchController(searchResultsController: nil)
    
   // var searchBar =  UISearchBar() //searchController.searchBar
    var mySearchBar: UISearchBar!

    
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//       print("FUCK WITH ME")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mySearchBar = UISearchBar()
        mySearchBar.delegate = self
        mySearchBar.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        // hide cancel button
        mySearchBar.showsCancelButton = false
        //setting background color of entire canvas
        self.view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.15, alpha:1.0)
        
        //removing emmpty cells from tickerTabel
        searchTable.tableFooterView = UIView()
        
        //setting background color of tickerTable
        searchTable.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.15, alpha:1.0)
        
       // mySearchBar.searchResultsUpdater = self as UISearchResultsUpdating
       // searchController.dimsBackgroundDuringPresentation = false
       // definesPresentationContext = true
        searchTable.tableHeaderView = mySearchBar
               for (_, v) in tickerDict {
            searchList.append(v)
        }
        //searchList.append("ETHEREUM (ETH)")
        
    }
  
    
    func filterContentforSearchText(searchText: String) {
        
        print("jiggly")
        print(searchText)
        
//        filteredSearch = searchList.filter({ (name) -> Bool in
//            return name.lowercased().contains(searchText)
//        })
        
        filteredSearch = searchList.filter{$0.lowercased().contains(searchText.lowercased())}
        
        print(filteredSearch)
        
        searchTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentforSearchText(searchText: searchController.searchBar.text!)
    }
    // called whenever text is changed.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentforSearchText(searchText: mySearchBar.text!)
    }
    // called when cancel button is clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        performSegue(withIdentifier: "backSearch", sender: Any?.self)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        mySearchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        mySearchBar.showsCancelButton = false

    }
    
    
    
    func tableView(_ searchTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Runs loop until the data is loaded from the api
       // mySearchBar.isActive &&
        if searchActive && mySearchBar.text != "" {
            return filteredSearch.count
        }
        return searchList.count
        
    }
    
    func tableView(_ searchTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Dequeueing array of default tickers to populate cells in table
        let cell = searchTable.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCellController
        
        //setting background color of cell
        cell.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.15, alpha:1.0)
        // mySearchBar.isActive &&
        if searchActive && mySearchBar.text != "" {
            let display = filteredSearch[indexPath.row]
            var splitArr = display.components(separatedBy: " (")
            cell.fullName.text = splitArr[0]
            cell.addTicker.tag = indexPath.row
            cell.ticker.text = "(" + splitArr[1]
        } else {
            let display = searchList[indexPath.row]
            var splitArr = display.components(separatedBy: " (")
            cell.fullName.text = splitArr[0]
            cell.addTicker.tag = indexPath.row
            cell.ticker.text = "(" + splitArr[1]
            cell.addTicker.addTarget(self, action: #selector(self.addAction(_:)), for: UIControlEvents.touchUpInside)
        }
        
        //returning populated cell to tickerTable
        return cell
        
    }
    
    func addAction(_ sender: UIButton) {
        print("monkeyMan")
        
        let check  = UIImage(named: "check")
        sender.setImage(check, for: [])
        
        var preParse: String
        // searchController.isActive &&
        if searchActive && mySearchBar.text != "" {
            preParse = filteredSearch[sender.tag]
        } else {
            preParse = searchList[sender.tag]
        }

        var preParseSplit: [String] = preParse.components(separatedBy: "(")
        let postParseSplit: [String] = preParseSplit[1].components(separatedBy: ")")
        let finalTick: String = postParseSplit[0]
        
        if (!model.getCurrentUser().getWatchList().contains(finalTick)) {
            model.getCurrentUser().addTicker(ticker: finalTick)
            
            model.addTickerToDataBase()
        }
        print("HERE IS IT")
        print(model.getCurrentUser().getWatchList())
    }

}
