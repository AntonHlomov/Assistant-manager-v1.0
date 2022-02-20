//
//  APIUserData.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 19/02/2022.
//

import Foundation
import UIKit
import Firebase


protocol APIUserDataServiceProtocol {
    func fetchCurrentUser(completion: @escaping (Result<User?,Error>) -> Void)
}

class APIUserDataService:APIUserDataServiceProtocol {
    func fetchCurrentUser(completion: @escaping (Result<User?,Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
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
