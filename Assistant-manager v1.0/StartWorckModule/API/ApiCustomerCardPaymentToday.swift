//
//  ApiCustomerCardPaymentToday.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 07/07/2022.
//
import Foundation
import Firebase
protocol ApiCustomerCardPaymentTodayProtocol {
    func getCustomerRecord(masterId:String,today:String,user: User?,completion: @escaping (Result<[CustomerRecord]?,Error>) -> Void)
    func deletCustomerRecorder(idRecorder: String,idMaster: String,user: User?,completion: @escaping (Result<Bool, Error>) -> Void)
}

class ApiCustomerCardPaymentToday:ApiCustomerCardPaymentTodayProtocol {
    func deletCustomerRecorder(idRecorder: String,idMaster: String,user: User?,completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        switch user?.statusInGroup {
        case "Individual":
            Firestore.firestore().collection("users").document(uid).collection("CustomerRecord").document(idRecorder).delete() { (error) in
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
            guard let idGroup = user?.idGroup else {return}
            Firestore.firestore().collection(nameColection).document(idGroup).collection("CustomerRecord").document(idRecorder).delete() { (error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(true))
                }
        default: break
        }
    }

    func getCustomerRecord(masterId:String,today:String,user: User?,completion: @escaping (Result<[CustomerRecord]?,Error>) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var nameColection = ""
        var idUserOrGroup = ""
        switch user?.statusInGroup {
        case "Individual":
            nameColection = "users"
            idUserOrGroup = uid
        case "Master":
            guard let idGroup = user?.idGroup else {return}
            nameColection = "group"
            idUserOrGroup = idGroup
        case "Administrator":
            guard let idGroup = user?.idGroup else {return}
            nameColection = "group"
            idUserOrGroup = idGroup
        case "Boss":
            guard let idGroup = user?.idGroup else {return}
            nameColection = "group"
            idUserOrGroup = idGroup
        default: return
        }
        Firestore.firestore().collection(nameColection).document(idUserOrGroup).collection("CustomerRecord").whereField("idUserWhoWorks", isEqualTo: masterId ).whereField("dateStartService", isEqualTo: today ).addSnapshotListener { [] (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            var calendar = [CustomerRecord]()
            var filterCalendar = [CustomerRecord]()
            calendar.removeAll()
            filterCalendar.removeAll()
            // пробегаемся по каждому документу
            snapshot?.documents.forEach({ (documentSnapshot) in
                  let customerRecordDictionary = documentSnapshot.data() //as [String:Any]
                  let timeCustomerRecord = CustomerRecord(dictionary: customerRecordDictionary)
                  calendar.append(timeCustomerRecord)
              })
            filterCalendar = calendar.sorted{ $0.dateTimeStartService < $1.dateTimeStartService}
            completion(.success(filterCalendar))
          }
    }
}
