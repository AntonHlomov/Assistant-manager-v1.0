//
//  User.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//
var userApp: User?

import Foundation

class User {

    var uid: String!
    var name: String!
    var fullName: String!
    var profileImage: String!
    var categoryUser: String!
    var teacherUser: Bool!
    var lincUser: String!
    var lastСheckNumber: Int!
    var statusBoss: Bool!
    var statusAdministrator: Bool!
    var statusMaster: Bool!

    init(dictionary: [String: Any]) {
        
        self.lastСheckNumber = dictionary["lastСheckNumber"] as? Int ?? nil
        self.name = dictionary["name"] as? String ?? ""
        self.profileImage = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.categoryUser = dictionary["categoryUser"] as? String ?? ""
        self.teacherUser = dictionary["teacherUser"] as? Bool ?? nil
        self.lincUser = dictionary["lincUser"] as? String ?? ""
        self.statusBoss = dictionary["statusBoss"] as? Bool ?? nil
        self.statusAdministrator = dictionary["statusAdministrator"] as? Bool ?? nil
        self.statusMaster = dictionary["statusMaster"] as? Bool ?? nil
       
    }
}

