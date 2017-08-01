//
//  SearchBarTest.swift
//  CryptoProfit
//
//  Created by Zachary Cheshire on 8/1/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import UIKit

class SearchBarTest: UIViewController, UISearchBarDelegate {
    
    private var mySearchBar: UISearchBar!
    private var myLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make UISearchBar instance
        mySearchBar = UISearchBar()
        mySearchBar.delegate = self
        mySearchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80)
        mySearchBar.layer.position = CGPoint(x: self.view.bounds.width/2, y: 100)
        
        // add shadow
        mySearchBar.layer.shadowColor = UIColor.black.cgColor
        mySearchBar.layer.shadowOpacity = 0.5
        mySearchBar.layer.masksToBounds = false
        
        // hide cancel button
        mySearchBar.showsCancelButton = true
        
        // hide bookmark button
        mySearchBar.showsBookmarkButton = false
        
        // set Default bar status.
        mySearchBar.searchBarStyle = UISearchBarStyle.default
        
        // set title
        mySearchBar.prompt = "Title"
        
        // set placeholder
        mySearchBar.placeholder = "Input text"
        
        // change the color of cursol and cancel button.
        mySearchBar.tintColor = UIColor.red
        
        // hide the search result.
        mySearchBar.showsSearchResultsButton = false
        
        // add searchBar to the view.
        self.view.addSubview(mySearchBar)
        
        // make UITextField
        myLabel = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        myLabel.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        myLabel.text = ""
        myLabel.layer.borderWidth = 1.0
        myLabel.layer.borderColor = UIColor.gray.cgColor
        myLabel.layer.cornerRadius = 10.0
        
        // add the label to the view.
        self.view.addSubview(myLabel)
        self.navigationController?.navigationBar.addSubview(myLabel)
    }
    
    // called whenever text is changed.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        myLabel.text = searchText
    }
    
    // called when cancel button is clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        myLabel.text = ""
        print("Canceled")
        mySearchBar.text = ""
    }
    
    // called when search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        myLabel.text = "Searching"
        print("Searching")
        mySearchBar.text = ""
        self.view.endEditing(true)
    }
}
