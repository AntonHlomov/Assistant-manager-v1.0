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
    func getNameGroupCoWorking(idGroup: String, completion: @escaping(Result<String,Error>)-> Void)
}

class StatusSwitchApi: StatusSwitchApiProtocol {
    func getNameGroupCoWorking(idGroup: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else { return }
        Firestore.firestore().collection("group").document(idGroup).getDocument { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let dictionary = snapshot?.data(), let nameGroup = dictionary["nameGroup"] as? String else {
                completion(.failure(NSError(domain: "Firestore", code: -1, userInfo: [NSLocalizedDescriptionKey: "Название группы не найдено"])))
                return
            }
            completion(.success(nameGroup))
        }
    }
    /*
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
    */
    
    func swapStatusSwitch(statusInGroup: String, hiddenStatus: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard !statusInGroup.isEmpty, !hiddenStatus.isEmpty else {
            completion(.failure(NSError(domain: "Firestore", code: -1, userInfo: [NSLocalizedDescriptionKey: "Status values cannot be empty"])))
            return
        }
        let dataServies = ["statusInGroup": hiddenStatus, "hiddenStatus": statusInGroup ] as [String : Any]
        Firestore.firestore().collection("users").document(uid).updateData(dataServies) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
}
