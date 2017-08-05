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
   
    @IBOutlet weak var loginButton: UIButton!

    @IBOutlet weak var registerButton: UIButton!


  
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
   
        loginButton.layer.cornerRadius = 5
        registerButton.layer.cornerRadius = 5
        
        usernameTextField.tintColor = UIColor(red:0.38, green:0.90, blue:1.00, alpha:1.0)
        passwordTextField.tintColor = UIColor(red:0.38, green:0.90, blue:1.00, alpha:1.0)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LandingViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)

        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
        
        registerButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        //Animate
        UIView.animate(
            withDuration: 1.5,
            delay: 0.0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 4,
            options: UIViewAnimationOptions.curveLinear,
            animations: {
                
                [weak self] in self?.registerButton.transform = .identity
                
                //            self.loginButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
                //            self.loginButton.isEnabled = false
                
            }, completion: { finished in self.registerButton.isEnabled = true })
        
    }
    func removeWatchListItem(ticker: String) -> Void {
        var arr: [String] = []
        for tic in model.getCurrentUser().getWatchList() {
            
            if tic != ticker {
                
                arr.append(tic)
                
            }
            
        }

        watch.setValue(arr)
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
                    //model.getCurrentUser().setWatchList(watchList: ["BTC","ETH","LTC"])
                    //watch.setValue(["BTC","ETH","LTC"])

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
