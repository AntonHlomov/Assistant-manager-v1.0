//
//  APILogin.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 16/02/2022.
//

import Foundation
import UIKit
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
                print("!!!!!!!Filed to login with error", error.localizedDescription)
                completion(.failure(error))
                return
        }
            print("Successfuly signed user in")
            completion(.success(true))
        }
    }
}
