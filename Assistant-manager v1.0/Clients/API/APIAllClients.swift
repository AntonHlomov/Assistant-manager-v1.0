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
    func deleteClient(id: String, reference: String, user: User?, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        db.collection("Clients").document(id).delete() { (error) in
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
                db.updateData(["clientsCount": FieldValue.increment(Int64(-1))])
                completion(.success(true))
            }
        }
    }
    
    func getClients(user: User?, completion: @escaping (Result<[Client]?, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        db.collection("Clients").addSnapshotListener{ (snapshot, error) in
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
    }
}
