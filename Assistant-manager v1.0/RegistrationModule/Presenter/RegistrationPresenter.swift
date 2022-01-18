//
//  RegistrationPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 18/01/2022.
//

import Foundation
import UIKit
import Firebase



// отправляет сообщение RegistrationView о регистрации  и не регистрации (регистрация пользователя)

//outPut
protocol RegistrationProtocol: class {
    func setRegistrationIndicator(indicator: Bool, error: String)
}

// делаем протокол который завязываемся не на View а нв протоколе RegistrationProtocol и делаем инициализатор которой захватывает ссылку на View принцип  Solid сохряняем уровень абстракции

//inPut
protocol RegistrationViewPresenterProtocol: class {
    init(view: RegistrationProtocol)
    func showRegistrationInformation(photoUser:UIImage,emailAuth: String,name: String, passwordAuth: String)
}

// заввязываемся на протоколе
class RegistrationPresentor: RegistrationViewPresenterProtocol{
    let view: RegistrationProtocol?
    required init(view: RegistrationProtocol) {
    self.view = view
    }
    


    func showRegistrationInformation(photoUser: UIImage, emailAuth: String, name: String, passwordAuth: String) {
       var indicator = false
       var errForAlert = ""
    
        //регистрируем в Fairebase
        Auth.auth().createUser(withEmail: emailAuth, password: passwordAuth) {
            (user, err) in
            if let err = err {
                errForAlert = "\(err.localizedDescription)"
                indicator = false
                self.view?.setRegistrationIndicator(indicator: indicator, error: errForAlert)
            return
            }
            print("Пользователь успешно создан")
            //качество фото при загрузка в базу данных
            guard let uploadDataPhoto = photoUser.jpegData(compressionQuality: 0.3)  else {return}
            //NSUUID() -  это рандомное имя
            let idPhoto = NSUUID().uuidString
            //код загрузки фото
            let storageRef = Storage.storage().reference().child("user_profile_image").child(idPhoto)
            storageRef.putData(uploadDataPhoto, metadata: nil) { (_, err) in
                if let err = err {
                    print("Не удалось загрузить фотографию пользователя!")
                    errForAlert = "\(err.localizedDescription)"
                    indicator = false
                    self.view?.setRegistrationIndicator(indicator: indicator, error: errForAlert)
                    return
                }
                print("Загрузка фотографии пользователя прошла успешно!")
                
                //получаем обратно адрес картинки
                storageRef.downloadURL { (downLoardUrl, err) in
                    guard let profileImageUrl = downLoardUrl?.absoluteString else {return}
                    if let err = err {
                        print(err.localizedDescription)
                        errForAlert = "\(err.localizedDescription)"
                        indicator = false
                        self.view?.setRegistrationIndicator(indicator: indicator, error: errForAlert)
                    return
                }
                    print("Успешна получина ссылка на картинку")
                    guard let uid = Auth.auth().currentUser?.uid else {return}
                    let docData = ["uid": uid,"name": name, "email": emailAuth, "profileImageUrl": profileImageUrl]
                    Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
                        if let err = err {
                            errForAlert = "\(err.localizedDescription)"
                            indicator = false
                            self.view?.setRegistrationIndicator(indicator: indicator, error: errForAlert)
                            return
                    }
                        print("Успешна сохранены данные")
                        indicator = true
                        // здесь презентер говорит вьюхе(абстрактной) что ей сделать
                        self.view?.setRegistrationIndicator(indicator: indicator, error: errForAlert)
                    }
                  }
               }
             }
     
  }
}
