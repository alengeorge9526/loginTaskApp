//
//  testViewController.swift
//  loginTask
//
//  Created by Alen George on 28/08/23.
//
    import UIKit
    import Firebase
    class testViewController: UIViewController {
        
        
       // @IBOutlet weak var nameField: UITextField!
        
        
        
        
        
    
            @IBOutlet weak var nameField: UITextField!
            @IBOutlet weak var dobField: UITextField!
            @IBOutlet weak var locationField: UITextField!
            @IBOutlet weak var genderField: UITextField!
            @IBOutlet weak var phnoField: UITextField!
            
            @IBOutlet weak var editButton: UIButton!
            
            var isEditingProfile = false
         
               let ref = Database.database().reference()
               let currentUser = Auth.auth().currentUser
            
            override func viewDidLoad() {
                super.viewDidLoad()
                fetchProfileData()
                      updateUI()
         
                // Do any additional setup after loading the view.
            }
            
            func fetchProfileData() {
                    if let uid = currentUser?.uid {
                        ref.child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
                            if let userData = snapshot.value as? [String: Any] {
                                self.nameField.text = userData["name"] as? String
                                self.dobField.text = userData["dob"] as? String
                                self.locationField.text = userData["name"] as? String
                                self.genderField.text = userData["gender"] as? String
                                self.phnoField.text = userData["phone"] as? String
                            }
                        }
                    }
                }
           
            func updateUI() {
                   if isEditingProfile {
                       nameField.isEnabled = true
                       dobField.isEnabled = true
                       locationField.isEnabled = true
                       genderField.isEnabled = true
                       phnoField.isEnabled = true
                       editButton.setTitle("Save", for: .normal)
                   } else {
                       nameField.isEnabled = false
                       dobField.isEnabled = false
                       locationField.isEnabled = false
                       genderField.isEnabled = false
                       phnoField.isEnabled = false
                       editButton.setTitle("Edit", for: .normal)
                   }
               }
         
            
            @IBAction func editButtonPress(_ sender: UIButton) {
                
                isEditingProfile.toggle()
                        updateUI()
         
                        if !isEditingProfile {
                            updateProfileData()
                        }
            }
            
            func updateProfileData() {
                    if let uid = currentUser?.uid {
                        let userData = [
                            "name": nameField.text,
                            "dob": dobField.text,
                            "location": locationField.text,
                            "gender": genderField.text,
                            "phone": phnoField.text
                           
                            
                        ]
                        ref.child("users").child(uid).setValue(userData) { error, _ in
                            if let error = error {
                                print("Error updating profile: \(error.localizedDescription)")
                            } else {
                                print("Profile updated successfully")
                                let successAlert = UIAlertController(title: "Profile Updated", message: "Profile Updated Successfully", preferredStyle: .alert)
                                successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(successAlert, animated: true, completion: nil)
                            }
                        }
                    }
                }
         
         
        }

