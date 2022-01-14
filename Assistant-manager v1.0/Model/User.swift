//
//  User.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//
var userApp: User?

import Foundation

class User {
    
    var lastСheckNumber: String!
    var name: String!
    var profileImage: String!
    var uid: String!
    var username: String!
    var profit: String!
    var revenue: String!
    var expenses: String!
    var textreminder: String!
    var categoryUser: String!
    var teacherUser: String!
    var lincUser: String!
  
    init(dictionary: [String: Any]) {
        
        self.lastСheckNumber = dictionary["lastСheckNumber"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.profileImage = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profit = dictionary["profit"] as? String ?? ""
        self.revenue = dictionary["revenue"] as? String ?? ""
        self.expenses = dictionary["expenses"] as? String ?? ""
        self.textreminder = dictionary["textreminder"] as? String ?? ""
        self.categoryUser = dictionary["categoryUser"] as? String ?? ""
        self.teacherUser = dictionary["teacherUser"] as? String ?? ""
        self.lincUser = dictionary["lincUser"] as? String ?? ""
       
    }
}

