//
//  CustomerRecord.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//
import Foundation

class CustomerRecord {
    var idRecord: String!
    var idUserWhoRecorded: String!
    var idUserWhoWorks: String!
    var nameWhoWorks: String!
    var fullNameWhoWorks: String!
    var profileImageWhoWorks: String!
    var dateTimeStartService: String!
    var dateTimeEndService: String!
    var dateStartService: String!
    var idClient: String!
    var nameClient: String!
    var fullNameClient: String!
    var profileImageClient: String!
    var telefonClient: String!
    var genderClient: String!
    var ageClient:Int!
    var commit: String!
    var service:  [[String : Any]]!
    var anUnfulfilledRecord: Bool!
    
    init(dictionary: [String: Any]) {
        self.idRecord = dictionary["idRecord"] as? String ?? ""
        self.idUserWhoRecorded = dictionary["idUserWhoRecorded"] as? String ?? ""
        self.idUserWhoWorks = dictionary["idUserWhoWorks"] as? String ?? ""
        self.nameWhoWorks = dictionary["nameWhoWorks"] as? String ?? ""
        self.fullNameWhoWorks = dictionary["fullNameWhoWorks"] as? String ?? ""
        self.profileImageWhoWorks = dictionary["profileImageWhoWorks"] as? String ?? ""
        self.dateTimeStartService = dictionary["dateTimeStartService"] as? String ?? ""
        self.dateTimeEndService = dictionary["dateTimeEndService"] as? String ?? ""
        self.dateStartService = dictionary["dateStartService"] as? String ?? ""
        self.idClient = dictionary["idClient"] as? String ?? ""
        self.nameClient = dictionary["nameClient"] as? String ?? ""
        self.fullNameClient = dictionary["fullNameClient"] as? String ?? ""
        self.profileImageClient = dictionary["profileImageClient"] as? String ?? ""
        self.telefonClient = dictionary["telefonClient"] as? String ?? ""
        self.genderClient = dictionary["genderClient"] as? String ?? ""
        self.ageClient = dictionary["ageClient"] as? Int ?? nil
        self.commit = dictionary["commit"] as? String ?? ""
        self.service = dictionary["service"] as?  [[String : Any]] ?? nil
        self.anUnfulfilledRecord = dictionary["anUnfulfilledRecord"] as? Bool ?? nil
    }
}
