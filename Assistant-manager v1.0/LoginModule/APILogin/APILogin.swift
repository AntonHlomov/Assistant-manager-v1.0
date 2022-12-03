//
//  APILogin.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 16/02/2022.
//
import Foundation
import Firebase
protocol APILoginServiceProtocol {
    func login(emailAuth: String, passwordAuth: String,completion: @escaping (Result<Bool,Error>) -> Void)
}
class APILoginService:APILoginServiceProtocol {
    func login(emailAuth: String, passwordAuth: String, completion:  @escaping (Result<Bool,Error>) -> Void) {
        DispatchQueue.global(qos: .utility).async {
        }
        Auth.auth().signIn(withEmail: emailAuth, password: passwordAuth) { (user, error) in
            if let error = error {
                completion(.failure(error))
                return
         }
            completion(.success(true))
        }
    }
}
