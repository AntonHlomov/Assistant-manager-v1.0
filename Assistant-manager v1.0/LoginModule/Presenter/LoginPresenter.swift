//
//  LoginPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//
import Foundation

protocol LoginViewProtocol: AnyObject {
    func dismiss()
    func failure(error:Error)
}

protocol LoginViewPresenterProtocol: AnyObject {
    init(view: LoginViewProtocol,networkService: APILoginServiceProtocol,router: LoginRouterProtocol,networkServiceGlobalUser: APIGlobalUserServiceProtocol)
    func authorisation(emailAuth: String, passwordAuth: String)
    func goToRegistarasionControler()
}

class LoginPresentor: LoginViewPresenterProtocol{
    weak var view: LoginViewProtocol?
    var router: LoginRouterProtocol?
    let networkService:APILoginServiceProtocol!
    let networkServiceGlobalUser:APIGlobalUserServiceProtocol!
    required init(view: LoginViewProtocol,networkService:APILoginServiceProtocol, router: LoginRouterProtocol,networkServiceGlobalUser: APIGlobalUserServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.networkServiceGlobalUser = networkServiceGlobalUser
        self.router = router
    }
    func goToRegistarasionControler(){
        router?.showRegistrationController()
    }
    func authorisation(emailAuth: String, passwordAuth: String) {
        networkService.login(emailAuth: emailAuth, passwordAuth: passwordAuth) {[weak self] result in
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
               }
            }
         }
     }
}
