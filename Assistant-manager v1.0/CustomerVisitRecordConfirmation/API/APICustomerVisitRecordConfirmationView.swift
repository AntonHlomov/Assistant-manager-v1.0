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
                    "dateTimeStartService":newCustomerVisit.dateTimeStartService!,
                    "dateTimeEndService": newCustomerVisit.dateTimeEndService!,
                    "idClient":newCustomerVisit.idClient!,
                    "genderClient": newCustomerVisit.genderClient ?? "",
                    "ageClient":newCustomerVisit.ageClient ?? 0,
                    "periodNextRecord": newCustomerVisit.periodNextRecord ?? "",
                   // "service": newCustomerVisit.service! as [Price],
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
