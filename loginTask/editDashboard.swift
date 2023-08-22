//
//  editDashboard.swift
//  loginTask
//
//  Created by Alen George on 25/08/23.
//

import UIKit
import Firebase
import FirebaseDatabase
class editDashboard: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderOptions.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text = genderOptions[row]
        gender.resignFirstResponder()
    }
    
    let databaseReference = Database.database().reference()
    @IBOutlet weak var nameFeild: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var label1: UILabel!
    
    
    var datePicker =  UIDatePicker()
    let genderOptions = ["Male", "Female", "Non-Binary", "Other"]
    let
    genderPicker = UIPickerView()
    //genderPicker.delegate = self
    //genderPicker.dataSource = self
    let ref = Database.database().reference()
    let currentUser = Auth.auth().currentUser
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfileData()
        dob.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        gender.inputView = genderPicker
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressUpdate(_ sender: UIButton) {
        if let ph = phoneNumber.text {
            if !validatePhoneNumber(ph){
                label1.text = "invalid"
            }
            else{
                var dict = ["Name":nameFeild.text, "dob":dob.text,"location":location.text,"gender":gender.text,"phoneNumber":phoneNumber.text]
                if let user = Auth.auth().currentUser{
                    let userReference = databaseReference.child("users").child(user.uid)
                    userReference.setValue(dict)
                    let successAler = UIAlertController(title: "Updated Successfully", message: "You have successfully updated the profile.", preferredStyle: .alert)
                    successAler.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                        self.performSegue(withIdentifier: "lastone", sender: nil )
                    }))
                    self.present(successAler, animated: true, completion: nil)
                }
                
                
            }
        }
    }
        func fetchProfileData() {
            if let uid = currentUser?.uid {
                ref.child("users").child(uid).observeSingleEvent(of: .value) { snapshot  in
                    if let userData = snapshot.value as? [String: Any] {
                        self.nameFeild.text = userData["Name"] as? String
                        self.dob.text = userData["dob"] as? String
                        self.location.text = userData["location"] as? String
                        self.gender.text = userData["gender"] as? String
                        self.phoneNumber.text = userData["phoneNumber"] as? String
                    }
                }
            }
            
        }
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dob.text = dateFormatter.string(from: sender.date)
        }
        func validatePhoneNumber(_ phoneNumber: String) -> Bool {
            let pattern = "^00\\d+" // This pattern matches strings that start with "00" followed by one or more digits
            do {
                let regex = try NSRegularExpression(pattern: pattern)
                let matches = regex.matches(in: phoneNumber, range: NSRange(phoneNumber.startIndex..., in: phoneNumber))
                return !matches.isEmpty
            } catch {
                return false // Invalid pattern
            }
        }
        
    
    }
    
//    extension editDashboard: UIPickerViewDataSource, UIPickerViewDelegate {
//       // func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        //    return 1 // For a single column
//       // }
//    
//       // func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//       //     return genderOptions.count
//      //  }
//    
//        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//            return genderOptions[row]
//        }
//    
//        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//            gender.text = genderOptions[row]
//            gender.resignFirstResponder()
//        }
//    }
//    
