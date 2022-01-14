//
//  Client.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//

import Foundation

class Client {
    
    var dateAddClient: String!
    var fullName: String!
    var idClient: String!
    var nameClient: String!
    var profileImageClientUrl: String!
    var telefonClient: String!
    var textClient: String!
    var dataReminder: String!
    var textClientReminder: String!
    var reminderPeriod: String!
    var dataVisit: String!
    var textWhichServiceClientReminderPeriod: String!
    var gender:String!
    var countVisits:Int!
    var sumTotal:Double!
    
    init(dictionary: [String: Any]) {

        self.dataReminder = dictionary["dataReminder"] as? String ?? ""
        self.dateAddClient = dictionary["dateAddClient"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.idClient = dictionary["idClient"] as? String ?? ""
        self.nameClient = dictionary["nameClient"] as? String ?? ""
        self.profileImageClientUrl = dictionary["profileImageClientUrl"] as? String ?? ""
        self.telefonClient = dictionary["telefonClient"] as? String ?? ""
        self.textClient = dictionary["textClient"] as? String ?? ""
        self.textClientReminder = dictionary["textClientReminder"] as? String ?? ""
        self.reminderPeriod = dictionary["reminderPeriod"] as? String ?? ""
        self.dataVisit = dictionary["dataVisit"] as? String ?? ""
        self.textWhichServiceClientReminderPeriod = dictionary["textWhichServiceClientReminderPeriod"] as? String ?? ""
        self.gender = dictionary["gender"] as? String ?? ""
        self.countVisits = dictionary["countVisits"] as? Int ?? 0
        self.sumTotal = dictionary["sumTotal"] as? Double ?? 0.0

    }
  
}



