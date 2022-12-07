//
//  APIPrice.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 08/06/2022.
//
import Foundation
import Firebase

protocol APIPriceProtocol {
    func deleteServise(id: String, user: User?,completion: @escaping (Result<Bool,Error>) -> Void)
    func getPriceAPI(user: User?,compleation: @escaping(Result<[Price]?,Error>) -> Void)
}

class APIPrice: APIPriceProtocol{

    func deleteServise(id: String,user: User?,completion: @escaping (Result<Bool, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        db.collection("Price").document(id).delete() { (error) in
            if let error = error {
               completion(.failure(error))
               return
            }
            // Atomically increment
            db.updateData(["priceCount": FieldValue.increment(Int64(-1))])
            completion(.success(true))
        }
    }
    func getPriceAPI(user: User?,compleation: @escaping (Result<[Price]?, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        db.collection("Price").addSnapshotListener{ (snapshot, error) in
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
