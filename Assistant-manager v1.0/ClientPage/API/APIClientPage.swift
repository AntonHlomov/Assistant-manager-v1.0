//
//  APIClientPage.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 29/05/2022.
//
import Foundation
import Firebase

protocol ApiAllClientPageServiceProtocol {
    func addReminder(text: String, date: String, user: User?,nameClient:String,fulnameClient:String,urlImage: String,userReminder: Bool,sistemReminderColl: Bool,sistemReminderPeriodNextRecord: Bool,idClient: String,idUserWhoIsTheMessage:String, completion: @escaping (Result<Bool,Error>) -> Void)
    func deleteReminder(user: User?,idReminder: String,completion: @escaping (Result<Bool,Error>) -> Void)
 
}

class ApiAllClientPageDataService: ApiAllClientPageServiceProtocol{
    func addReminder(text: String, date: String, user: User?, nameClient: String, fulnameClient: String, urlImage: String, userReminder: Bool, sistemReminderColl: Bool, sistemReminderPeriodNextRecord: Bool, idClient: String, idUserWhoIsTheMessage: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        let idReminder = NSUUID().uuidString
        let dataServies = ["idReminder": idReminder,
                           "idUser":uid,
                           "idClient":idClient,
                           "commit":text,
                           "dateShowReminder":date,
                           "userReminder":userReminder,
                           "sistemReminderColl":sistemReminderColl,
                           "sistemReminderPeriodNextRecord":sistemReminderPeriodNextRecord,
                           "nameClient":nameClient,
                           "fullNameClient": fulnameClient,
                           "profileImageClientUrl": urlImage,
                           "idUserWhoIsTheMessage":idUserWhoIsTheMessage,
        ] as [String : Any]
        db.collection("Reminder").document(idReminder).setData(dataServies) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    func deleteReminder(user: User?,idReminder: String,completion: @escaping (Result<Bool,Error>) -> Void){
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        db.collection("Reminder").document(idReminder).delete() { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
}
