//
//  APIUserData.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 19/02/2022.
//

import Foundation
import UIKit
import Firebase


protocol APIUserDataServiceProtocol {
    func fetchCurrentUser(completion: @escaping (Result<User?,Error>) -> Void)
    func getCustomerRecord(today:String,team:[Team]?,completion: @escaping (Result<[CustomerRecord]?,Error>) -> Void)
    func fetchCurrentClient(idClient:String,completion: @escaping (Result<Client?,Error>) -> Void)
    func deletCustomerRecorder(idRecorder:String,completion: @escaping (Result<Bool,Error>) -> Void)
    func getTeam(completion: @escaping (Result<[Team]?, Error>) -> Void)
}

class APIUserDataService:APIUserDataServiceProtocol {

  func getCustomerRecord(today:String,team:[Team]?,completion: @escaping (Result<[CustomerRecord]?, Error>) -> Void) {
  guard let uid = Auth.auth().currentUser?.uid else {return}
      var filterCalendar = [CustomerRecord]()
      var calendar = [CustomerRecord]()
      let count = team?.count
      for  i in 0...count!-1{
          
          let idMaster = team?[i].idTeamMember ?? ""
   
          Firestore.firestore().collection("users").document(idMaster).collection("CustomerRecord").whereField("dateStartService", isGreaterThanOrEqualTo:today).addSnapshotListener(){ [] (snapshot, error) in
      if let error = error {
          completion(.failure(error))
          return
      }
     

     // calendar.removeAll()
     // filterCalendar.removeAll()
      // пробегаемся по каждому документу
      snapshot?.documents.forEach({ (documentSnapshot) in
            let customerRecordDictionary = documentSnapshot.data() //as [String:Any]
            let timeCustomerRecord = CustomerRecord(dictionary: customerRecordDictionary)
            calendar.append(timeCustomerRecord)
        
           
        })
       
       filterCalendar =  calendar.sorted{ $0.dateTimeStartService < $1.dateTimeStartService}
       completion(.success( filterCalendar))
     }
          
    }
     
     //  completion(.success( filterCalendar))
  }

    
    func deletCustomerRecorder(idRecorder: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).collection("CustomerRecord").document(idRecorder).delete() { (error) in
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
    

    
    func fetchCurrentClient(idClient: String, completion: @escaping (Result<Client?, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Firestore.firestore().collection("users").document(uid).collection("Clients").document(idClient).getDocument { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let dictionary = snapshot?.data() else {return}
            let client = Client(dictionary:dictionary)
            completion(.success(client))
        }
    }
    
  /*  func getCustomerRecord(today:String,team:[Team]?,completion: @escaping (Result<[CustomerRecord]?, Error>) -> Void) {
     // guard let uid = Auth.auth().currentUser?.uid else {return}
      if team?.isEmpty == false{
          var calendar = [CustomerRecord]()
          var filterCalendar = [CustomerRecord]()
         // calendar.removeAll()
         // filterCalendar.removeAll()
          let count = team?.count
          for  i in 0...count!-1{
              
              let idMaster = team?[i].idTeamMember ?? ""
     
              Firestore.firestore().collection("users").document(idMaster).collection("CustomerRecord").whereField("dateStartService", isGreaterThanOrEqualTo: today).addSnapshotListener { [] (snapshot, error) in
                  if let error = error {
                      completion(.failure(error))
                      return
                  }
                  // пробегаемся по каждому документу
                  snapshot?.documents.forEach({ (documentSnapshot) in
                        let customerRecordDictionary = documentSnapshot.data() //as [String:Any]
                        let timeCustomerRecord = CustomerRecord(dictionary: customerRecordDictionary)
                        calendar.append(timeCustomerRecord)
                    })
            }
       }
          filterCalendar = calendar.sorted{ $0.dateTimeStartService < $1.dateTimeStartService}
          completion(.success(filterCalendar))
          
     }
   
 } */
    
    func fetchCurrentUser(completion: @escaping (Result<User?,Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let dictionary = snapshot?.data() else {return}
            let user = User(dictionary:dictionary)
            completion(.success(user))
            
        }
    }
    
}




/*func getCustomerRecord(today:String,team:[Team]?,completion: @escaping (Result<[CustomerRecord]?, Error>) -> Void) {
guard let uid = Auth.auth().currentUser?.uid else {return}
    
Firestore.firestore().collection("users").document(uid).collection("CustomerRecord").whereField("dateStartService", isGreaterThanOrEqualTo:today).addSnapshotListener { [] (snapshot, error) in
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
*/
