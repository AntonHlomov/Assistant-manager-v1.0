//
//  Builder.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/01/2022.
//

import UIKit

protocol Builder{
    static func createLoginModule() -> UIViewController
    static func createRegistrationModule() -> UIViewController
    
    static func createScreensaverModule() -> UIViewController
}
// сборщик
class ModelBuilder: Builder{
    // в призентер инжектим вью и модель
    static func createLoginModule() -> UIViewController {
       // let user = User(dictionary: [String : Any]
        let view = LoginControler()
        //let presenter = LoginPresentor(view: view, user: user)
        let presenter = LoginPresentor(view: view)
        view.presenter = presenter
        return view
  }
   static func createRegistrationModule() -> UIViewController {
       let view = RegistrationController()
       let presenter = RegistrationPresentor(view: view)
       view.presenter = presenter
       return view
   }
    
    static func createScreensaverModule() -> UIViewController {
        let view = ScreensaverViewController()
        let presenter = ScreensaverPresentor(view: view)
        view.presenter = presenter
        return view
    }
    // другой модуль напримр Модуль Регистрации
  // static func createSecendModule() -> UIViewController {
  //    // let user = User(dictionary: [String : Any]
  //     let view = LoginControler()
  //     //let presenter = LoginPresentor(view: view, user: user)
  //     let presenter = LoginPresentor(view: view)
  //     view.presenter = presenter
  //     return view
  // }
}
