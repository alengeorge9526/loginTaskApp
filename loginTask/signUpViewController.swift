//
//  signUpViewController.swift
//  loginTask
//
//  Created by Alen George on 23/08/23.
//

//import UIKit
//import Firebase
//
//class signUpViewController: UIViewController {
//
////   // @IBOutlet weak var name: UITextField!
////    @IBOutlet weak var emailText: UITextField!
////    @IBOutlet weak var passwordText: UITextField!
////
//
//
//    @IBOutlet weak var emailText: UITextField!
//
//    @IBOutlet weak var passWordText: UITextField!
//
//
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//    }
//
//    @IBAction func didPresssignlogin(_ sender: UIButton) {
//
//        guard let email = emailText.text else { return }
//        guard let password = passWordText.text else { return }
//        Auth.auth().createUser(withEmail: email, password: password ){ AuthResult , error in
//            if let  e = error{
//                print("error")
//
//            }
//            else {
//                self.performSegue(withIdentifier: "goToHome", sender: self)
//            }
//        }
//
//    }
//
//
//}
