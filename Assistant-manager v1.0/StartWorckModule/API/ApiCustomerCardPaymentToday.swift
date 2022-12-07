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
    func getCustomerRecord(masterId: String, today: String, user: User?, completion: @escaping (Result<[CustomerRecord]?, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        db.collection("CustomerRecord").whereField("idUserWhoWorks", isEqualTo: masterId ).whereField("dateStartService", isEqualTo: today ).addSnapshotListener { [] (snapshot, error) in
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
    
    func deletCustomerRecorder(idRecorder: String, idMaster: String, user: User?, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        db.collection("CustomerRecord").document(idRecorder).delete() { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
}
