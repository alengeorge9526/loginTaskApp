//
//  DashboardViewController.swift
//  loginTask
//
//  Created by Alen George on 28/08/23.
//

import UIKit
import Firebase
import FirebaseDatabase
import SideMenu

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameFieldlabel: UILabel!
    @IBOutlet weak var dobFieldlabel: UILabel!
    @IBOutlet weak var locationFieldlabel: UILabel!
    @IBOutlet weak var genderFeildlabel: UILabel!
    @IBOutlet weak var phonenumberFeildlabel: UILabel!
    
    var menu: SideMenuNavigationController?
    let ref = Database.database().reference()
    let currentUser = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfileData()
        editButton.layer.cornerRadius = 14
        loginButton.layer.cornerRadius = 14
        setupSidemenu()
    }
    
    @IBAction func didTouchMenu(_ sender: UIBarButtonItem) {
        present(menu!,animated: true)
    }
    
    func setupSidemenu(){
        menu = SideMenuNavigationController( rootViewController : menuController())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }

    func fetchProfileData() {
          if let userId = currentUser?.uid {
              ref.child("users").child(userId).observeSingleEvent(of: .value) { (snapshot , _ )  in
                  if let userData = snapshot.value as? [String: String] {
                      let data = UserProfileDataModel(data: userData)
                      self.nameFieldlabel.text = data.name
                      self.dobFieldlabel.text = data.dateOfBirth
                      self.locationFieldlabel.text = data.location
                      self.genderFeildlabel.text = data.gender
                      self.phonenumberFeildlabel.text = data.phone
                  }
              }
          }
      }
      
}



