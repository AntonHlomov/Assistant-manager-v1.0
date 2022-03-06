//
//  APiRegistration.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 19/02/2022.
//

import UIKit
import Firebase


protocol APIRegistrationProtocol {
    func registration(photoUser: UIImage, emailAuth: String, name: String, passwordAuth: String,statusBoss:Bool,completion: @escaping (Result<Bool,Error>) -> Void)
}

class APIRegistrationService:APIRegistrationProtocol {
    func registration(photoUser: UIImage, emailAuth: String, name: String, passwordAuth: String,statusBoss:Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            
            Auth.auth().createUser(withEmail: emailAuth, password: passwordAuth) {
                (user, error) in
                if let error = error {
                    print("!!!!!!!Filed  error", error.localizedDescription)
                    completion(.failure(error))
                    return
                }
                print("Пользователь успешно создан")
                //качество фото при загрузка в базу данных
                guard let uploadDataPhoto = photoUser.jpegData(compressionQuality: 0.3)  else {return}
                //NSUUID() -  это рандомное имя
                guard let uid = Auth.auth().currentUser?.uid else {return}
                let idPhoto = uid//NSUUID().uuidString
                //код загрузки фото
                let storageRef = Storage.storage().reference().child("user_profile_image").child(idPhoto)
                storageRef.putData(uploadDataPhoto, metadata: nil) { (self, error) in
                    if let error = error {
                        print("!!!!!!!Filed error", error.localizedDescription)
                        completion(.failure(error))
                        return
                    }
                    print("Загрузка фотографии пользователя прошла успешно!")
                    
                    //получаем обратно адрес картинки
                    storageRef.downloadURL { (downLoardUrl, error) in
                        guard let profileImageUrl = downLoardUrl?.absoluteString else {return}
                        if let error = error {
                            print("!!!!!!!Filed error", error.localizedDescription)
                            completion(.failure(error))
                            return
                    }
                        print("Успешна получина ссылка на картинку")
                        guard let uid = Auth.auth().currentUser?.uid else {return}
                        let docData = ["uid": uid,"name": name, "email": emailAuth, "profileImageUrl": profileImageUrl,"statusBoss": statusBoss] as [String : Any]
                        Firestore.firestore().collection("users").document(uid).setData(docData) { (error) in
                            if let error = error {
                                print("!!!!!!!Filed error", error.localizedDescription)
                                completion(.failure(error))
                                return
                        }
                            print("Успешна сохранены данные")
                            // здесь презентер говорит вьюхе(абстрактной) что ей сделать
                            completion(.success(true))
                        }
                      }
                   }
                 }
            
    
        }
    }
}
