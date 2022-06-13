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
    func pressedMastersChoice()
    func presedClient()
    func dateChanged()

    }

class СhoiceVisitDatePresenter: СhoiceVisitDatePresenterProtocol{
   
    weak var view: СhoiceVisitDateProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiСhoiceVisitDateProtocol!
    
    var customerRecordPast:[CustomerRecord]?
    var team: [Team]?
    var serviceCheck: [Price]?
    var client: Client?
    var newCustomerRecordPast:[CustomerRecord]?

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
    func pressedMastersChoice() {
        print("выбрал мастера кому записывать")
    }
    
    func presedClient() {
        print("нажал на мастера")
    }
    
    func dateChanged() {
        print("выбор даты и времени для записи")
    }
    
}
