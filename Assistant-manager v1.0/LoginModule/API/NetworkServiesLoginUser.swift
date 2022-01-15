//
//  NetworkServiesLoginUser.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//

import Foundation
import Firebase

protocol NetworkServiesLoginUserProtocol{
    func loginUser (emailAuth: String, passwordAuth: String) -> Bool
}
class LoginAPI {
 

    func loginUser (emailAuth: String, passwordAuth: String) -> Bool {
        var statusLogin = false
        Auth.auth().signIn(withEmail: emailAuth, password: passwordAuth) { (user, err) in
            if let err = err {
                print("!!!!!!!Filed to login with error", err.localizedDescription)
              //  self.error = "\(err.localizedDescription)"
                statusLogin = false
                return
        }
            print("Successfuly signed user in")
            statusLogin = true
        }
        return statusLogin
  }

}

