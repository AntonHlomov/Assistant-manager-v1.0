//
//  ExpensesPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 19/02/2022.
//

import Foundation

protocol ExpensesViewProtocol: AnyObject {
    func success()
    func failure(error:Error)
}
protocol ExpensesViewPresenterProtocol: AnyObject {
    init(view: ExpensesViewProtocol,networkService: APILoginServiceProtocol,router: LoginRouterProtocol)
    func data()
}

class ExpensesPresentor: ExpensesViewPresenterProtocol{
   
    weak var view: ExpensesViewProtocol?
    var router: LoginRouterProtocol?
    let networkService:APILoginServiceProtocol!
    
    required init(view: ExpensesViewProtocol,networkService:APILoginServiceProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
  
    func data(){
        
    }
}

