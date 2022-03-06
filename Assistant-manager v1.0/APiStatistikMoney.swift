//
//  APiStatistikMoney.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 21/02/2022.
//

import Foundation
import Firebase


protocol APiStatistikMoneyServiceProtocol {
 //   //выручка revenue
 //   var proceedsToday: Double? { get set }
 //   var proceedsMonth: Double? { get set }
 //   var proceedsYar: Double? { get set }
 //   var proceedsAlltime: Double? { get set }
 //   //расходы expenses
 //   var expensesToday: Double? { get set }
 //   var expensesMonth: Double? { get set }
 //   var expensesYar: Double? { get set }
 //   var expensesAlltime: Double? { get set }

    func getRevenue(indicatorPeriod: String,completion: @escaping (Result<Double?,Error>) -> Void)
}

class APiStatistikMoneyService:APiStatistikMoneyServiceProtocol {


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
                print("ok")
            }
        }
    }
     
    
}
