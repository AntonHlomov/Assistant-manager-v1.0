//
//  APIClientPage.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 29/05/2022.
//

import Foundation
import Firebase

protocol ApiAllClientPageServiceProtocol {
    func addReminder(text: String, date: String, user: User?,nameClient:String,fulnameClient:String,urlImage: String,userReminder: Bool,sistemReminderColl: Bool,sistemReminderPeriodNextRecord: Bool,idClient: String,completion: @escaping (Result<Bool,Error>) -> Void)
 
}

class ApiAllClientPageDataService: ApiAllClientPageServiceProtocol{
    func addReminder(text: String, date: String, user: User?,nameClient:String,fulnameClient:String,urlImage: String,userReminder: Bool,sistemReminderColl: Bool,sistemReminderPeriodNextRecord: Bool,idClient: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
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
                           ] as [String : Any]
        
        switch user?.statusInGroup {
        case "Individual":
            Firestore.firestore().collection("users").document(uid).collection("Reminder").document(idReminder).setData(dataServies) { (error) in
                if let error = error {
                completion(.failure(error))
                return
                }
                // Atomically increment the population of the city by 50.increment(Int64(50))
                // Note that increment() with no arguments increments by 1.
                Firestore.firestore().collection("users").document(uid).updateData(["priceCount": FieldValue.increment(Int64(1))])
                completion(.success(true))
            }
        case "Master":break
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = user?.idGroup else {return}
            Firestore.firestore().collection(nameColection).document(idGroup).collection("Reminder").document(idReminder).setData(dataServies) { (error) in
                if let error = error {
                completion(.failure(error))
                return
                }
                // Atomically increment the population of the city by 50.increment(Int64(50))
                // Note that increment() with no arguments increments by 1.
              //  Firestore.firestore().collection(nameColection).document(idGroup).updateData(["priceCount": FieldValue.increment(Int64(+1))])
                completion(.success(true))
            }
        default: break
        }
    }
    
   
    
}
