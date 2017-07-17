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
    
    var filteredSearch: [String] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting background color of entire canvas
        self.view.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
        //removing emmpty cells from tickerTabel
        searchTable.tableFooterView = UIView()
        
        //setting background color of tickerTable
        searchTable.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchTable.tableHeaderView = searchController.searchBar
        let height = searchController.searchBar.frame.height
       //searchController.searchBar.frame.offsetBy(dx: 30, dy: 0)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 21 , height: height))
        button.backgroundColor = .black
        button.setImage( UIImage.init(named: "BackButton"), for: .normal)
        button.backgroundColor = UIColor.clear  
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        searchController.searchBar.subviews[0].addSubview(button)
        for (_, v) in tickerDict {
            searchList.append(v)
        }
        
    }
    func back(sender: UIButton!) {
        performSegue(withIdentifier: "backSearch", sender: Any?.self)
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

extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentforSearchText(searchText: searchController.searchBar.text!)
    }
    
    
    
    func tableView(_ searchTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Runs loop until the data is loaded from the api
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredSearch.count
        }
        return searchList.count
        
    }
    
    func tableView(_ searchTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Dequeueing array of default tickers to populate cells in table
        let cell = searchTable.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCellController
        
        //setting background color of cell
        cell.backgroundColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        
        if searchController.isActive && searchController.searchBar.text != "" {
            let display = filteredSearch[indexPath.row]
            var splitArr = display.components(separatedBy: " (")
            cell.fullName.text = splitArr[0]
            cell.addTicker.tag = indexPath.row
            cell.addTicker.setImage( UIImage.init(named: "Add"), for: .normal)
            cell.addTicker.backgroundColor = UIColor.clear
            cell.ticker.text = "(" + splitArr[1]
        } else {
            let display = searchList[indexPath.row]
            var splitArr = display.components(separatedBy: " (")
            cell.fullName.text = splitArr[0]
            cell.addTicker.tag = indexPath.row
            cell.addTicker.setImage( UIImage.init(named: "Add"), for: .normal)
            cell.addTicker.backgroundColor = UIColor.clear
            cell.ticker.text = "(" + splitArr[1]
            cell.addTicker.addTarget(self, action: #selector(self.addAction(_:)), for: UIControlEvents.touchUpInside)
        }
        
        //returning populated cell to tickerTable
        return cell
        
    }
    
    func addAction(_ sender: UIButton) {
        print("monkeyMan")
        var preParse: String
        if searchController.isActive && searchController.searchBar.text != "" {
            preParse = filteredSearch[sender.tag]
        } else {
            preParse = searchList[sender.tag]
        }

        var preParseSplit: [String] = preParse.components(separatedBy: "(")
        let postParseSplit: [String] = preParseSplit[1].components(separatedBy: ")")
        let finalTick: String = postParseSplit[0]
        
        if (!model.getCurrentUser().getWatchList().contains(finalTick)) {
            model.getCurrentUser().addTicker(ticker: finalTick)
        }
        print(model.getCurrentUser().getWatchList())
    }

}
