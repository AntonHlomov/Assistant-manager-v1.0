//
//  ApiTeam.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 22/10/2022.
//

import Foundation
import Firebase

protocol ApiTeamProtocol {
    func getTeam(user:User?,completion: @escaping (Result<[Team]?,Error>) -> Void)
    
}
class ApiTeam: ApiTeamProtocol{
    func getTeam(user:User?,completion: @escaping (Result<[Team]?, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        
        switch user?.statusInGroup {
        case "Individual":
            var masterUserArray = [Team]()
            let masterUser = Team(dictionary: [
                "id": user?.uid ?? "",
                "categoryTeamMember": "master",
                "idTeamMember": user?.uid ?? "",
                "nameTeamMember": user?.name ?? "",
                "fullnameTeamMember": user?.fullName ?? "",
                "profileImageURLTeamMember": user?.profileImage ?? ""
               // "professionName": "hair siaylist"
            ])
            masterUserArray.append(masterUser)
            completion(.success(masterUserArray))
        case "Master":break
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = user?.idGroup else {return}
            
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
