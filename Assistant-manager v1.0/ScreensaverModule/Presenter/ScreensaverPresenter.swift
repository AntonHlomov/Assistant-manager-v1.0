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
    func failure(error:Error)
  
}
//inPut
protocol ScreensaverPresenterProtocol: AnyObject {
    init(view: ScreensaverViewProtocol,router: LoginRouterProtocol, networkService:APIGlobalUserServiceProtocol)
    func authCheck()
}
class ScreensaverPresentor: ScreensaverPresenterProtocol{
    weak var view: ScreensaverViewProtocol?
    var router: LoginRouterProtocol?
    let networkService:APIGlobalUserServiceProtocol!
    
    required init(view: ScreensaverViewProtocol, router: LoginRouterProtocol, networkService:APIGlobalUserServiceProtocol) {
       
        self.view = view
        self.router = router
        self.networkService = networkService
       
    }

    func authCheck() {
        sleep(2)
        
        if Auth.auth().currentUser != nil{
          //  self.router?.initalMainTabControler()
          getGlobalUser()
        } else {
            self.router?.initalLoginViewControler()
            self.view?.dismiss()
           // self.view?.dismiss()
           // self.router?.dismiss()
          
        }
    }
    func getGlobalUser(){
        print("getGlobalUser")
        DispatchQueue.main.async {
            self.networkService.fetchCurrentUser{[weak self] result in
            guard let self = self else {return}
                    switch result{
                    case.success(let user):
                        self.router?.initalMainTabControler(user: user)
                    case.failure(let error):
                        self.view?.failure(error: error)
                        sleep(2)
                        self.router?.initalLoginViewControler()
                        self.view?.dismiss()
               }
            }
         }
     }
}
