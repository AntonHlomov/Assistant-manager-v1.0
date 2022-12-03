//
//  ApiTeam.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 22/10/2022.
//
import Foundation
import Firebase
import UIKit

protocol ApiTeamProtocol {
    func createNewGroup(userCreate: User?,nameGroup: String, profileImageGroup: UIImage,categoryTeamMember: String, completion: @escaping (Result <Bool,Error>) -> Void)
    func removeTeam (user:User?,team: [Team]?, completion: @escaping (Result<Bool,Error>) -> Void)
    func deleteTeamUser(user:User?,idTeamUser: String, completion: @escaping (Result<Bool,Error>) -> Void)
    func getTeam(user:User?,completion: @escaping (Result<[Team]?,Error>) -> Void)
    func getUserForTeam(idNewUser:String,completion: @escaping (Result<User?,Error>) -> Void)
    func setNewTeamUser(userChief: User?, newTeamUser: User?,categoryTeamMember: String, completion: @escaping (Result <Bool,Error>) -> Void)
    func addNewTeamUserAfterConfirm(userChief: String, newTeamUser: User?,categoryTeamMember: String, idGroup: String, completion: @escaping (Result <Bool,Error>) -> Void)
}

class ApiTeam: ApiTeamProtocol{
    func removeColection(uidGroup: String,nameColection: String){
        guard Auth.auth().currentUser?.uid != nil else {return}
        Firestore.firestore().collection("group").document(uidGroup).collection(nameColection).getDocuments() { (querySnapshot, err) in
          if let err = err {
            print("Error in (removeColection) getting documents: \(err)")
          } else {
            for document in querySnapshot!.documents {
              document.reference.delete()
            }
          }
        }
    }
    func removeTeam (user:User?,team: [Team]?, completion: @escaping (Result<Bool,Error>) -> Void){
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let uidGroup = user?.idGroup  else {return}
        guard uidGroup != "" else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Team does not exist"])
            completion(.failure(error))
            return}
        let colectionsName = ["Clients","Team","Price","CustomerRecord","TransactionUser","Expense"]
        for colecton in colectionsName{
            removeColection(uidGroup: uidGroup, nameColection: colecton)
        }
        Firestore.firestore().collection("group").document(uidGroup).delete() { error in
            if let error = error {
               completion(.failure(error))
               return
            }
            guard let teamRemove = team else {return}
            for teamUser in teamRemove {
                guard let id = teamUser.id else {return}
                Firestore.firestore().collection("users").document(id).updateData(["idGroup": "","statusInGroup": "Individual","hiddenStatus":"Individual"])
            }
            completion(.success(true))
        }
    }
    func deleteTeamUser(user:User?,idTeamUser: String, completion: @escaping (Result<Bool,Error>) -> Void){
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let uidGroup = user?.idGroup  else {return}
        Firestore.firestore().collection("group").document(uidGroup).collection("Team").document(idTeamUser).delete() { (error) in
            if let error = error {
               completion(.failure(error))
               return
            }
                 // Atomically increment the population of the city by 50.increment(Int64(50))
                 // Note that increment() with no arguments increments by 1.
                 Firestore.firestore().collection("group").document(uidGroup).updateData(["teamCount": FieldValue.increment(Int64(-1))])
                 Firestore.firestore().collection("users").document(idTeamUser).updateData(["idGroup": "","statusInGroup": "Individual","hiddenStatus":"Individual"])
                 completion(.success(true))
          }
    }
    func createNewGroup(userCreate: User?,nameGroup: String, profileImageGroup: UIImage,categoryTeamMember: String, completion: @escaping (Result <Bool,Error>) -> Void){
        guard userCreate?.idGroup == nil || userCreate?.idGroup == "" else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let uidGroup = NSUUID().uuidString
        guard let uploadData = profileImageGroup.jpegData(compressionQuality: 0.3) else {return}
        guard let idTeamUser = userCreate?.uid else { return}
        let nameTeamMember = userCreate?.name ?? ""
        let fullnameTeamMember = userCreate?.fullName ?? ""
        let profileImageURLTeamMember = userCreate?.profileImage ?? ""
        
        let dataTeamUser = ["id": idTeamUser,
                            "categoryTeamMember":categoryTeamMember,
                            "idTeamMember":idTeamUser,
                            "nameTeamMember":nameTeamMember,
                            "fullnameTeamMember":fullnameTeamMember,
                            "profileImageURLTeamMember":profileImageURLTeamMember] as [String : Any]
        
        let dataUser = ["idGroup": uidGroup,
                            "statusInGroup":categoryTeamMember,
                            "hiddenStatus":"Individual",
                            "expensesUserInGroup":0,
                            "proceedsUserInGroup":0,
                            "checkCountInGroup":0 ] as [String : Any]
        let storageRef = Storage.storage().reference().child("Group_avatar").child(uidGroup)
        storageRef.putData(uploadData, metadata: nil) { (_, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            //получаем обратно адрес картинки
            storageRef.downloadURL { (downLoardUrl, error) in
                guard let profileImageClientUrl = downLoardUrl?.absoluteString else {return}
               
                if let error = error {
                    completion(.failure(error))
                return
            }
                let dataGroup = ["idGroup": uidGroup,
                                            "nameGroup":nameGroup,
                                            "checkCount":0,
                                            "teamCount":1,
                                            "whoIsBossId":  idTeamUser,
                                            "expensesGroup":0,
                                            "proceedsGroup":0,
                                            "profileImageGroup": profileImageClientUrl,
                                            "priceCount":0] as [String : Any]
                
                Firestore.firestore().collection("group").document(uidGroup).setData(dataGroup) { (error) in
                    if let error = error {
                    completion(.failure(error))
                    return
                    }
                    
                  Firestore.firestore().collection("users").document(uid).updateData(dataUser){ (error) in
                      if let error = error {
                      completion(.failure(error))
                      return
                      }
                      Firestore.firestore().collection("group").document(uidGroup).collection("Team").document(idTeamUser).setData(dataTeamUser) { (error) in
                          if let error = error {
                          completion(.failure(error))
                          return
                          }
                          completion(.success(true))
                    }
                  }
                }
          }
        }
    }
    func setNewTeamUser(userChief: User?, newTeamUser: User?,categoryTeamMember: String, completion: @escaping (Result <Bool,Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        var uidGroup = ""
        if userChief?.idGroup != nil && userChief?.idGroup != "" {
            uidGroup = userChief?.idGroup ?? ""
        }else{
            uidGroup = NSUUID().uuidString
        }
        guard let idTeamUser = newTeamUser?.uid else { return}
        let nameTeamMember = newTeamUser?.name ?? ""
        let fullnameTeamMember = newTeamUser?.fullName ?? ""
        let profileImageURLTeamMember = newTeamUser?.profileImage ?? ""
        
        let dataTeamUser = ["id": idTeamUser,
                            "categoryTeamMember":categoryTeamMember,
                            "idTeamMember":idTeamUser,
                            "nameTeamMember":nameTeamMember,
                            "fullnameTeamMember":fullnameTeamMember,
                            "profileImageURLTeamMember":profileImageURLTeamMember] as [String : Any]
        Firestore.firestore().collection("group").document(uidGroup).collection("Team").document(idTeamUser).setData(dataTeamUser) { (error) in
            if let error = error {
            completion(.failure(error))
            return
            }
            // Atomically increment the population of the city by 50.increment(Int64(50))
            // Note that increment() with no arguments increments by 1.
          Firestore.firestore().collection("group").document(uidGroup).updateData(["teamCount": FieldValue.increment(Int64(1))])
            Firestore.firestore().collection("users").document(idTeamUser).updateData(["idGroup": uidGroup,"statusInGroup": categoryTeamMember,"hiddenStatus":"Individual"])
          completion(.success(true))
        }
    }
    func addNewTeamUserAfterConfirm(userChief: String, newTeamUser: User?,categoryTeamMember: String, idGroup: String, completion: @escaping (Result <Bool,Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let idTeamUser = newTeamUser?.uid else { return}
        let nameTeamMember = newTeamUser?.name ?? ""
        let fullnameTeamMember = newTeamUser?.fullName ?? ""
        let profileImageURLTeamMember = newTeamUser?.profileImage ?? ""
        let dataTeamUser = ["id": idTeamUser,
                            "categoryTeamMember":categoryTeamMember,
                            "idTeamMember":idTeamUser,
                            "nameTeamMember":nameTeamMember,
                            "fullnameTeamMember":fullnameTeamMember,
                            "profileImageURLTeamMember":profileImageURLTeamMember] as [String : Any]
        
        Firestore.firestore().collection("group").document(idGroup).collection("Team").document(idTeamUser).setData(dataTeamUser) { (error) in
            if let error = error {
            completion(.failure(error))
            return
            }
            // Atomically increment the population of the city by 50.increment(Int64(50))
            // Note that increment() with no arguments increments by 1.
          Firestore.firestore().collection("group").document(idGroup).updateData(["teamCount": FieldValue.increment(Int64(1))])
          Firestore.firestore().collection("users").document(idTeamUser).updateData(["idGroup": idGroup,"statusInGroup": categoryTeamMember,"hiddenStatus":"Individual"])
          completion(.success(true))
        }
    }
    func getUserForTeam(idNewUser: String, completion: @escaping (Result<User?, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        
        Firestore.firestore().collection("users").document(idNewUser).getDocument{ [] (snapshot, error) in
            if let error = error {
         completion(.failure(error))
        return
        }
         guard let dictionary = snapshot?.data() else {return}
         let userForTeam = User(dictionary:dictionary)
         completion(.success(userForTeam))
      }

    }
    func getTeam(user:User?,completion: @escaping (Result<[Team]?, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var nameColection = ""
        var idUserOrGroup = ""        
        switch user?.statusInGroup {
        case "Individual": //return
            nameColection = "users"
            idUserOrGroup = uid
        case "Master":
            guard let idGroup = user?.idGroup else {return}
            nameColection = "group"
            idUserOrGroup = idGroup
        case "Administrator":
            guard let idGroup = user?.idGroup else {return}
            nameColection = "group"
            idUserOrGroup = idGroup
        case "Boss":
            guard let idGroup = user?.idGroup else {return}
            nameColection = "group"
            idUserOrGroup = idGroup
        default: return
        }
        Firestore.firestore().collection(nameColection).document(idUserOrGroup).collection("Team").addSnapshotListener{ (snapshot, error) in
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
