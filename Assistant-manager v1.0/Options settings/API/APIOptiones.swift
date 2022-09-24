//
//  APIOptiones.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 12/05/2022.
//

import Foundation
import UIKit
import Firebase


protocol APIOptionesDataServiceProtocol {
    func signOutUser(completion: @escaping (Result<Bool,Error>) -> Void)
    func countClients(user: User?,completion: @escaping (Result<Int,Error>) -> Void)
    func countPrice(user: User?,completion: @escaping (Result<Int,Error>) -> Void)
    func countTeam(user: User?,completion: @escaping (Result<Int,Error>) -> Void)
}

class APIOptionesDataService:APIOptionesDataServiceProtocol {
   
    
    
    
    func signOutUser(completion: @escaping (Result<Bool,Error>) -> Void) {
        do{
            try Auth.auth().signOut()
            completion(.success(true))
            } catch {
                completion(.failure("Faild to sign out Выйти" as! Error))
            }
    }
    
    func countClients(user: User?,completion: @escaping (Result<Int,Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        switch user?.statusInGroup {
        case "Individual":
            Firestore.firestore().collection("users").document(uid).collection("Clients").addSnapshotListener{ (snapshot, error) in
                if let error = error {
                   completion(.failure(error))
                   return
                }
                completion(.success(snapshot?.count ?? 0))
            }
        case "Master":break
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = user?.idGroup else {return}
            Firestore.firestore().collection(nameColection).document(idGroup).collection("Clients").addSnapshotListener{ (snapshot, error) in
                if let error = error {
                   completion(.failure(error))
                   return
                }
                completion(.success(snapshot?.count ?? 0))
            }
        default:
            completion(.failure("There was a problem with your status while uploading data Clients.count. Please restart the application..."+"\n" as! Error))
            break
        }
    }
    func countPrice(user: User?,completion: @escaping (Result<Int,Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        switch user?.statusInGroup {
        case "Individual":
            Firestore.firestore().collection("users").document(uid).collection("Price").addSnapshotListener{ (snapshot, error) in
                if let error = error {
                   completion(.failure(error))
                   return
                }
                completion(.success(snapshot?.count ?? 0))
            }
        case "Master":break
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = user?.idGroup else {return}
            Firestore.firestore().collection(nameColection).document(idGroup).collection("Price").addSnapshotListener{ (snapshot, error) in
                if let error = error {
                   completion(.failure(error))
                   return
                }
                completion(.success(snapshot?.count ?? 0))
            }
        default:
            completion(.failure("There was a problem with your status while uploading data Price.count. Please restart the application..."+"\n" as! Error))
            break
        }
    }
    
    func countTeam(user: User?,completion: @escaping (Result<Int,Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        switch user?.statusInGroup {
        case "Individual":
                completion(.success(0))
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
                completion(.success(snapshot?.count ?? 0))
            }
        default:
            completion(.failure("There was a problem with your status while uploading data Team.count. Please restart the application..."+"\n" as! Error))
            break
        }
    }
  
    
}
