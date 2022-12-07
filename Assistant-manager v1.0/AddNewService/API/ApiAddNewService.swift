//
//  ApiAddNewService.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 09/06/2022.
//
import Foundation
import Firebase

protocol ApiAddNewServiceProtocol{
    func addServies(nameServise: String, priceServies: Double, timeAtWorkMin: Int, timeReturnServiseDays: Int,user: User?,completion: @escaping (Result<Bool,Error>) -> Void)
    func editServies(idPrice: String,nameServise: String, priceServies: Double, timeAtWorkMin: Int, timeReturnServiseDays: Int,user: User?,completion: @escaping (Result<Bool,Error>) -> Void)
}

class ApiAddNewService: ApiAddNewServiceProtocol{
    func addServies(nameServise: String, priceServies: Double, timeAtWorkMin: Int, timeReturnServiseDays: Int,user: User?, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        let idServies = NSUUID().uuidString
        let dataServies = ["idPrice":idServies,
                           "nameServise":nameServise,
                           "priceServies":priceServies,
                           "timeAtWorkMin":timeAtWorkMin,
                           "timeReturnServiseDays":timeReturnServiseDays,
                           "ratingService":0,
                           "remoteService":false ] as [String : Any]
        db.collection("Price").document(idServies).setData(dataServies) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            db.updateData(["priceCount": FieldValue.increment(Int64(1))])
            completion(.success(true))
        }
    }
    func editServies(idPrice: String, nameServise: String, priceServies: Double, timeAtWorkMin: Int, timeReturnServiseDays: Int,user: User?, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        let dataServies = ["idPrice": idPrice,
                           "nameServise":nameServise,
                           "priceServies":priceServies,
                           "timeAtWorkMin":timeAtWorkMin,
                           "timeReturnServiseDays":timeReturnServiseDays ] as [String : Any]
        db.collection("Price").document(idPrice).updateData(dataServies) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
}
