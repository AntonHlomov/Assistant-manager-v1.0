//
//  ApiСhoiceVisitDate.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 11/06/2022.
//
import Foundation
import Firebase

protocol ApiСhoiceVisitDateProtocol {
   // func getTeam(user:User?,completion: @escaping (Result<[Team]?,Error>) -> Void)
    func getCustomerRecordPast(idMaster:String,dateStartServiceDMY:String,user:User?,completion: @escaping (Result<[CustomerRecord]?,Error>) -> Void)
}

class ApiСhoiceVisitDate: ApiСhoiceVisitDateProtocol{
    func getCustomerRecordPast(idMaster: String, dateStartServiceDMY: String, user: User?, completion: @escaping (Result<[CustomerRecord]?, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        var master = ""
               if idMaster.isEmpty {
                   master = uid
               } else {
                   master = idMaster
               }
        
        db.collection("CustomerRecord").whereField("dateStartService", isEqualTo: dateStartServiceDMY).whereField("idUserWhoWorks", isEqualTo: master).getDocuments { [] (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            var customerRecordCash = [CustomerRecord]()
            customerRecordCash.removeAll()
            snapshot?.documents.forEach({ (documentSnapshot) in
                let customerRecordDictionary = documentSnapshot.data()
                let customerRecord = CustomerRecord(dictionary: customerRecordDictionary)
                customerRecordCash.append(customerRecord)
            })
            completion(.success(customerRecordCash))
        }
    }
}
 
