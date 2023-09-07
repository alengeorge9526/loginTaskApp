//
//  UserprofileDataModel.swift
//  loginTask
//
//  Created by Alen George on 06/09/23.
//

import Foundation
struct UserProfileDataModel {
    enum Keys: String {
        case name       = "Name"
        case dateOfBirth = "dob"
        case loacation   = "location"
        case gender     = "gender"
        case phone      = "phoneNumber"
 
    }
    var name: String?
    var dateOfBirth: String?
    var location: String?
    var gender: String?
    var phone: String?
    
    init(data: [String: String]){
        name = data[Keys.name.rawValue]
        dateOfBirth = data[Keys.dateOfBirth.rawValue]
        location = data[Keys.loacation.rawValue]
        gender = data[Keys.gender.rawValue]
        phone = data[Keys.phone.rawValue]
    }
}
