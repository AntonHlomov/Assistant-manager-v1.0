//
//  Costs.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//

import Foundation

class Costs {

    var idCosts: String!
    var idUser: String!
    var nameCosts: String!
    var priceCosts: Double!
    var placeCosts: String!
    var adresURLPhotoCheckCosts: String!
    var categoryCosts: String!
    var dateTimeCostsString: String!
    var dateTimeSecondForFilter: String!

    init(dictionary: [String: Any]) {

        self.idCosts = dictionary["idCosts"] as? String ?? ""
        self.idUser = dictionary["idUser"] as? String ?? ""
        self.nameCosts = dictionary["nameCosts"] as? String ?? ""
        self.priceCosts = dictionary["priceCosts"] as? Double ?? 0.0
        self.placeCosts = dictionary["placeCosts"] as? String ?? ""
        self.categoryCosts = dictionary["categoryCosts"] as? String ?? ""
        self.dateTimeCostsString = dictionary["dateTimeCostsString"] as? String ?? ""
        self.adresURLPhotoCheckCosts = dictionary["adresURLPhotoCheckCosts"] as? String ?? ""
        self.dateTimeSecondForFilter = dictionary["dateTimeSecondForFilter"] as? String ?? ""
    }
}



