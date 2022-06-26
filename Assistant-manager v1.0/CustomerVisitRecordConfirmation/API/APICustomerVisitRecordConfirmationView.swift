//
//  APICustomerVisitRecordConfirmationView.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/06/2022.
//

import Foundation
import Firebase

protocol APICustomerVisitRecordConfirmationProtocol {
    func addNewCustomerRecord(newCustomerVisit: CustomerRecord,completion: @escaping (Result<Bool,Error>) -> Void)
 
}

class APICustomerVisitRecordConfirmation: APICustomerVisitRecordConfirmationProtocol {
    func addNewCustomerRecord(newCustomerVisit: CustomerRecord, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let idCustomerRecord = NSUUID().uuidString
      
        
     //       Firestore.firestore().collection("users").document(uid).collection("CustomerRecord")//.document(idCustomerRecord).setData(newCustomerVisitas) { (error) in
     //       if let error = error {
     //           completion(.failure(error))
     //           return
     //       }
     //       completion(.success(true))
     //   }
        
    }
    
    
}
