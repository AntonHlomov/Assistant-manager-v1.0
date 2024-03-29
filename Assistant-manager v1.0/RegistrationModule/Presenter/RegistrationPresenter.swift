//
//  RegistrationPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 18/01/2022.
//
import Foundation
import UIKit

protocol RegistrationProtocol: AnyObject {
    func dismiss()
    func failure(error:Error)
}
protocol RegistrationViewPresenterProtocol: AnyObject {
    init(view: RegistrationProtocol,networkService: APIRegistrationProtocol,router: LoginRouterProtocol,networkServiceGlobalUser: APIGlobalUserServiceProtocol)
    func showRegistrationInformation(photoUser:UIImage,emailAuth: String,name: String, passwordAuth: String)
    func goToLoginControler()
}

class RegistrationPresentor: RegistrationViewPresenterProtocol{
    
    weak var view: RegistrationProtocol?
    var router: LoginRouterProtocol?
    let networkService:APIRegistrationProtocol!
    let networkServiceGlobalUser:APIGlobalUserServiceProtocol!
    
    required init(view: RegistrationProtocol,networkService:APIRegistrationProtocol,router: LoginRouterProtocol,networkServiceGlobalUser: APIGlobalUserServiceProtocol) {
    self.view = view
    self.networkService = networkService
    self.networkServiceGlobalUser = networkServiceGlobalUser
    self.router = router
    }
    func goToLoginControler() {
        router?.popToRoot()
    }
    func showRegistrationInformation(photoUser: UIImage, emailAuth: String, name: String, passwordAuth: String) {
        networkService.registration(photoUser: photoUser, emailAuth: emailAuth, name: name, passwordAuth: passwordAuth){[weak self] result in
            guard let self = self else {return}
                DispatchQueue.main.async {
                    switch result{
                    case.success(_):
                        self.getGlobalUser()
                    case.failure(let error):
                        self.view?.failure(error: error)
                    }
                }
            }
      }
    func getGlobalUser(){
        print("getGlobalUser")
        DispatchQueue.main.async {
            self.networkServiceGlobalUser.fetchCurrentUser{[weak self] result in
            guard let self = self else {return}
                    switch result{
                    case.success(let user):
                        self.router?.initalMainTabControler(user: user)
                        self.view?.dismiss()
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
