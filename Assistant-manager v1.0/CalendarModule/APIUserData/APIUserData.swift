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
    func getCustomerRecord(user: User?,today:String,team:[Team]?,completion: @escaping (Result<[CustomerRecord]?,Error>) -> Void)
    func fetchCurrentClient(user: User?,idClient:String,team:[Team]?,completion: @escaping (Result<Client?,Error>) -> Void)
    func deletCustomerRecorder(user: User?,idRecorder:String,masterId:String,completion: @escaping (Result<Bool,Error>) -> Void)
    func getTeam(user: User?,completion: @escaping (Result<[Team]?, Error>) -> Void)
}


class APIUserDataService:APIUserDataServiceProtocol {
  func getCustomerRecord(user: User?,today:String,team:[Team]?, completion: @escaping (Result<[CustomerRecord]?, Error>) -> Void) {
      guard let uid = Auth.auth().currentUser?.uid else {return}
     
      switch user?.statusInGroup {
      case "Individual":
          var filterCalendar = [CustomerRecord]()
          var calendar = [CustomerRecord]()
          Firestore.firestore().collection("users").document(uid).collection("CustomerRecord").whereField("dateStartService", isGreaterThanOrEqualTo:today).addSnapshotListener{ [] (snapshot, error) in
          if let error = error {
          completion(.failure(error))
          return
         }
          calendar.removeAll()
          filterCalendar.removeAll()
         // пробегаемся по каждому документу
      snapshot?.documents.forEach({ (documentSnapshot) in
            let customerRecordDictionary = documentSnapshot.data() //as [String:Any]
            let timeCustomerRecord = CustomerRecord(dictionary: customerRecordDictionary)
            calendar.append(timeCustomerRecord)
        })
       filterCalendar =  calendar.sorted{ $0.dateTimeStartService < $1.dateTimeStartService}
       completion(.success( filterCalendar))
      }
      case "Master":break
      case "Administrator":break
      case "Boss":
          let nameColection = "group"
          guard let idGroup = user?.idGroup else {return}
          var filterCalendar = [CustomerRecord]()
          var calendar = [CustomerRecord]()
          Firestore.firestore().collection(nameColection).document(idGroup).collection("CustomerRecord").whereField("dateStartService", isEqualTo:today).addSnapshotListener{ [] (snapshot, error) in
          if let error = error {
          completion(.failure(error))
          return
         }
          calendar.removeAll()
          filterCalendar.removeAll()
         // пробегаемся по каждому документу
      snapshot?.documents.forEach({ (documentSnapshot) in
            let customerRecordDictionary = documentSnapshot.data() //as [String:Any]
            let timeCustomerRecord = CustomerRecord(dictionary: customerRecordDictionary)
            calendar.append(timeCustomerRecord)
        })
       filterCalendar =  calendar.sorted{ $0.dateTimeStartService < $1.dateTimeStartService}
       completion(.success( filterCalendar))
      }
      default: break
      }
   
  }

    func deletCustomerRecorder(user: User?,idRecorder: String,masterId:String, completion: @escaping (Result<Bool, Error>) -> Void) {
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
  
    func getTeam(user: User?,completion: @escaping (Result<[Team]?, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        let nameColection = "group"
        guard let idGroup = user?.idGroup else {return}
        Firestore.firestore().collection(nameColection).document(idGroup).collection("Team").addSnapshotListener{ (snapshot, error) in
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

    func fetchCurrentClient(user: User?,idClient: String,team:[Team]?, completion: @escaping (Result<Client?, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        switch user?.statusInGroup {
        case "Individual":
            Firestore.firestore().collection("users").document(uid).collection("Clients").document(idClient).getDocument { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let dictionary = snapshot?.data() else {return}
                let client = Client(dictionary:dictionary)
                completion(.success(client))
            }
        case "Master":break
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = user?.idGroup else {return}
            Firestore.firestore().collection(nameColection).document(idGroup).collection("Clients").document(idClient).getDocument { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let dictionary = snapshot?.data() else {return}
                let client = Client(dictionary:dictionary)
                completion(.success(client))
            }
        default: break
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
 func getCustomerRecord(today:String,team:[Team]?, user: User?, completion: @escaping (Result<[CustomerRecord]?, Error>) -> Void) {
     guard let uid = Auth.auth().currentUser?.uid else {return}
     var teamAll = team
     var filterCalendar = [CustomerRecord]()
     var calendar = [CustomerRecord]()
     
     switch user?.idGroup {
     case "groupEmpty":
         var filterCalendar = [CustomerRecord]()
         var calendar = [CustomerRecord]()
         Firestore.firestore().collection("users").document(uid).collection("CustomerRecord").whereField("dateStartService", isGreaterThanOrEqualTo:today).getDocuments{ [] (snapshot, error) in
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
     case "Master":break
     case "Administrator":break
     case "Boss":break
     default: break
     }

     if user?.statusBoss == true {
         
     }
     if user?.statusAdministrator == true {
         
     }
     if user?.statusMaster == true {
       teamAll = team?.filter { $0.idTeamMember == uid  }
     }
     if user?.idGroup == "groupEmpty" {
       teamAll = team?.filter { $0.idTeamMember == uid  }
     }
     
     let count = teamAll?.count
     for  i in 0...count!-1{
         let idMaster = teamAll?[i].idTeamMember ?? ""
         Firestore.firestore().collection("users").document(idMaster).collection("CustomerRecord").whereField("dateStartService", isGreaterThanOrEqualTo:today).getDocuments{ [] (snapshot, error) in
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
 
 switch userGlobal?.statusInGroup {
 case "groupEmpty":break
 case "Master":break
 case "Administrator":break
 case "Boss":break
 default: break
 }
*/
