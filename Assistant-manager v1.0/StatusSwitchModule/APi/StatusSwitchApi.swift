//
//  StatusSwitchApi.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 25/11/2022.
//

import Foundation
import Firebase

protocol StatusSwitchApiProtocol {
    func swapStatusSwitch(statusInGroup:String,hiddenStatus: String,completion:@escaping(Result<Bool,Error>)-> Void)
}

class StatusSwitchApi: StatusSwitchApiProtocol {
   
    func swapStatusSwitch(statusInGroup:String,hiddenStatus: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let dataServies = ["statusInGroup": hiddenStatus, "hiddenStatus":statusInGroup ] as [String : Any]
        
        Firestore.firestore().collection("users").document(uid).updateData(dataServies) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
  
}
