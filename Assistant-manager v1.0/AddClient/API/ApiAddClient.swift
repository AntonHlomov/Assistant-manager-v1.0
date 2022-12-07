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
    
    func addClient(nameClient: String, fullName: String, telefonClient: String, profileImageClient: UIImage, genderClient: String, ageClient: Int, textAboutClient: String, user: User?, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        guard let uploadData = profileImageClient.jpegData(compressionQuality: 0.3) else {return}
        let idClient = NSUUID().uuidString
        var dataClient = ["idClient":idClient,
                          "idUserWhoWrote":uid,
                          "nameClient":nameClient,
                          "fullName":fullName,
                          "dateAddClient":Date().todayDMYFormat(),
                          "telefonClient":telefonClient,
                          "profileImageClientUrl":"",
                          "genderClient":genderClient,
                          "ageClient":ageClient,
                          "countVisits":0,
                          "textAboutClient":textAboutClient,
                          "sumTotal":0.0,
                          "remoteClient":false] as [String : Any]
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
                dataClient["profileImageClientUrl"] = profileImageClientUrl
                db.collection("Clients").document(idClient).setData(dataClient) { (error) in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    db.updateData(["clientsCount": FieldValue.increment(Int64(1))])
                    completion(.success(true))
                }
            }
        }
    }
    
    func editClient(changePhoto: Bool, idClient: String, olderUrlImageClient: String, nameClient: String, fullName: String, telefonClient: String, profileImageClient: UIImage, genderClient: String, ageClient: Int, textAboutClient: String, user: User?, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        var dataClient = ["idClient":idClient,
                          "nameClient":nameClient,
                          "fullName":fullName,
                          "telefonClient":telefonClient,
                          "genderClient":genderClient,
                          "ageClient":ageClient,
                          "textAboutClient":textAboutClient] as [String : Any]
        // change photo
        switch changePhoto{
        case true:
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
                        db.collection("Clients").document(idClient).updateData(dataClient) { (error) in
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
            db.collection("Clients").document(idClient).updateData(dataClient) { (error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(true))
            }
        }
    }
}
