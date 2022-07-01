//
//  APICustomerVisitRecordConfirmationView.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/06/2022.
//

import Foundation
import Firebase

protocol APICustomerVisitRecordConfirmationProtocol {
    func addNewCustomerRecord(comment:String,newCustomerVisit: CustomerRecord,completion: @escaping (Result<Bool,Error>) -> Void)
 
}

class APICustomerVisitRecordConfirmation: APICustomerVisitRecordConfirmationProtocol {
    func addNewCustomerRecord(comment:String,newCustomerVisit: CustomerRecord, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let idCustomerRecord = NSUUID().uuidString
        
       

        let data = ["idRecord": idCustomerRecord,
                    "idUserWhoRecorded":uid,
                    "idUserWhoWorks": newCustomerVisit.idUserWhoWorks!,
                    "nameWhoWorks": newCustomerVisit.nameWhoWorks!,
                    "fullNameWhoWorks": newCustomerVisit.fullNameWhoWorks!,
                    "profileImageWhoWorks": newCustomerVisit.profileImageWhoWorks!,
                    "dateTimeStartService":newCustomerVisit.dateTimeStartService!,
                    "dateTimeEndService": newCustomerVisit.dateTimeEndService!,
                    "idClient":newCustomerVisit.idClient!,
                    "nameClient":newCustomerVisit.nameClient!,
                    "fullNameClient":newCustomerVisit.fullNameClient!,
                    "profileImageClient":newCustomerVisit.profileImageClient!,
                    "telefonClient":newCustomerVisit.telefonClient!,
                    "genderClient": newCustomerVisit.genderClient ?? "",
                    "ageClient":newCustomerVisit.ageClient ?? 0,
                    "service": newCustomerVisit.service ?? [[Price]](),
                    "commit": comment 
                     ] as [String : Any]
        
           Firestore.firestore().collection("users").document(uid).collection("CustomerRecord").document(idCustomerRecord).setData(data) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
        
    }
    
    
}
