//
//  APIAllClients.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 12/05/2022.
//

import Foundation
import UIKit
import Firebase


protocol ApiAllClientsDataServiceProtocol {
    func deleteClient(id: String,reference: String, user: User?, completion: @escaping (Result<Bool,Error>) -> Void)
    func getClients(user: User?, completion: @escaping (Result<[Client]?,Error>) -> Void)
 
}

class ApiAllClientsDataService:ApiAllClientsDataServiceProtocol {
   
    
    func deleteClient(id: String,reference: String, user: User?, completion: @escaping (Result<Bool,Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        switch user?.statusInGroup {
        case "Individual":
            Firestore.firestore().collection("users").document(uid).collection("Clients").document(id).delete() { (error) in
                if let error = error {
                   completion(.failure(error))
                   return
                }
                 let storageRef = Storage.storage().reference(forURL: reference)
                 storageRef.delete { error in
                     if let error = error {
                         completion(.failure(error))
                        return
                     }
                     // Atomically increment the population of the city by 50.increment(Int64(50))
                     // Note that increment() with no arguments increments by 1.
                     Firestore.firestore().collection("users").document(uid).updateData(["clientsCount": FieldValue.increment(Int64(-1))])
                     completion(.success(true))
              }
            }
        case "Master":break
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = user?.idGroup else {return}
            Firestore.firestore().collection(nameColection).document(idGroup).collection("Clients").document(id).delete() { (error) in
                if let error = error {
                   completion(.failure(error))
                   return
                }
                 let storageRef = Storage.storage().reference(forURL: reference)
                 storageRef.delete { error in
                     if let error = error {
                         completion(.failure(error))
                        return
                     }
                     // Atomically increment the population of the city by 50.increment(Int64(50))
                     // Note that increment() with no arguments increments by 1.
                     Firestore.firestore().collection("users").document(uid).updateData(["clientsCount": FieldValue.increment(Int64(-1))])
                     completion(.success(true))
              }
            }
        default: break
        }
    }
    
    func getClients(user: User?,completion: @escaping (Result<[Client]?, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        switch user?.statusInGroup {
        case "Individual":
            Firestore.firestore().collection("users").document(uid).collection("Clients").addSnapshotListener{ (snapshot, error) in
                if let error = error {
                   completion(.failure(error))
                   return
                }
                var clientsCash = [Client]()
                clientsCash.removeAll()
                snapshot?.documents.forEach({ (documentSnapshot) in
                let clientDictionary = documentSnapshot.data()
                let client = Client(dictionary: clientDictionary)
                clientsCash.append(client)
                })
                completion(.success(clientsCash))
            }
        case "Master":
            let nameColection = "group"
            guard let idGroup = user?.idGroup else {return}
            Firestore.firestore().collection(nameColection).document(idGroup).collection("Clients").addSnapshotListener{ (snapshot, error) in
                if let error = error {
                   completion(.failure(error))
                   return
                }
                var clientsCash = [Client]()
                clientsCash.removeAll()
                snapshot?.documents.forEach({ (documentSnapshot) in
                let clientDictionary = documentSnapshot.data()
                let client = Client(dictionary: clientDictionary)
                clientsCash.append(client)
                })
                completion(.success(clientsCash))
            }
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = user?.idGroup else {return}
            Firestore.firestore().collection(nameColection).document(idGroup).collection("Clients").addSnapshotListener{ (snapshot, error) in
                if let error = error {
                   completion(.failure(error))
                   return
                }
                var clientsCash = [Client]()
                clientsCash.removeAll()
                snapshot?.documents.forEach({ (documentSnapshot) in
                let clientDictionary = documentSnapshot.data()
                let client = Client(dictionary: clientDictionary)
                clientsCash.append(client)
                })
                completion(.success(clientsCash))
            }
        default: break
        }
    }
 
}


