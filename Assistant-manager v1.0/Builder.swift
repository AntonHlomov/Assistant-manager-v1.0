//
//  Builder.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/01/2022.
//

import UIKit

protocol Builder{
    static func createMainModule() -> UIViewController
}
// сборщик
class ModelBuilder: Builder{
    // в призентер инжектим вью и модель
    static func createMainModule() -> UIViewController {
       // let user = User(dictionary: [String : Any]
        let view = LoginControler()
        //let presenter = LoginPresentor(view: view, user: user)
        let presenter = LoginPresentor(view: view)
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
