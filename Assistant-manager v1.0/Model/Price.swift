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
    var priceServies: String!
    var timeAtWork: String!
    var timeReturnServise: String!
    var ratingService: String!
    var remoteService: String!
    
    init(dictionary: [String: Any]) {

        self.idPrice = dictionary["IdPrice"] as? String ?? ""
        self.nameServise = dictionary["NameServise"] as? String ?? ""
        self.priceServies = dictionary["PriceServies"] as? String ?? ""
        self.timeAtWork = dictionary["TimeAtWork"] as? String ?? ""
        self.timeReturnServise = dictionary["TimeReturnServise"] as? String ?? ""
        self.ratingService = dictionary["RatingService"] as? String ?? ""
        self.remoteService = dictionary["RemoteService"] as? String ?? ""
    }
  
}



