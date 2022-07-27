//
//  ApiPayment.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/07/2022.
//

import Foundation
import Firebase

protocol ApiPaymentServiceProtocol {
    func addNewTransactionUser(card: Bool,cash: Bool,cashPrice: Double,cardPrice: Double,comment:String,customerRecordent: CustomerRecord?, master: Team?,completion: @escaping (Result<Bool,Error>) -> Void)
 
    
    
}

class ApiPayment: ApiPaymentServiceProtocol{
    func addNewTransactionUser(card: Bool, cash: Bool,cashPrice: Double,cardPrice: Double, comment: String, customerRecordent: CustomerRecord?, master: Team?, completion: @escaping (Result<Bool, Error>) -> Void) {
   
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let uidMaster = master?.idTeamMember else {return}
        let idCustomerRecordForDelite = customerRecordent?.idRecord ?? ""
       
       
        let idTransactionUser = NSUUID().uuidString
        
        let data = ["idTransaction": idTransactionUser,
                    "idUserAdministrator":uid,
                    "idUserMaster": uidMaster,
                    "checkNumber": "",
                    "dateTransactionFormatDDMMYYYYHHMMSS": Date().todayDMYHHMMSSFormat(),
                    "dateTransactionFormatDDMMYYYY": Date().tomorrowDMYFormat(),
                    "dateTransactionFormatMMYYYY": Date().todayMonthFormat(),
                    "dateTransactionFormatYYYY": Date().todayYarFormat(),
                    "idClient": customerRecordent?.idClient as Any,
                    "genderClient":customerRecordent?.genderClient ?? "",
                    "ageClient":customerRecordent?.ageClient ?? 0,
                    "dictServies":customerRecordent?.service! as Any,
                    "commit":comment,
                    "cash":cash,
                    "card":card,
                    "tax": 0 ,
                    "cashPrice": cashPrice,
                    "cardPrice": cardPrice
                     ] as [String : Any]
        
 
        Firestore.firestore().collection("users").document(uidMaster).collection("TransactionUser").document(idTransactionUser).setData(data) { (error) in
            if let error = error {
             completion(.failure(error))
             return
            }
     
        Firestore.firestore().collection("users").document(uidMaster).updateData(["checkCount": FieldValue.increment(Int64(1))])

        Firestore.firestore().collection("users").document(uidMaster).collection("CustomerRecord").document(idCustomerRecordForDelite).delete()
         
            
        completion(.success(true))
     }
        
      
    }
    
   
    
}
