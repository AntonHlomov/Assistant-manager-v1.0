//
//  LoginPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//

import Foundation
import Firebase

protocol LoginViewProtocol: AnyObject {
    func success(authUser:Bool)
    func failure(error:Error)
}
protocol LoginViewPresenterProtocol: AnyObject {
    init(view: LoginViewProtocol,networkService: APILoginServiceProtocol)
    func authorisation(emailAuth: String, passwordAuth: String)
}

class LoginPresentor: LoginViewPresenterProtocol{
    weak var view: LoginViewProtocol?
    let networkService:APILoginServiceProtocol!
    required init(view: LoginViewProtocol,networkService:APILoginServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    func authorisation(emailAuth: String, passwordAuth: String) {
        networkService.login(emailAuth: emailAuth, passwordAuth: passwordAuth) {[weak self] result in
        guard let self = self else {return}
            DispatchQueue.main.async {
                switch result{
            case.success(let authUser):
                self.view?.success(authUser: authUser)
            case.failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}

