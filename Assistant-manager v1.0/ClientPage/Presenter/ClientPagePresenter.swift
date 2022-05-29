//
//  ClientPagePresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 29/05/2022.
//

import Foundation

protocol ClientPageProtocol: AnyObject {
    
}
 
protocol ClientPagePresenterProtocol: AnyObject{
    init(view: ClientPageProtocol,networkService:ApiAllClientPageServiceProtocol, router:LoginRouterProtocol)
   
}

class ClientPagePresenter: ClientPagePresenterProtocol{
    weak var view: ClientPageProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiAllClientPageServiceProtocol!
    
    required init(view: ClientPageProtocol,networkService:ApiAllClientPageServiceProtocol, router:LoginRouterProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
}
