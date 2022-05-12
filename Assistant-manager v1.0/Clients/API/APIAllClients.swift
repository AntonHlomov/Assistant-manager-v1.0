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
   // func fetchCurrentUser(completion: @escaping (Result<User?,Error>) -> Void)
}

class ApiAllClientsDataService:ApiAllClientsDataServiceProtocol {
 //   func fetchCurrentUser(completion: @escaping (Result<User?,Error>) -> Void) {
 //       guard let uid = Auth.auth().currentUser?.uid else {return}
 //       Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
 //           if let error = error {
 //               completion(.failure(error))
 //               return
 //           }
 //           guard let dictionary = snapshot?.data() else {return}
 //           let user = User(dictionary:dictionary)
 //           completion(.success(user))
 //
 //       }
 //   }
    
}
