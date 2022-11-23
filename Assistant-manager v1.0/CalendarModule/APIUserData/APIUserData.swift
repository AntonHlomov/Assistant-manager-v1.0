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
    func getReminder(user: User?,date:String,completion: @escaping (Result<[Reminder]?,Error>) -> Void)
    func fetchCurrentClient(user: User?,idClient:String,team:[Team]?,completion: @escaping (Result<Client?,Error>) -> Void)
    func deletCustomerRecorder(user: User?,idRecorder:String,masterId:String,completion: @escaping (Result<Bool,Error>) -> Void)
    func getTeam(user: User?,completion: @escaping (Result<[Team]?, Error>) -> Void)
    func getClient(user: User?,idClient: String, completion: @escaping (Result<Client?, Error>) -> Void)
}

class APIUserDataService:APIUserDataServiceProtocol {
    
    func getClient(user: User?,idClient: String, completion: @escaping (Result<Client?, Error>) -> Void){
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
        
        var client: Client?
        Firestore.firestore().collection(nameColection).document(idUserOrGroup).collection("Clients").whereField("idClient", isEqualTo: idClient).getDocuments{ [] (snapshot, error) in
            if let error = error {
        completion(.failure(error))
        return
       }
       // пробегаемся по каждому документу
       snapshot?.documents.forEach({ (documentSnapshot) in
          let clientDictionary = documentSnapshot.data()
          client = Client(dictionary: clientDictionary)
      })
     completion(.success(client))
     }
    }
    
    func getReminder(user: User?, date: String, completion: @escaping (Result<[Reminder]?, Error>) -> Void) {
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
        
        var reminders = [Reminder]()
        Firestore.firestore().collection(nameColection).document(idUserOrGroup).collection("Reminder").whereField("dateShowReminder", isEqualTo:date).addSnapshotListener{ [] (snapshot, error) in
        if let error = error {
        completion(.failure(error))
        return
       }
        reminders.removeAll()
           // пробегаемся по каждому документу
        snapshot?.documents.forEach({ (documentSnapshot) in
              let reminderDictionary = documentSnapshot.data() //as [String:Any]
              let reminder = Reminder(dictionary: reminderDictionary)
            reminders.append(reminder)
       })
       completion(.success( reminders))
       }
    }
    
    func getCustomerRecord(user: User?,today:String,team:[Team]?, completion: @escaping (Result<[CustomerRecord]?, Error>) -> Void) {
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
        
        var filterCalendar = [CustomerRecord]()
        var calendar = [CustomerRecord]()
        Firestore.firestore().collection(nameColection).document(idUserOrGroup).collection("CustomerRecord").whereField("dateStartService", isGreaterThanOrEqualTo:today).addSnapshotListener{ [] (snapshot, error) in
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
    }
    
    func deletCustomerRecorder(user: User?,idRecorder: String,masterId:String, completion: @escaping (Result<Bool, Error>) -> Void) {
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
        
        Firestore.firestore().collection(nameColection).document(idUserOrGroup).collection("CustomerRecord").document(idRecorder).delete() { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(true))
        }
    }
    
    func getTeam(user: User?,completion: @escaping (Result<[Team]?, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        var nameColection = ""
        var idUserOrGroup = ""
      
        switch user?.statusInGroup {
        case "Individual":
            return
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
        Firestore.firestore().collection(nameColection).document(idUserOrGroup).collection("Team").addSnapshotListener{ (snapshot, error) in
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
        
        Firestore.firestore().collection(nameColection).document(idUserOrGroup).collection("Clients").document(idClient).getDocument { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let dictionary = snapshot?.data() else {return}
            let client = Client(dictionary:dictionary)
            completion(.success(client))
        }
    }
}
