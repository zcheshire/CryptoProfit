//
//  PositionViewController.swift
//  CryptoProfit
//
//  Created by Ash Bhimasani on 7/17/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation
import UIKit

class PositionViewController: UIViewController {
    
    let positionTitle: String = "Open Position"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.size.width, height: 44))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: positionTitle);
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        navItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(self.backAction(_:)))
        navBar.setItems([navItem], animated: false);
        navBar.barTintColor = UIColor(red:0.02, green:0.11, blue:0.13, alpha:1.0)
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false

    }
    
    func backAction(_ sender: UIButton) {
        performSegue(withIdentifier: "backPositionSegue", sender: Any?.self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
