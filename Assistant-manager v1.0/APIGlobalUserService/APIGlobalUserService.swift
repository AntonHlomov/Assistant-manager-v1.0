//
//  APIGlobalUserService.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 31/07/2022.
//

//var userGlobal: User?


import Foundation
import UIKit
import Firebase

protocol APIGlobalUserServiceProtocol {
    func fetchCurrentUser(completion: @escaping (Result<User?,Error>) -> Void)
    func cancelRequestAddTeam(completion: @escaping (Result <Bool,Error>) -> Void)
    func addRequestAddTeam(userBoss: User?, idNewTeamUser: String,statusInGroup: String, completion: @escaping (Result <Bool,Error>) -> Void)
   
   
}

class APIGlobalUserService:APIGlobalUserServiceProtocol {
    func addRequestAddTeam(userBoss: User?,idNewTeamUser: String,statusInGroup: String, completion: @escaping (Result <Bool,Error>) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let idGroupRequest = userBoss?.idGroup else {return}
        guard let profileImageUserRequest = userBoss?.profileImage  else {return}
        guard let nameRequest = userBoss?.name else {return}
        guard let fullNameRequest = userBoss?.fullName else {return}
      
        
        let data = ["markerRequest": true,
                    "idGroupRequest":idGroupRequest,
                    "idUserRequest":uid,
                    "profileImageUserRequest":profileImageUserRequest,
                    "nameRequest":nameRequest,
                    "fullNameRequest":fullNameRequest,
                    "statusInGroupRequest": statusInGroup] as [String : Any]
   
        Firestore.firestore().collection("users").document(idNewTeamUser).updateData(data ){ (error) in
            if let error = error {
            completion(.failure(error))
            return
            }
            completion(.success(true))
        }
        
    }
    func cancelRequestAddTeam(completion: @escaping (Result <Bool,Error>) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
       
        let data = ["markerRequest": false,
                    "idGroupRequest":"",
                    "idUserRequest":"",
                    "profileImageUserRequest":"",
                    "nameRequest":"",
                    "fullNameRequest":"",
                    "statusInGroupRequest": ""] as [String : Any]
   
        Firestore.firestore().collection("users").document(uid).updateData(data ){ (error) in
            if let error = error {
            completion(.failure(error))
            return
            }
            completion(.success(true))
        }
        
    }


   // public var userGlobal: User?
    func fetchCurrentUser(completion: @escaping (Result<User?,Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).addSnapshotListener { [] (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let dictionary = snapshot?.data() else {return}
            let user = User(dictionary:dictionary)
            completion(.success(user))
        }
    }
}
