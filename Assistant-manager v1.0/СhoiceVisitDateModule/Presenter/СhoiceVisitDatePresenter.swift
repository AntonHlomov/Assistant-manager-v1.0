//
//  СhoiceVisitDatePresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 11/06/2022.
//

import Foundation

protocol СhoiceVisitDateProtocol: AnyObject{
    func succes()
    func failure(error: Error)
}

protocol СhoiceVisitDatePresenterProtocol: AnyObject{
    init(view: СhoiceVisitDateProtocol, networkService:ApiСhoiceVisitDateProtocol, ruter:LoginRouterProtocol,serviceCheck: [Price]?,clientCheck: Client?)
    func puchConfirm()

    }

class СhoiceVisitDatePresenter: СhoiceVisitDatePresenterProtocol{
       
    weak var view: СhoiceVisitDateProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiСhoiceVisitDateProtocol!
    var serviceCheck: [Price]?
    var client: Client?

    required init(view: СhoiceVisitDateProtocol, networkService:ApiСhoiceVisitDateProtocol, ruter:LoginRouterProtocol,serviceCheck: [Price]?,clientCheck: Client?) {
        self.view = view
        self.router = ruter
        self.networkService = networkService
        self.client = clientCheck
        self.serviceCheck = serviceCheck
 
    }
    func puchConfirm(){
        print("puchConfirm",client?.nameClient ?? "")
    }
    
}
