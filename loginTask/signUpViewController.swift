//
//  SignUpViewController.swift
//  loginTask
//
//  Created by Alen George on 23/08/23.
//

import UIKit
import Firebase
import RegexBuilder
import SVProgressHUD

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextfeild: UITextField!
    @IBOutlet weak var passwordTextfeild: UITextField!
    @IBOutlet weak var emailErrormessagelabel: UILabel!
    @IBOutlet weak var passwordErrormessagelabel: UILabel!
    
    
    var emailErrormessage:String?
    var passwordErrorMessage:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didPressLoginS(_ sender: UIButton) {
        
        
        SVProgressHUD.show()
        guard let email = emailTextfeild.text,let password = passwordTextfeild.text
        else
        {
            return
        }
        if email.isEmpty {
            emailErrormessage = "* Invalid email: email cannot be empty."
            emailErrormessagelabel.text = emailErrormessage
        }
        else if !email.isValidEmail() {
            emailErrormessage = "* Invalid email format"
            emailErrormessagelabel.text = emailErrormessage
        }
        if password.isEmpty {
            passwordErrorMessage = "* Invalid Password: Password cannot be empty."
            passwordErrormessagelabel.text = passwordErrorMessage
        }
        else if !password.isValidPassword() {
            passwordErrorMessage = "* Invalid Password: Password must contain at least one uppercase letter, lowercase letter, special character, and number."
            passwordErrormessagelabel.text = passwordErrorMessage
        }
        Auth.auth().createUser(withEmail: email, password: password ){ AuthResult , error in
            if let  error = error {
                self.showAlertmessage(title: "Sign up Failed", message: "You have failed in  signing up.")
            }
            else {
                self.showSuccessalert(title: "Sign Up Successful", message: "Your Sign up was successful.")
            }
        }
        SVProgressHUD.dismiss()
    }
    
    func showSuccessalert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.performSegue(withIdentifier: "goToSigninPage", sender: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertmessage(title:String, message:String){
        let successAlert = UIAlertController(title: title, message:message , preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(successAlert, animated: true, completion: nil)
    }
    
    
}
