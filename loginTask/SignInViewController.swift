//
//  SignInViewController.swift
//  loginTask
//
//  Created by Alen George on 22/08/23.
//

import UIKit
import RegexBuilder
import Firebase
import SVProgressHUD

class SignInViewController: UIViewController {
    
    @IBOutlet weak var usernameTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var userWarningLabel: UILabel!
    @IBOutlet weak var passWarningLabel: UILabel!
    
    var errorMessageLabel:String?
    var passwordMesssageLabel:String?
    let minimumUsernameLength = 8
    let maximumUsernameLength = 15
    let passwordLength = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didPressLogin(_ sender: UIButton) {
        SVProgressHUD.show()
        usernameValidation()
        passwordValidation()
        
        if let errorMessageLabel = errorMessageLabel, errorMessageLabel.isEmpty,
           let passwordMessageLabel = passwordMesssageLabel, passwordMessageLabel.isEmpty {
            
            guard let email = usernameTextFeild.text,let passwords = passwordTextFeild.text
            else
            {
                return
                
            }
            Auth.auth().signIn(withEmail: email, password: passwords) { AuthResult, error in
                if let error = error {
                    self.alertMessage(title: "Login Failed", message: "You have failed in  logging in.")
                    
                } else {
                    
                    self.performSegue(withIdentifier: "goEdit", sender: self)
                }
                SVProgressHUD.dismiss()
            }
        }
    }
    
    private func usernameValidation(){
        if let user = usernameTextFeild.text{
            if user.isEmpty {
                errorMessageLabel = "* Invalid Username: Username cannot be empty."
                upadateUserwarninglabel()
            }
            
            else if user.count < minimumUsernameLength || user.count > maximumUsernameLength {
                errorMessageLabel = "* Invalid Username: Username must be between \(minimumUsernameLength) and \(maximumUsernameLength) characters."
                upadateUserwarninglabel()
            }
        }
    }
    
    private func passwordValidation(){
        if let passWord = passwordTextFeild.text, !passWord.isEmpty {
            if passWord.count < passwordLength {
                passwordMesssageLabel = "* Invalid Password: Password must contain atleast  \(passwordLength) characters."
                upadatePasswordwarninglabel()
            } else if !passWord.isValidPassword() {
                passwordMesssageLabel = "* Invalid Password: Password must contain at least one uppercase letter, lowercase letter, special character, and number."
                upadatePasswordwarninglabel()
            }
        } else {
            passwordMesssageLabel = "* Invalid Password: Password cannot be empty."
            upadatePasswordwarninglabel()
        }
    }
    
    func alertMessage(title:String, message:String){
        let successAlert = UIAlertController(title: title, message:message , preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(successAlert, animated: true, completion: nil)
    }
    
    func upadatePasswordwarninglabel(){
        passWarningLabel.text = passwordMesssageLabel
        passWarningLabel.backgroundColor = .white
        passWarningLabel.textColor = .red
    }
    
    func upadateUserwarninglabel(){
        userWarningLabel.text = errorMessageLabel
        userWarningLabel.backgroundColor = .white
        userWarningLabel.textColor = .red
    }
}















