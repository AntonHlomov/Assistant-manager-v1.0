//
//  AddNewExpensesPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 29/11/2022.
//

import Foundation
import UIKit


protocol AddNewExpensesProtocol: AnyObject{
    func failure(error: Error)
   
}

protocol AddNewExpensesPresenterProtocol: AnyObject{
    init(view: AddNewExpensesProtocol, networkService:ExpensesApiProtocol, ruter:LoginRouterProtocol,user: User?)
    func add(name: String,place: String,category: String, total: Double,imageСheck: UIImage)
}

class AddNewExpensesPresenter:AddNewExpensesPresenterProtocol{
   
    
    weak var view: AddNewExpensesProtocol?
    var router: LoginRouterProtocol?
    let networkService:ExpensesApiProtocol!
    var user: User?
   
    required  init(view: AddNewExpensesProtocol, networkService:ExpensesApiProtocol, ruter:LoginRouterProtocol,user: User?) {
        self.view = view
        self.router = ruter
        self.networkService = networkService
        self.user = user
  
    }
    func add(name: String, place: String, category: String, total: Double, imageСheck: UIImage ) {
        networkService.setExpense(user: self.user, name: name, place: place, category: category, total: total, imageСheck: imageСheck){[weak self] result in
            guard let self = self else {return}
                DispatchQueue.main.async {
                    switch result{
                    case.success(_):
                        self.router?.popViewControler()
                    case.failure(let error):
                        self.view?.failure(error: error)
                    }
                }
            }
        }
        
   
    
}
