//
//  Final1ViewController.swift
//  loginTask
//
//  Created by Alen George on 28/08/23.
//

import UIKit
import Firebase
import FirebaseDatabase
import SideMenu

class Final1ViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var nameField: UILabel!
    
    @IBOutlet weak var dobField: UILabel!
    @IBOutlet weak var locationField: UILabel!
    
    @IBOutlet weak var Gender: UILabel!
    
    @IBOutlet weak var phoneNumber: UILabel!
    //sidemenu
    
    var menu: SideMenuNavigationController?
    
    
    
    
    //
    let ref = Database.database().reference()
           let currentUser = Auth.auth().currentUser
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfileData()
        btnEdit.layer.cornerRadius = 14
        btnLogin.layer.cornerRadius = 14
        //sideMenu
        menu = SideMenuNavigationController( rootViewController : menuController())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    }

    
    @IBAction func didTouchMenu(_ sender: UIBarButtonItem) {
        present(menu!,animated: true)
    }
    
    
    
    func fetchProfileData() {
                  if let uid = currentUser?.uid {
                      ref.child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
                          if let userData = snapshot.value as? [String: Any] {
                              self.nameField.text = userData["Name"] as? String
                              self.dobField.text = userData["dob"] as? String
                             self.locationField.text = userData["location"] as? String
                              self.Gender.text = userData["gender"] as? String
                              self.phoneNumber.text = userData["phoneNumber"] as? String
                          }
                      }
                  }
              }
         
        
        
        
    }

class menuController: UITableViewController {
    var items = ["Home","Map","Sign Up","Log Out"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // Deselect the selected cell visually
               let selectedItem = items[indexPath.row]
               //print("Selected item: \(selectedItem)")
        if selectedItem == "Home" {
            let viewController1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home")
                       
                       // Push the view controller onto the navigation stack
                       navigationController?.pushViewController( viewController1 , animated: true)
                       
        }
        if selectedItem == "Map" {
            let viewController1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "map")
                       
                       // Push the view controller onto the navigation stack
                       navigationController?.pushViewController( viewController1 , animated: true)
                       
        }
        if selectedItem == "Log Out" {
            let viewController1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "log")
                       
                       // Push the view controller onto the navigation stack
                       navigationController?.pushViewController( viewController1 , animated: true)
                       

        }
        if selectedItem == "Sign Up" {
            let viewController1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sign")
                       
                       // Push the view controller onto the navigation stack
                       navigationController?.pushViewController( viewController1 , animated: true)
                       
        }
               
    }
    
}

