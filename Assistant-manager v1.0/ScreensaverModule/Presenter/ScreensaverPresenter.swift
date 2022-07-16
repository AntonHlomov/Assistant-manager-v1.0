//
//  ScreensaverPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 18/01/2022.
//

import Foundation
import Firebase

//outPut
protocol ScreensaverViewProtocol: AnyObject {
    func dismiss()
  
}
//inPut
protocol ScreensaverPresenterProtocol: AnyObject {
    init(view: ScreensaverViewProtocol,router: LoginRouterProtocol)
    func authCheck()
}
class ScreensaverPresentor: ScreensaverPresenterProtocol{
    weak var view: ScreensaverViewProtocol?
    var router: LoginRouterProtocol?
    
    required init(view: ScreensaverViewProtocol, router: LoginRouterProtocol) {
       
        self.view = view
        self.router = router
    }

  
    func authCheck() {
        if Auth.auth().currentUser != nil{
            // переход с удалением предыдущего контролера
          print("Переходим в Таб бар контролер")
          router?.initalMainTabControler()
        } else {
            router?.initalLoginViewControler()
            self.view?.dismiss()
        }
       
    }
}
