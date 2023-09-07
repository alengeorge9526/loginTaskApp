//
//  UpdateDashboardViewcontroller.swift
//  loginTask
//
//  Created by Alen George on 25/08/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class UpdateDashboardViewcontroller: UIViewController {
    
    let databaseReference = Database.database().reference()
    @IBOutlet weak var nameTextfeild: UITextField!
    @IBOutlet weak var dobTextfeild: UITextField!
    @IBOutlet weak var locationTextfeild: UITextField!
    @IBOutlet weak var genderTextfeild: UITextField!
    @IBOutlet weak var phoneNumbertextFeild: UITextField!
    @IBOutlet weak var phoneNumbererrorlabel: UILabel!
    
    var datePicker =  UIDatePicker()
    let genderOptions = ["Male", "Female", "Non-Binary", "Other"]
    let genderPicker = UIPickerView()
    let ref = Database.database().reference()
    let currentUser = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfileData()
        setupPickers()
    }
    
    @IBAction func didPressUpdate(_ sender: UIButton) {
        if let phoneNumber = phoneNumbertextFeild.text {
            if !validatePhoneNumber(phoneNumber) {
                phoneNumbererrorlabel.text = "invalid"
            }
            else{
                let dict = ["Name":nameTextfeild.text, "dob":dobTextfeild.text,"location":locationTextfeild.text,"gender":genderTextfeild.text,"phoneNumber":phoneNumbertextFeild.text]
                if let user = Auth.auth().currentUser{
                    let userReference = databaseReference.child("users").child(user.uid)
                    userReference.setValue(dict)
                    showSuccesalert()
                }
            }
        }
    }
    
    func setupPickers(){
        dobTextfeild.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        genderTextfeild.inputView = genderPicker
        genderPicker.dataSource = self
        genderPicker.delegate = self
    }
    
    func fetchProfileData() {
        if let userId = currentUser?.uid {
            ref.child("users").child(userId).observeSingleEvent(of: .value) { (snapshot , _ )  in
                if let userData = snapshot.value as? [String: String] {
                    let data = UserProfileDataModel(data: userData)
                    self.nameTextfeild.text = data.name
                    self.dobTextfeild.text = data.dateOfBirth
                    self.locationTextfeild.text = data.location
                    self.genderTextfeild.text = data.gender
                    self.phoneNumbertextFeild.text = data.phone
                }
            }
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dobTextfeild.text = dateFormatter.string(from: sender.date)
    }
    
    func validatePhoneNumber(_ phoneNumber: String) -> Bool {
        let pattern = "^00\\d+"
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let matches = regex.matches(in: phoneNumber, range: NSRange(phoneNumber.startIndex..., in: phoneNumber))
            return !matches.isEmpty
        } catch {
            return false
        }
    }
    
    func showSuccesalert() {
        let successAlert = UIAlertController(title: "Updated Successfully", message: "You have successfully updated the profile.", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "dashBoard", sender: nil )
        }))
        self.present(successAlert, animated: true, completion: nil)
    }
}
extension UpdateDashboardViewcontroller: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
        genderTextfeild.text = genderOptions[row]
        genderTextfeild.resignFirstResponder()
    }
}

