//
//  AddClientPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 03/06/2022.
//

import Foundation

protocol AddClientViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol AddClientViewPresenterProtocol: AnyObject {
    init(view: AddClientViewProtocol,networkService: ApiAddClientDataServiceProtocol, router: LoginRouterProtocol)

    
}

class AddClientPresenter: AddClientViewPresenterProtocol {
   
    
    weak var view: AddClientViewProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiAddClientDataServiceProtocol!
    
    required init(view: AddClientViewProtocol, networkService: ApiAddClientDataServiceProtocol, router: LoginRouterProtocol) {
           self.view = view
           self.router = router
           self.networkService = networkService
       }
    
 
    
}

