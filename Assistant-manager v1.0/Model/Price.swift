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
    var timeAtWorkMin: Int!
    var timeReturnServiseDays: Int!
    var ratingService: Int!
    var remoteService: Bool!
    
    init(dictionary: [String: Any]) {
        self.idPrice = dictionary["idPrice"] as? String ?? ""
        self.nameServise = dictionary["nameServise"] as? String ?? ""
        self.priceServies = dictionary["priceServies"] as? Double ?? nil
        self.timeAtWorkMin = dictionary["timeAtWorkMin"] as? Int ?? nil
        self.timeReturnServiseDays = dictionary["timeReturnServiseDays"] as? Int ?? nil
        self.ratingService = dictionary["ratingService"] as? Int ?? nil
        self.remoteService = dictionary["remoteService"] as? Bool ?? nil
    }
}
