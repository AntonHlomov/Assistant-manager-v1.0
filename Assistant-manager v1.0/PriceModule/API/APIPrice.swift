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
        guard let uid = Auth.auth().currentUser?.uid else {return}
        switch user?.statusInGroup {
        case "Individual":
            Firestore.firestore().collection("users").document(uid).collection("Price").document(id).delete() { (error) in
                if let error = error {
                   completion(.failure(error))
                   return
                }
                // Atomically increment the population of the city by 50.increment(Int64(50))
                // Note that increment() with no arguments increments by 1.
                Firestore.firestore().collection("users").document(uid).updateData(["priceCount": FieldValue.increment(Int64(-1))])
                completion(.success(true))
            }
        case "Master":break
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = user?.idGroup else {return}
            Firestore.firestore().collection(nameColection).document(idGroup).collection("Price").document(id).delete() { (error) in
                if let error = error {
                   completion(.failure(error))
                   return
                }
                // Atomically increment the population of the city by 50.increment(Int64(50))
                // Note that increment() with no arguments increments by 1.
                Firestore.firestore().collection(nameColection).document(idGroup).updateData(["priceCount": FieldValue.increment(Int64(-1))])
                completion(.success(true))
            }
        default: break
        }
    }
    func getPriceAPI(user: User?,compleation: @escaping (Result<[Price]?, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        switch user?.statusInGroup {
        case "Individual":
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
        case "Master":
            let nameColection = "group"
            guard let idGroup = user?.idGroup else {return}
            Firestore.firestore().collection(nameColection).document(idGroup).collection("Price").addSnapshotListener{ (snapshot, error) in
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
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = user?.idGroup else {return}
            Firestore.firestore().collection(nameColection).document(idGroup).collection("Price").addSnapshotListener{ (snapshot, error) in
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
        default: break
        }
    }
}
