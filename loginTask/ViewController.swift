//
//  ViewController.swift
//  loginTask
//
//  Created by Alen George on 22/08/23.
//

import UIKit
import Foundation
import RegexBuilder
import Firebase
import SVProgressHUD
class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userWarning: UILabel!
    @IBOutlet weak var passWarning: UILabel!
    @IBOutlet weak var head: UILabel!
    
    var errorMessage = ""
    var pMesssage = ""
    let minUsrname = 8
    let maxUserName = 15
    let paslen = 8
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressLogin(_ sender: UIButton) {
        SVProgressHUD.show()
        if let user = username.text{
            if user.isEmpty {
                errorMessage = "* Invalid Username: Username cannot be empty."
                userWarning.text = errorMessage
                userWarning.backgroundColor = .white
                userWarning.textColor = .red
            }
            
            else if user.count < minUsrname || user.count > maxUserName {
                errorMessage = "* Invalid Username: Username must be between \(minUsrname) and \(maxUserName) characters."
                userWarning.text = errorMessage
                userWarning.backgroundColor = .white
                userWarning.textColor = .red
            }//else if !isValidUsername(user) {
                //errorMessage = "* Invalid Username: Username must only contain letters and numbers. Avoid special characters."
                //userWarning.text = errorMessage
               // userWarning.backgroundColor = .white
               // userWarning.textColor = .red
            //}
            
        }
        
        if let passw = password.text, !passw.isEmpty {
            if passw.count < paslen {
                pMesssage = "* Invalid Password: Password must contain atleast  \(paslen) characters."
                passWarning.text = pMesssage
                passWarning.backgroundColor = .white
                passWarning.textColor = .red
            } else if !isValidPassword(passw) {
                pMesssage = "* Invalid Password: Password must contain at least one uppercase letter, lowercase letter, special character, and number."
                passWarning.text = pMesssage
                passWarning.backgroundColor = .white
                passWarning.textColor = .red
            }
        } else {
            pMesssage = "* Invalid Password: Password cannot be empty."
            passWarning.text = pMesssage
            passWarning.backgroundColor = .white
            passWarning.textColor = .red
            
        }
        
        // Perform your login logic here
        
        ///if errorMessage.isEmpty && pMesssage.isEmpty {
            // No errors, hide the label
            //statusLabel.isHidden = true
            // Perform your login logic here
            // Assuming login logic is successful
            //let successAlert = UIAlertController(title: "Login Success", message: "You have successfully logged in.", preferredStyle: .alert)
          //  successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           // present(successAlert, animated: true, completion: nil)
       // }
        func isValidUsername(_ username: String) -> Bool {
            let usernameRegex = "^[a-zA-Z0-9]*$"
            let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
            return usernameTest.evaluate(with: username)
        }
        
        func isValidPassword(_ password: String) -> Bool {
            let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
            return passwordTest.evaluate(with: password)
        }
        guard let email = username.text else { return }
         guard  let passwords = password.text else { return }
        Auth.auth().signIn(withEmail: email, password: passwords) { AuthResult, error in
            if let e = error {
               // print("Login failed: \(error.localizedDescription)")
                let successAler = UIAlertController(title: "Login Failed", message: "You have failed in  logging in.", preferredStyle: .alert)
                successAler.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(successAler, animated: true, completion: nil)
            } else {
                //print("Login successful")
                // Perform segue to main app screen
                self.performSegue(withIdentifier: "goEdit", sender: self)
            }
            SVProgressHUD.dismiss()
        }
        
        
        
    }
    
}


   
            
    
    
    
    
    
    
        
                    
        
    

