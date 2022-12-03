//
//  TransactionUser.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//
import Foundation

class TransactionUser {
    var idTransaction: String!
    var idUserAdministrator: String!
    var idUserMaster: String!
    var checkNumber: String!
    var dateTransactionFormatDDMMYYYYHHMMSS: String!
    var dateTransactionFormatDDMMYYYY: String!
    var dateTransactionFormatMMYYYY: String!
    var dateTransactionFormatYYYY: String!
    var idClient: String!
    var genderClient:String!
    var ageClient:Int!
    var dictServies: [[String : Any]]!
    var commit: String!
    var cash: Bool!
    var card: Bool!
    var tax: Double!
    var cashPrice: Double!
    var cardPrice: Double!
  
    init(dictionary: [String: Any]) {
        self.idTransaction = dictionary["idTransaction"] as? String ?? ""
        self.idUserAdministrator = dictionary["idUserAdministrator"] as? String ?? ""
        self.idUserMaster = dictionary["idUserMaster"] as? String ?? ""
        self.checkNumber = dictionary["checkNumber"] as? String ?? ""
        self.dateTransactionFormatDDMMYYYYHHMMSS = dictionary["dateTransactionFormatDDMMYYYYHHMMSS"] as? String ?? ""
        self.dateTransactionFormatDDMMYYYY = dictionary["dateTransactionFormatDDMMYYYY"] as? String ?? ""
        self.dateTransactionFormatMMYYYY = dictionary["dateTransactionFormatMMYYYY"] as? String ?? ""
        self.dateTransactionFormatYYYY = dictionary["dateTransactionFormatYYYY"] as? String ?? ""
        self.idClient = dictionary["idClient"] as? String ?? ""
        self.genderClient = dictionary["genderClient"] as? String ?? ""
        self.ageClient = dictionary["ageClient"] as? Int ?? nil
        self.dictServies = dictionary["dictServies"] as?  [[String : Any]] ?? nil
        self.commit = dictionary["commit"] as? String ?? ""
        self.cash = dictionary["cash"] as? Bool ?? nil
        self.card = dictionary["card"] as? Bool ?? nil
        self.tax = dictionary["tax"] as? Double ?? nil
        self.cashPrice = dictionary["cashPrice"] as? Double ?? 0.0
        self.cardPrice = dictionary["cardPrice"] as? Double ??  0.0
    }
}
