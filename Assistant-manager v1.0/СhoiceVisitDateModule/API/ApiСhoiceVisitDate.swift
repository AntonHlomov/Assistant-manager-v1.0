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
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        
        switch userGlobal?.statusInGroup {
        case "groupEmpty":
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
        case "Master":break
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = userGlobal?.idGroup else {return}
            
            Firestore.firestore().collection(nameColection).document(idGroup).collection("CustomerRecord").whereField("dateStartService", isEqualTo: dateStartServiceDMY).whereField("idUserWhoWorks", isEqualTo: idMaster).getDocuments { [] (snapshot, error) in
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
        default: break
        }
    }
    
    func getTeam(completion: @escaping (Result<[Team]?, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        
        switch userGlobal?.statusInGroup {
        case "groupEmpty":
            var masterUserArray = [Team]()
            let masterUser = Team(dictionary: [
                "id": userGlobal?.uid ?? "",
                "categoryTeamMember": "master",
                "idTeamMember": userGlobal?.uid ?? "",
                "nameTeamMember": userGlobal?.name ?? "",
                "fullnameTeamMember": userGlobal?.fullName ?? "",
                "profileImageURLTeamMember": userGlobal?.profileImage ?? ""
               // "professionName": "hair siaylist"
            ])
            masterUserArray.append(masterUser)
            completion(.success(masterUserArray))
        case "Master":break
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = userGlobal?.idGroup else {return}
            
            Firestore.firestore().collection(nameColection).document(idGroup).collection("Team").addSnapshotListener{ (snapshot, error) in
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
        default: break
        }
    }

    
    
}
