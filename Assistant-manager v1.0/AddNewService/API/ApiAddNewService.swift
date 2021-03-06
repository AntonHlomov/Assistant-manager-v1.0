//
//  ApiAddNewService.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 09/06/2022.
//

import Foundation
import Firebase

protocol ApiAddNewServiceProtocol{
    func addServies(nameServise: String, priceServies: Double, timeAtWorkMin: Int, timeReturnServiseDays: Int,completion: @escaping (Result<Bool,Error>) -> Void)
    
    func editServies(idPrice: String,nameServise: String, priceServies: Double, timeAtWorkMin: Int, timeReturnServiseDays: Int,completion: @escaping (Result<Bool,Error>) -> Void)
  
}

class ApiAddNewService: ApiAddNewServiceProtocol{
    func addServies(nameServise: String, priceServies: Double, timeAtWorkMin: Int, timeReturnServiseDays: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let idServies = NSUUID().uuidString
        let dataServies = ["idPrice": idServies, "nameServise":nameServise, "priceServies":priceServies, "timeAtWorkMin":timeAtWorkMin,"timeReturnServiseDays":timeReturnServiseDays ,"ratingService":0 ,"remoteService":false ] as [String : Any]
        
        Firestore.firestore().collection("users").document(uid).collection("Price").document(idServies).setData(dataServies) { (error) in
            if let error = error {
            completion(.failure(error))
            return
            }
            // Atomically increment the population of the city by 50.increment(Int64(50))
            // Note that increment() with no arguments increments by 1.
            Firestore.firestore().collection("users").document(uid).updateData(["priceCount": FieldValue.increment(Int64(1))])
            completion(.success(true))
        }
    }
    
    func editServies(idPrice: String, nameServise: String, priceServies: Double, timeAtWorkMin: Int, timeReturnServiseDays: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let dataServies = ["idPrice": idPrice, "nameServise":nameServise, "priceServies":priceServies, "timeAtWorkMin":timeAtWorkMin,"timeReturnServiseDays":timeReturnServiseDays ] as [String : Any]
        
        Firestore.firestore().collection("users").document(uid).collection("Price").document(idPrice).updateData(dataServies) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
        
    }
    
    
    
}
