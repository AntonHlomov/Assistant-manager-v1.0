//
//  StatistikPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 19/02/2022.
//

import Foundation

protocol StatistikViewProtocol: AnyObject {
    func success()
    func failure(error:Error)
}
protocol StatistikViewPresenterProtocol: AnyObject {
    init(view: StatistikViewProtocol,router: LoginRouterProtocol,user: User?)
    func data()
}

class StatistikPresentor: StatistikViewPresenterProtocol{
  
    
   
    weak var view: StatistikViewProtocol?
    var router: LoginRouterProtocol?
    var user: User?
    
    
    required init(view: StatistikViewProtocol, router: LoginRouterProtocol,user: User?) {
        self.view = view
        self.router = router
        self.user = user
    }
  
    func data(){
        
    }
}
