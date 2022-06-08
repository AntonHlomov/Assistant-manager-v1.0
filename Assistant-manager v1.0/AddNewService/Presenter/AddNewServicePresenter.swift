//
//  AddNewServicePresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 09/06/2022.
//

import Foundation

protocol AddNewServiceProtocol: AnyObject{
    func succes()
    func failure(error: Error)
}

protocol AddNewServicePresenterProtocol: AnyObject{
    init(view: AddNewServiceProtocol, networkService:ApiAddNewServiceProtocol, ruter:LoginRouterProtocol,editMode: Bool, price: Price?)
    
    }

class AddNewServicePresenter: AddNewServicePresenterProtocol{
    
    weak var view: AddNewServiceProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiAddNewServiceProtocol!
    var price: Price?
    var editMode: Bool?
   
    required init(view: AddNewServiceProtocol, networkService: ApiAddNewServiceProtocol, ruter: LoginRouterProtocol,editMode: Bool,price: Price?) {
        self.view = view
        self.router = ruter
        self.networkService = networkService
        self.price = price
        self.editMode = editMode
    }
    
    
}
