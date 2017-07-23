//
//  LandingViewController.swift
//  CryptoProfit
//
//  Created by Zachary Cheshire on 7/14/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
var ref: FIRDatabaseReference!
var users: FIRDatabaseReference!
var watch: FIRDatabaseReference!
var positions: FIRDatabaseReference!

class LandingViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
   



  
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
   
   

        
    }
    
    @IBAction func registerAction(_ sender: Any) {
        if usernameTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)

        } else {
            FIRAuth.auth()?.createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                                        model.setCurrentUser(user: User(username: self.usernameTextField.text!, password: self.passwordTextField.text!, positions: [], tickers: ["BTC","ETH","LTC"]))
                    let userID = FIRAuth.auth()?.currentUser?.uid
                    users = ref.child(userID!)
                    watch = users.child("watchList")
                    watch.setValue(["BTC","ETH","LTC"])
                    
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    //self.setUserWatchList()
                    model.getTickers()

                    self.performSegue(withIdentifier: "Home", sender: (Any).self)

                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    func setUserWatchList() {
               // 1
        watch = users.child("watchList")
       // watch.setValue(["ETH","BTC","ANS","SC","GAY","DASH"])
        watch.observe(.value, with: { snapshot in
            // 2
            
            // 3
            print("hey")
            print(snapshot.value!)
            do  {
                
                if (snapshot.value as? [String]) != nil {
                    print("SETTING DYNAMIC")
                    model.getCurrentUser().setWatchList(watchList: snapshot.value as! [String])

                } else {
                    print("HARD SET")
                    model.getCurrentUser().setWatchList(watchList: ["BTC","ETH","LTC"])
                    watch.setValue(["BTC","ETH","LTC"])

                }
                
            } catch{
               
                print("Sorry")
                
            }
                
            print(model.getCurrentUser().getWatchList())

                
            
                
                
                
            
            self.setUserPositions()

            


        })
    }
    func setUserPositions() {
        // 1
        // watch = users.child("watchList")
        positions = users.child("positions")
        // 1
        positions.observe(.value, with: { snapshot in
            // 2
            var newItems: [Position] = []
            
            // 3
            for item in snapshot.children {
        
                // 4
                let pos = Position(snapshot: item as! FIRDataSnapshot)
                newItems.append(pos)
            }
            
            // 5
            model.getCurrentUser().setPositions(positions: newItems)
            model.getTickers()
            model.refresh(tickers: model.getCurrentUser().getWatchList(), base: "USD")
            self.performSegue(withIdentifier: "Home", sender: (Any).self)

        })
        
        
        
    }
    @IBAction func loginAction(_ sender: Any) {
        
        if self.usernameTextField.text == "" || self.passwordTextField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.usernameTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    // 2
                    model.setCurrentUser(user: User(username: self.usernameTextField.text!, password: self.passwordTextField.text!, positions: [], tickers: []))
                    let userID = FIRAuth.auth()?.currentUser?.uid
                    users = ref.child(userID!)
                 
                    self.setUserWatchList()

                    
                   
                    

                    //Go to the HomeViewController if the login is sucessful
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
