//
//  TransactionUser.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//

import Foundation

class TransactionUser {

    var CheckNumber: String!
    var DateTransaction: String!
    var IdClient: String!
    var IdTransaction: String!
    var IdArrayNameServies: [String]!
    var GeneralPriceServies: String!
    var TextServies: String!
    var CashOrCard: String!
    var Tax: String!
    var Gender:String!
  
    init(dictionary: [String: Any]) {

        self.CheckNumber = dictionary["CheckNumber"] as? String ?? ""
        self.DateTransaction = dictionary["DateTransaction"] as? String ?? ""
        self.IdClient = dictionary["IdClient"] as? String ?? ""
        self.IdTransaction = dictionary["IdTransaction"] as? String ?? ""
        self.IdArrayNameServies = dictionary["IdArrayNameServies"] as? [String] ?? [""]
        self.GeneralPriceServies = dictionary["GeneralPriceServies"] as? String ?? ""
        self.TextServies = dictionary["TextServies"] as? String ?? ""
        self.CashOrCard = dictionary["CashOrCard"] as? String ?? ""
        self.Tax = dictionary["Tax"] as? String ?? ""
        self.Gender = dictionary["Gender"] as? String ?? ""
    }
  
}



