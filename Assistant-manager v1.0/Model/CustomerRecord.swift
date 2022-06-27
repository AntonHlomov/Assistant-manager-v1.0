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
    var dateTimeStartService: String!
    var dateTimeEndService: String!
   //var fullDateTimeStartServiceForFilter: String!
    var idClient: String!
    var genderClient: String!
    var ageClient:Int!
    var periodNextRecord: String!
    var commit: String!
   //var idAllServiceArray: [String]!
    var service: [Price]! 
    var anUnfulfilledRecord: Bool!
    
    init(dictionary: [String: Any]) {

        self.idRecord = dictionary["idRecord"] as? String ?? ""
        self.idUserWhoRecorded = dictionary["idUserWhoRecorded"] as? String ?? ""
        self.idUserWhoWorks = dictionary["idUserWhoWorks"] as? String ?? ""
        self.dateTimeStartService = dictionary["dateTimeStartService"] as? String ?? ""
        self.dateTimeEndService = dictionary["dateTimeEndService"] as? String ?? ""
      //  self.fullDateTimeStartServiceForFilter = dictionary["fullDateTimeStartServiceForFilter"] as? String ?? ""
        self.idClient = dictionary["idClient"] as? String ?? ""
        self.genderClient = dictionary["genderClient"] as? String ?? ""
        self.ageClient = dictionary["ageClient"] as? Int ?? nil
        self.periodNextRecord = dictionary["periodNextRecord"] as? String ?? ""
        self.commit = dictionary["commit"] as? String ?? ""
       // self.idAllServiceArray = dictionary["idAllServiceArray"] as? [String] ?? [""]
        self.service = dictionary["service"] as? [Price] ?? []
        self.anUnfulfilledRecord = dictionary["anUnfulfilledRecord"] as? Bool ?? nil
    }
}



