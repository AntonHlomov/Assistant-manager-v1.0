//
//  Group.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 31/07/2022.
//

import Foundation

class Group {
    var idGroup: String!
    var nameGroup: String!
    var profileImageGroup: String!
    
    var checkCount: Int? // all time information
    var teamCount: Int!
    var whoIsBossId: String!
    var expensesGroup: Double? // all time information
    var proceedsGroup: Double? // all time information
    var priceCount: Int?
   
    
    init(dictionary: [String: Any]){
        self.idGroup = dictionary["idGroup"] as? String ?? ""
        self.nameGroup = dictionary["nameGroup"] as? String ?? ""
        self.profileImageGroup = dictionary["profileImageGroup"] as? String ?? ""
        
        self.checkCount = dictionary["checkCount"] as? Int ?? nil
        self.teamCount = dictionary["teamCount"] as? Int ?? nil
        self.whoIsBossId = dictionary["whoIsBossId"] as? String ?? ""
        self.expensesGroup = dictionary["expensesGroup"] as? Double ?? nil
        self.proceedsGroup = dictionary["proceedsGroup"] as? Double ?? nil
        self.priceCount = dictionary["priceCount"] as? Int ?? nil
    }
}
