//
//  Price.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//

import Foundation

class Price {
    
    var idPrice: String!
    var nameServise: String!
    var priceServies: Double!
    var timeAtWorkHour: Double!
    var timeReturnServiseDays: Int!
    var ratingService: String!
    var remoteService: Bool!
    
    init(dictionary: [String: Any]) {

        self.idPrice = dictionary["idPrice"] as? String ?? ""
        self.nameServise = dictionary["nameServise"] as? String ?? ""
        self.priceServies = dictionary["priceServies"] as? Double ?? nil
        self.timeAtWorkHour = dictionary["timeAtWorkHour"] as? Double ?? nil
        self.timeReturnServiseDays = dictionary["timeReturnServiseDays"] as? Int ?? nil
        self.ratingService = dictionary["ratingService"] as? String ?? ""
        self.remoteService = dictionary["remoteService"] as? Bool ?? nil
    }
  
}



