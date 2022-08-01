//
//  APIGlobalUserService.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 31/07/2022.
//

var userGlobal: User?

import Foundation
import UIKit
import Firebase

protocol APIGlobalUserServiceProtocol {
    func fetchCurrentUser(completion: @escaping (Result<User?,Error>) -> Void)
}

class APIGlobalUserService:APIGlobalUserServiceProtocol {
    func fetchCurrentUser(completion: @escaping (Result<User?,Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).addSnapshotListener { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let dictionary = snapshot?.data() else {return}
            userGlobal = User(dictionary:dictionary)
            completion(.success(userGlobal))
        }
    }
}
