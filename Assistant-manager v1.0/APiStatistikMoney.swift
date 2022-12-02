//
//  APiStatistikMoney.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 21/02/2022.
//

import Foundation
import Firebase


protocol APiStatistikMoneyServiceProtocol {
    func getFinancialReport(user:User?,datePeriodMMYY: String,completion: @escaping (Result<FinancialReport?,Error>) -> Void)
    
    
    func getRevenue(indicatorPeriod: String,completion: @escaping (Result<Double?,Error>) -> Void)
    func getExpenses(indicatorPeriod: String, completion: @escaping (Result<Double?, Error>) -> Void) 
}

class APiStatistikMoneyService:APiStatistikMoneyServiceProtocol {
    
    func getFinancialReport(user:User?,datePeriodMMYY: String,completion: @escaping (Result<FinancialReport?,Error>) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var nameColection = ""
        var idUserOrGroup = ""
        
        switch user?.statusInGroup {
        case "Individual":
            nameColection = "users"
            idUserOrGroup = uid
        case "Master":
            guard let idGroup = user?.idGroup else {return}
            nameColection = "group"
            idUserOrGroup = idGroup
        case "Administrator":
            guard let idGroup = user?.idGroup else {return}
            nameColection = "group"
            idUserOrGroup = idGroup
        case "Boss":
            guard let idGroup = user?.idGroup else {return}
            nameColection = "group"
            idUserOrGroup = idGroup
        default: return
        }
      
        
        let docRef = Firestore.firestore().collection(nameColection).document(idUserOrGroup).collection("FinancialReport").document(datePeriodMMYY)
        
        docRef.addSnapshotListener { [] (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let dictionary = snapshot?.data() else {return}
            let financialReporter = FinancialReport(dictionary:dictionary)
            completion(.success(financialReporter))
        }
        
      
    }


    func getRevenue(indicatorPeriod: String, completion: @escaping (Result<Double?, Error>) -> Void) {
        var daterevenue = ""
        switch indicatorPeriod  {
        case "today":
            daterevenue = Date().todayDMYFormat()
        case "month":
            daterevenue = Date().todayMonthFormat()
        case "yar":
            daterevenue = Date().todayYarFormat()
        default:
            return
        }

        DispatchQueue.global(qos: .utility).async {
            guard let uid = Auth.auth().currentUser?.uid else {return}
            Firestore.firestore().collection("users").document(uid).collection("TransactionUser").whereField("dateTransactionFormatDDMMYYYY", isEqualTo: daterevenue).getDocuments { (snapshot, error) in
                if let error = error{
                    print(error.localizedDescription)
                    completion(.failure(error))
                    return
                }
                var proceedsToday = 0.0
                snapshot?.documents.forEach({ (documentSnapshot) in
                    let transactionDictionary = documentSnapshot.data()
                    let transaction = TransactionUser(dictionary: transactionDictionary)
                    proceedsToday += transaction.cashPrice + transaction.cardPrice
            
                })
                completion(.success(proceedsToday))
                print("ok getRevenue in APiStatistikMoneyService")
            }
        }
    }
    
    func getExpenses(indicatorPeriod: String, completion: @escaping (Result<Double?, Error>) -> Void) {
        var daterevenue = ""
        switch indicatorPeriod  {
        case "today":
            daterevenue = Date().todayDMYFormat()
        case "month":
            daterevenue = Date().todayMonthFormat()
        case "yar":
            daterevenue = Date().todayYarFormat()
        default:
            return
        }

        DispatchQueue.global(qos: .utility).async {
            guard let uid = Auth.auth().currentUser?.uid else {return}
            Firestore.firestore().collection("users").document(uid).collection("Expense").whereField("dateExpenseFormatDDMMYYYY", isEqualTo: daterevenue).getDocuments { (snapshot, error) in
                if let error = error{
                    print(error.localizedDescription)
                    completion(.failure(error))
                    return
                }
                var expensesToday = 0.0
                snapshot?.documents.forEach({ (documentSnapshot) in
                    let transactionDictionary = documentSnapshot.data()
                    let transaction = Expense(dictionary: transactionDictionary)
                    expensesToday += transaction.priceExpense
            
                })
                completion(.success(expensesToday))
                print("ok getExpenses in getRevenue")
            }
        }
    }
     
    
}
