//
//  Reminder.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//

import Foundation

class Reminder {

    var idReminder: String!
    var idUser: String!
    var idClient: String!
    var commit: String!
    var dateShowReminder: String!
    var userReminder: Bool!
    var sistemReminderColl: Bool!
    var sistemReminderPeriodNextRecord: Bool!
    
    init(dictionary: [String: Any]) {

        self.idReminder = dictionary["idReminder"] as? String ?? ""
        self.idUser = dictionary["idUser"] as? String ?? ""
        self.idClient = dictionary["idClient"] as? String ?? ""
        self.commit = dictionary["commit"] as? String ?? ""
        self.dateShowReminder = dictionary["dateShowReminder"] as? String ?? ""
        self.userReminder = dictionary["userReminder"] as? Bool ?? nil
        self.sistemReminderColl = dictionary["sistemReminderColl"] as? Bool ?? nil
        self.sistemReminderPeriodNextRecord = dictionary["sistemReminderPeriodNextRecord"] as? Bool ?? nil
    }
}

