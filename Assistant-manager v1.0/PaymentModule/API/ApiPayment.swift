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
        
        
        switch userGlobal?.statusInGroup {
        case "groupEmpty":
            let data = ["idTransaction": idTransactionUser,
                        "idUserAdministrator":uid,
                        "idUserMaster": uid,
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

            Firestore.firestore().collection("users").document(uid).collection("TransactionUser").document(idTransactionUser).setData(data) { (error) in
                if let error = error {
                 completion(.failure(error))
                 return
                }
            Firestore.firestore().collection("users").document(uid).updateData(["checkCount": FieldValue.increment(Int64(1))])
            Firestore.firestore().collection("users").document(uid).collection("CustomerRecord").document(idCustomerRecordForDelite).delete()
            completion(.success(true))
            }
        case "Master":break
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = userGlobal?.idGroup else {return}
            
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

            Firestore.firestore().collection(nameColection).document(idGroup).collection("TransactionUser").document(idTransactionUser).setData(data) { (error) in
                if let error = error {
                 completion(.failure(error))
                 return
                }
            Firestore.firestore().collection(nameColection).document(idGroup).updateData(["checkCount": FieldValue.increment(Int64(1))])
            Firestore.firestore().collection(nameColection).document(idGroup).collection("CustomerRecord").document(idCustomerRecordForDelite).delete()
            completion(.success(true))
            }
        default: break
        }
        
   
        
      
    }
  
}
