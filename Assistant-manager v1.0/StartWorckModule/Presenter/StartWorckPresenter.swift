//
//  StartWorckPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 19/02/2022.
//

import Foundation

protocol StartWorckViewProtocol: AnyObject {
    func success()
    func failure(error:Error)
}
protocol StartWorckViewPresenterProtocol: AnyObject {
    init(view: StartWorckViewProtocol,router: LoginRouterProtocol)
    func data()
}

class StartWorckPresentor: StartWorckViewPresenterProtocol{
  
    
   
    weak var view: StartWorckViewProtocol?
    var router: LoginRouterProtocol?
    
    
    required init(view: StartWorckViewProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.router = router
    }
  
    func data(){
        
    }
}

