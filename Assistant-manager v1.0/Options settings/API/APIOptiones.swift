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
    
    func countClients(user: User?, completion: @escaping (Result<Int, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        db.collection("Clients").addSnapshotListener{ (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(snapshot?.count ?? 0))
        }
    }
    
    func countPrice(user: User?, completion: @escaping (Result<Int, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        db.collection("Price").addSnapshotListener{ (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(snapshot?.count ?? 0))
        }
    }
    
    func countTeam(user: User?, completion: @escaping (Result<Int, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        db.collection("Team").addSnapshotListener{ (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(snapshot?.count ?? 0))
        }
    }  
}
