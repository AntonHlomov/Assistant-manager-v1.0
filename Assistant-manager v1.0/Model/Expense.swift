//
//  Expense.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//
import Foundation

class Expense {
    var idExpense: String!
    var idUser: String!
    
    var nameUser: String!
    var fullNameUser: String!
    var profileImageUser: String!
    
    var nameExpense: String!
    var priceExpense: Double!
    var placeExpense: String!
    var adresURLPhotoCheckExpense: String!
    var categoryExpense: String!
    
    var dateExpenseFormatDDMMYYYYHHMMSS: String!
    var dateExpenseFormatDDMMYYYY: String!
    var dateExpenseFormatMMYYYY: String!
    var dateExpenseFormatYYYY: String!

    init(dictionary: [String: Any]) {
        self.idExpense = dictionary["idExpense"] as? String ?? ""
        self.idUser = dictionary["idUser"] as? String ?? ""
        self.nameUser = dictionary["nameUser"] as? String ?? ""
        self.fullNameUser = dictionary["fullNameUser"] as? String ?? ""
        self.profileImageUser = dictionary["profileImageUser"] as? String ?? ""
        self.nameExpense = dictionary["nameExpense"] as? String ?? ""
        self.priceExpense = dictionary["priceExpense"] as? Double ?? nil
        self.placeExpense = dictionary["placeExpense"] as? String ?? ""
        self.adresURLPhotoCheckExpense = dictionary["adresURLPhotoCheckExpense"] as? String ?? ""
        self.categoryExpense = dictionary["categoryExpense"] as? String ?? ""
        self.dateExpenseFormatDDMMYYYYHHMMSS = dictionary["dateExpenseFormatDDMMYYYYHHMMSS"] as? String ?? ""
        self.dateExpenseFormatDDMMYYYY = dictionary["dateExpenseFormatDDMMYYYY"] as? String ?? ""
        self.dateExpenseFormatMMYYYY = dictionary["dateExpenseFormatMMYYYY"] as? String ?? ""
        self.dateExpenseFormatYYYY = dictionary["dateExpenseFormatYYYY"] as? String ?? ""
    }
}
