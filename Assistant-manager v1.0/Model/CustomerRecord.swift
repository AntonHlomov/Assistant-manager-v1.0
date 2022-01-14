//
//  CustomerRecord.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//

import Foundation

class CustomerRecord {
    
    var idRecord: String!
    var idUserAdministrator: String!
    var idMaster: String!
    var dateTimeStartService: String!
    var dateTimeEndService: String!
    var fullDateTimeStartServiceForFilter: String!
    var idClient: String!
    var genderClient: String!
    var ageClient:Int!
    var periodNextRecord: String!
    var commit: String!
    var idAllServiceArray: [String]!
    var anUnfulfilledRecord: Bool!
    
    init(dictionary: [String: Any]) {

        self.idRecord = dictionary["idRecord"] as? String ?? ""
        self.idUserAdministrator = dictionary["idUserAdministrator"] as? String ?? ""
        self.idMaster = dictionary["idMaster"] as? String ?? ""
        self.dateTimeStartService = dictionary["dateTimeStartService"] as? String ?? ""
        self.dateTimeEndService = dictionary["dateTimeEndService"] as? String ?? ""
        self.fullDateTimeStartServiceForFilter = dictionary["fullDateTimeStartServiceForFilter"] as? String ?? ""
        self.idClient = dictionary["idClient"] as? String ?? ""
        self.genderClient = dictionary["genderClient"] as? String ?? ""
        self.ageClient = dictionary["ageClient"] as? Int ?? nil
        self.periodNextRecord = dictionary["periodNextRecord"] as? String ?? ""
        self.commit = dictionary["commit"] as? String ?? ""
        self.idAllServiceArray = dictionary["idAllServiceArray"] as? [String] ?? [""]
        self.anUnfulfilledRecord = dictionary["anUnfulfilledRecord"] as? Bool ?? nil
    }
}



