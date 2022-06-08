//
//  APIPrice.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 08/06/2022.
//

import Foundation
import Firebase

protocol APIPriceProtocol {
    func deleteServise(id: String,completion: @escaping (Result<Bool,Error>) -> Void)
    func  getPriceAPI(compleation: @escaping(Result<[Price]?,Error>) -> Void)
  
    
}

class APIPrice: APIPriceProtocol{
    func deleteServise(id: String,completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).collection("Price").document(id).delete() { (error) in
            if let error = error {
               completion(.failure(error))
               return
            }
            completion(.success(true))
        }
          
    }
    
    func getPriceAPI(compleation: @escaping (Result<[Price]?, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).collection("Price").addSnapshotListener{ (snapshot, error) in
            if let error = error {
               compleation(.failure(error))
               return
            }
            var price = [Price]()
            price.removeAll()
            snapshot?.documents.forEach({ (documentSnapshot) in
            let priceDictionary = documentSnapshot.data()
            let service = Price(dictionary: priceDictionary)
            price.append(service)
            })
            compleation(.success(price))
        }
    }
    

}
