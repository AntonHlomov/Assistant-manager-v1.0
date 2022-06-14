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

}

class ApiСhoiceVisitDate: ApiСhoiceVisitDateProtocol{
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
