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
    func getClients(completion: @escaping (Result<[Client]?,Error>) -> Void)
}

class ApiAllClientsDataService:ApiAllClientsDataServiceProtocol {
    
    func getClients(completion: @escaping (Result<[Client]?, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).collection("Client").addSnapshotListener{ (snapshot, error) in
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


