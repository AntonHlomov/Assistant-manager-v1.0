//
//  APICustomerVisitRecordConfirmationView.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/06/2022.
//

import Foundation
import Firebase

protocol APICustomerVisitRecordConfirmationProtocol {
    func addNewCustomerRecord(comment:String,services:[Price]?,newCustomerVisit: CustomerRecord,completion: @escaping (Result<Bool,Error>) -> Void)
}

class APICustomerVisitRecordConfirmation: APICustomerVisitRecordConfirmationProtocol {
    func addNewCustomerRecord(comment:String,services:[Price]?,newCustomerVisit: CustomerRecord, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let uidMaster = newCustomerVisit.idUserWhoWorks else {return}
        let idCustomerRecord = NSUUID().uuidString
        
        var serviceData = [[String : Any]]()
        for index in 0...services!.count - 1  {
        let serv = services![index]
            let dataServ = [
                "idPrice": serv.idPrice as Any,
                "nameServise": serv.nameServise as Any,
                "priceServies": serv.priceServies as Any,
                "timeAtWorkMin": serv.timeAtWorkMin as Any,
                "timeReturnServiseDays": serv.timeReturnServiseDays as Any,
                "ratingService": serv.ratingService as Any,
                "remoteService": serv.remoteService as Any,
            ] as [String : Any]
            serviceData.append(dataServ)
        }

        switch userGlobal?.statusInGroup {
        case "Individual":
            let data = ["idRecord": idCustomerRecord,
                        "idUserWhoRecorded":uid,
                        "idUserWhoWorks": uidMaster,
                        "nameWhoWorks": newCustomerVisit.nameWhoWorks!,
                        "fullNameWhoWorks": newCustomerVisit.fullNameWhoWorks!,
                        "profileImageWhoWorks": newCustomerVisit.profileImageWhoWorks!,
                        "dateTimeStartService":newCustomerVisit.dateTimeStartService!,
                        "dateTimeEndService": newCustomerVisit.dateTimeEndService!,
                        "dateStartService": newCustomerVisit.dateStartService!,
                        "idClient":newCustomerVisit.idClient!,
                        "nameClient":newCustomerVisit.nameClient!,
                        "fullNameClient":newCustomerVisit.fullNameClient!,
                        "profileImageClient":newCustomerVisit.profileImageClient!,
                        "telefonClient":newCustomerVisit.telefonClient!,
                        "genderClient": newCustomerVisit.genderClient ?? "",
                        "ageClient":newCustomerVisit.ageClient ?? 0,
                        "service": serviceData,
                        "commit": comment
                         ] as [String : Any]
            
               Firestore.firestore().collection("users").document(uid).collection("CustomerRecord").document(idCustomerRecord).setData(data) { (error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(true))
            }
        case "Master":break
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = userGlobal?.idGroup else {return}
            let data = ["idRecord": idCustomerRecord,
                        "idUserWhoRecorded":uid,
                        "idUserWhoWorks": uidMaster,
                        "nameWhoWorks": newCustomerVisit.nameWhoWorks!,
                        "fullNameWhoWorks": newCustomerVisit.fullNameWhoWorks!,
                        "profileImageWhoWorks": newCustomerVisit.profileImageWhoWorks!,
                        "dateTimeStartService":newCustomerVisit.dateTimeStartService!,
                        "dateTimeEndService": newCustomerVisit.dateTimeEndService!,
                        "dateStartService": newCustomerVisit.dateStartService!,
                        "idClient":newCustomerVisit.idClient!,
                        "nameClient":newCustomerVisit.nameClient!,
                        "fullNameClient":newCustomerVisit.fullNameClient!,
                        "profileImageClient":newCustomerVisit.profileImageClient!,
                        "telefonClient":newCustomerVisit.telefonClient!,
                        "genderClient": newCustomerVisit.genderClient ?? "",
                        "ageClient":newCustomerVisit.ageClient ?? 0,
                        "service": serviceData,
                        "commit": comment
                         ] as [String : Any]
            
               Firestore.firestore().collection(nameColection).document(idGroup).collection("CustomerRecord").document(idCustomerRecord).setData(data) { (error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(true))
            }
        default: break
        }

    }
    
    
}
