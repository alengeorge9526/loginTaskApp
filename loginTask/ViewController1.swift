//
//  ViewController1.swift
//  loginTask
//
//  Created by Alen George on 23/08/23.
//

import UIKit
import Firebase
import RegexBuilder
import SVProgressHUD
class ViewController1: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var emailMsg: UILabel!
    @IBOutlet weak var passMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Perform segue after OK button is tapped
            self.performSegue(withIdentifier: "goToSigninPage", sender: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    var errorMessage = ""
    var errorMessagePass = ""
    @IBAction func didPressLoginS(_ sender: Any)
    {
        SVProgressHUD.show()
        guard let email = emailText.text else { return }
        guard let passwords = passwordText.text else { return }
        
        if email.isEmpty{
            errorMessage = "* Invalid email: email cannot be empty."
            emailMsg.text = errorMessage
        }
        else if !isValidEmail(email){
            errorMessage = "* Invalid email format"
            emailMsg.text = errorMessage
            
       }
        if passwords.isEmpty{
            errorMessagePass = "* Invalid Password: Password cannot be empty."
            passMessage.text = errorMessagePass
        }
        else if !isValidPassword(passwords){
            errorMessagePass = "* Invalid Password: Password must contain at least one uppercase letter, lowercase letter, special character, and number."
            passMessage.text = errorMessagePass
        }
        
        
        
       
        
        Auth.auth().createUser(withEmail: email, password: passwords ){ AuthResult , error in
            if let  e = error{
                // print("error")
                let successAler = UIAlertController(title: "Sign up Failed", message: "You have failed in  signing up.", preferredStyle: .alert)
                successAler.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(successAler, animated: true, completion: nil)
                
            }
            else {
                
                self.showAlert(title: "Sign Up Successful", message: "Your Sign up was successful.")
                
                
            }
        }
        SVProgressHUD.dismiss()
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
