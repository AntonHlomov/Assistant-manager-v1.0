//
//  ApiAddClient.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 03/06/2022.
//
import Foundation
import Firebase
import UIKit
protocol ApiAddClientDataServiceProtocol{
    func addClient(nameClient: String, fullName: String,telefonClient: String, profileImageClient:UIImage,genderClient: String, ageClient: Int,textAboutClient: String,user: User?,completion: @escaping (Result<Bool,Error>) -> Void)
    func editClient(changePhoto:Bool,idClient: String,olderUrlImageClient: String, nameClient: String, fullName: String,telefonClient: String, profileImageClient:UIImage,genderClient: String, ageClient: Int,textAboutClient: String, user: User?,completion: @escaping (Result<Bool,Error>) -> Void)
}

class ApiAddClient: ApiAddClientDataServiceProtocol{
    func editClient(changePhoto:Bool,idClient: String, olderUrlImageClient: String, nameClient: String, fullName: String, telefonClient: String, profileImageClient: UIImage, genderClient: String, ageClient: Int, textAboutClient: String, user: User?, completion: @escaping (Result<Bool, Error>) -> Void) {

        var dataClient = ["idClient": idClient,"nameClient":nameClient,"fullName":fullName,"telefonClient":telefonClient ,"genderClient":genderClient,"ageClient":ageClient,"textAboutClient":textAboutClient] as [String : Any]
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        switch user?.statusInGroup {
        case "Individual":
            switch changePhoto{
            case true:
                // change photo
                //качество фото при загрузка в базу данных
                guard let uploadData = profileImageClient.jpegData(compressionQuality: 0.3) else {return}
                // удаляем старое фото
                let storageRefDel = Storage.storage().reference(forURL: olderUrlImageClient)
                storageRefDel.delete { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    //код загрузки фото
                    let storageRef = Storage.storage().reference().child("Clients_image").child(idClient)
                    storageRef.putData(uploadData, metadata: nil) { (_, error) in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        //получаем обратно адрес картинки
                        storageRef.downloadURL { (downLoardUrl, error) in
                            guard let newURLPhoto = downLoardUrl?.absoluteString else {return}
                            if let error = error {
                                completion(.failure(error))
                                return
                            }
                            dataClient["profileImageClientUrl"] = newURLPhoto
                            Firestore.firestore().collection("users").document(uid).collection("Clients").document(idClient).updateData(dataClient) { (error) in
                                if let error = error {
                                    completion(.failure(error))
                                    return
                                }
                                completion(.success(true))
                            }
                        }
                    }
                }
            case false:
                // do not change photo
                Firestore.firestore().collection("users").document(uid).collection("Clients").document(idClient).updateData(dataClient) { (error) in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    completion(.success(true))
                }
            }
        case "Master":break
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = user?.idGroup else {return}
            switch changePhoto{
            case true:
                // change photo
                //качество фото при загрузка в базу данных
                guard let uploadData = profileImageClient.jpegData(compressionQuality: 0.3) else {return}
                // удаляем старое фото
                let storageRefDel = Storage.storage().reference(forURL: olderUrlImageClient)
                storageRefDel.delete { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    //код загрузки фото
                    let storageRef = Storage.storage().reference().child("Clients_image").child(idClient)
                    storageRef.putData(uploadData, metadata: nil) { (_, error) in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        //получаем обратно адрес картинки
                        storageRef.downloadURL { (downLoardUrl, error) in
                            guard let newURLPhoto = downLoardUrl?.absoluteString else {return}
                            if let error = error {
                                completion(.failure(error))
                                return
                            }
                            dataClient["profileImageClientUrl"] = newURLPhoto
                            Firestore.firestore().collection(nameColection).document(idGroup).collection("Clients").document(idClient).updateData(dataClient) { (error) in
                                if let error = error {
                                    completion(.failure(error))
                                    return
                                }
                                completion(.success(true))
                            }
                        }
                    }
                }
            case false:
                // do not change photo
                Firestore.firestore().collection(nameColection).document(idGroup).collection("Clients").document(idClient).updateData(dataClient) { (error) in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    completion(.success(true))
                }
            }
        default: break
        }
    
    }
    
    func addClient(nameClient: String, fullName: String, telefonClient: String, profileImageClient: UIImage, genderClient: String, ageClient: Int, textAboutClient: String, user: User?, completion: @escaping (Result<Bool, Error>) -> Void) {
        let idClient = NSUUID().uuidString
        let countVisits = 0
        let sumTotal = 0.0
        let remoteClient = false
        let now = Date()
        let todayDate = now.todayDMYFormat()
        guard let uploadData = profileImageClient.jpegData(compressionQuality: 0.3) else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        switch user?.statusInGroup {
        case "Individual":
            let storageRef = Storage.storage().reference().child("Clients_image").child(idClient)
            storageRef.putData(uploadData, metadata: nil) { (_, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                //получаем обратно адрес картинки
                storageRef.downloadURL { (downLoardUrl, error) in
                    guard let profileImageClientUrl = downLoardUrl?.absoluteString else {return}
                    if let error = error {
                        completion(.failure(error))
                    return
                }
                    let dataClient = ["idClient": idClient, "idUserWhoWrote":uid, "nameClient":nameClient , "fullName":fullName,"dateAddClient":todayDate ,"telefonClient":telefonClient ,"profileImageClientUrl":profileImageClientUrl ,"genderClient":genderClient,"ageClient":ageClient,"countVisits":countVisits ,"textAboutClient":textAboutClient ,"sumTotal":sumTotal ,"remoteClient":remoteClient ] as [String : Any]
                    
                    Firestore.firestore().collection("users").document(uid).collection("Clients").document(idClient).setData(dataClient) { (error) in
                        if let error = error {
                        completion(.failure(error))
                        return
                        }
                        // Atomically increment the population of the city by 50.increment(Int64(50))
                        // Note that increment() with no arguments increments by 1.
                        Firestore.firestore().collection("users").document(uid).updateData(["clientsCount": FieldValue.increment(Int64(1))])
                        completion(.success(true))
                    }
                }
            }
        case "Master":break
        case "Administrator":break
        case "Boss":
            let nameColection = "group"
            guard let idGroup = user?.idGroup else {return}
            let storageRef = Storage.storage().reference().child("Clients_image").child(idClient)
            storageRef.putData(uploadData, metadata: nil) { (_, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                //получаем обратно адрес картинки
                storageRef.downloadURL { (downLoardUrl, error) in
                    guard let profileImageClientUrl = downLoardUrl?.absoluteString else {return}
                    if let error = error {
                        completion(.failure(error))
                    return
                }
                    let dataClient = ["idClient": idClient, "idUserWhoWrote":uid, "nameClient":nameClient , "fullName":fullName,"dateAddClient":todayDate ,"telefonClient":telefonClient ,"profileImageClientUrl":profileImageClientUrl ,"genderClient":genderClient,"ageClient":ageClient,"countVisits":countVisits ,"textAboutClient":textAboutClient ,"sumTotal":sumTotal ,"remoteClient":remoteClient ] as [String : Any]
                    
                    Firestore.firestore().collection(nameColection).document(idGroup).collection("Clients").document(idClient).setData(dataClient) { (error) in
                        if let error = error {
                        completion(.failure(error))
                        return
                        }
                        // Atomically increment the population of the city by 50.increment(Int64(50))
                        // Note that increment() with no arguments increments by 1.
                        Firestore.firestore().collection(nameColection).document(idGroup).updateData(["clientsCount": FieldValue.increment(Int64(1))])
                        completion(.success(true))
                    }
                }
            }
        default: break
        }
  }
}
