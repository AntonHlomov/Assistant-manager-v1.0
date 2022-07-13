//
//  ApiCustomerCardPaymentToday.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 07/07/2022.
//

import Foundation
import Firebase
protocol ApiCustomerCardPaymentTodayProtocol {
    func getCustomerRecord(masterId:String,today:String,completion: @escaping (Result<[CustomerRecord]?,Error>) -> Void)
    func getTeam(completion: @escaping (Result<[Team]?, Error>) -> Void)
    func deletCustomerRecorder(idRecorder: String,idMaster: String, completion: @escaping (Result<Bool, Error>) -> Void)
    
}

class ApiCustomerCardPaymentToday:ApiCustomerCardPaymentTodayProtocol {
    
    func deletCustomerRecorder(idRecorder: String,idMaster: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        Firestore.firestore().collection("users").document(idMaster).collection("CustomerRecord").document(idRecorder).delete() { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))

            }
 
    }
    
    func getTeam(completion: @escaping (Result<[Team]?, Error>) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).collection("Team").addSnapshotListener{ (snapshot, error) in
            if let error = error {
               completion(.failure(error))
               return
            }
            var teamCash = [Team]()
            teamCash.removeAll()
            snapshot?.documents.forEach({ (documentSnapshot) in
            let teamDictionary = documentSnapshot.data()
            let team = Team(dictionary: teamDictionary)
            teamCash.append(team)
            })
            completion(.success(teamCash))
        }
    }
    
    func getCustomerRecord(masterId:String,today:String,completion: @escaping (Result<[CustomerRecord]?,Error>) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var master = ""
        if masterId != "" {
            master = masterId
        } else {
            master = uid
        }
        
        
        Firestore.firestore().collection("users").document(master).collection("CustomerRecord").whereField("dateStartService", isEqualTo: today ).addSnapshotListener { [] (snapshot, error) in
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
