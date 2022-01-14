//
//  CustomerRecord.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//

import Foundation

class CustomerRecord {
    
    var dateTimeEndService: String!
    var dateTimeStartService: String!
    var idClient: String!
    var idRecord: String!
    var idService: String!
    var linkPhotoClient: String!
    var nameClient: String!
    var periodNextRecord: String!
    var price: String!
    var service: String!
    var surnameClient: String!
    var сheckNumber: String!
    var commentText: String!
    var dateFormatterM: String!
    var dateFormatterYar: String!
    var dateTimeSecondForFilter: String!
    var idAllServiceArray: [String]!
    var gender: String!
    
    init(dictionary: [String: Any]) {

        self.dateTimeEndService = dictionary["dateTimeEndService"] as? String ?? ""
        self.dateTimeStartService = dictionary["dateTimeStartService"] as? String ?? ""
        self.idClient = dictionary["idClient"] as? String ?? ""
        self.idRecord = dictionary["idRecord"] as? String ?? ""
        self.idService = dictionary["idService"] as? String ?? ""
        self.linkPhotoClient = dictionary["linkPhotoClient"] as? String ?? ""
        self.nameClient = dictionary["nameClient"] as? String ?? ""
        self.periodNextRecord = dictionary["periodNextRecord"] as? String ?? ""
        self.price = dictionary["price"] as? String ?? ""
        self.service = dictionary["service"] as? String ?? ""
        self.surnameClient = dictionary["surnameClient"] as? String ?? ""
        self.сheckNumber = dictionary["сheckNumber"] as? String ?? ""
        self.commentText = dictionary["commentText"] as? String ?? ""
        self.dateFormatterM = dictionary["dateFormatterM"] as? String ?? ""
        self.dateFormatterYar = dictionary["dateFormatterYar"] as? String ?? ""
        self.dateTimeSecondForFilter = dictionary["dateTimeSecondForFilter"] as? String ?? ""
        self.idAllServiceArray = dictionary["idAllServiceArray"] as? [String] ?? [""]
        self.gender = dictionary["gender"] as? String ?? ""
       
    }
 
}



