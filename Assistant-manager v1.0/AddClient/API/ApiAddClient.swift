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
    func addClient(nameClient: String, fullName: String,telefonClient: String, profileImageClient:UIImage,genderClient: String, ageClient: Int,textAboutClient: String,completion: @escaping (Result<Bool,Error>) -> Void)
    
}

class ApiAddClient: ApiAddClientDataServiceProtocol{
    func addClient(nameClient: String, fullName: String, telefonClient: String, profileImageClient: UIImage, genderClient: String, ageClient: Int, textAboutClient: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let idClient = NSUUID().uuidString
        let countVisits = 0
        let sumTotal = 0.0
        let remoteClient = false
        let now = Date()
        let todayDate = now.todayDMYFormat()
        
        guard let uploadData = profileImageClient.jpegData(compressionQuality: 0.3) else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        
        let storageRef = Storage.storage().reference().child("Clients_image").child(idClient)
        storageRef.putData(uploadData, metadata: nil) { (_, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            // print("Загрузка фотографии клиента прошла успешно!")
            //получаем обратно адрес картинки
            storageRef.downloadURL { (downLoardUrl, error) in
                guard let profileImageClientUrl = downLoardUrl?.absoluteString else {return}
                if let error = error {
                   // print(error.localizedDescription)
                    completion(.failure(error))
                return
            }
                let dataClient = ["idClient": idClient, "idUserWhoWrote":uid, "nameClient":nameClient , "fullName":fullName,"dateAddClient":todayDate ,"telefonClient":telefonClient ,"profileImageClientUrl":profileImageClientUrl ,"genderClient":genderClient,"ageClient":ageClient,"countVisits":countVisits ,"textAboutClient":textAboutClient ,"sumTotal":sumTotal ,"remoteClient":remoteClient ] as [String : Any]
                
                Firestore.firestore().collection("users").document(uid).collection("Clients").document(idClient).setData(dataClient) { (error) in
                    if let error = error {
                    completion(.failure(error))
                    return
                    }
                    completion(.success(true))
                }
        }
    }
  }
}
