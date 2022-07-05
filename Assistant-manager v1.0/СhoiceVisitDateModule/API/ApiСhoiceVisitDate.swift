//
//  ApiСhoiceVisitDate.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 11/06/2022.
//

import Foundation
import Firebase

protocol ApiСhoiceVisitDateProtocol {
    func getTeam(completion: @escaping (Result<[Team]?,Error>) -> Void)
    func getCustomerRecordPast(idMaster:String,dateStartServiceDMY:String,completion: @escaping (Result<[CustomerRecord]?,Error>) -> Void)

}

class ApiСhoiceVisitDate: ApiСhoiceVisitDateProtocol{
    func getCustomerRecordPast(idMaster:String,dateStartServiceDMY:String,completion: @escaping (Result<[CustomerRecord]?, Error>) -> Void) {
        
        Firestore.firestore().collection("users").document(idMaster).collection("CustomerRecord").whereField("dateStartService", isGreaterThanOrEqualTo: dateStartServiceDMY).getDocuments { [] (snapshot, error) in
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
    
    func getTeam(completion: @escaping (Result<[Team]?, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).collection("Team").addSnapshotListener{ (snapshot, error) in
            if let error = error {
               completion(.failure(error))
               return
            }
            var teamCash = [Team]()
            teamCash.removeAll()
            snapshot?.documents.forEach({ (documentSnapshot) in
            let teamDictionary = documentSnapshot.data()
            let team = Team(dictionary: teamDictionary)
            teamCash.append(team)
            })
            completion(.success(teamCash))
        }
    }
    
    
}
