//
//  CustomerVisitRecordConfirmationViewPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/06/2022.
//

import Foundation

protocol CustomerVisitRecordConfirmationViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol CustomerVisitRecordConfirmationViewPresenterProtocol: AnyObject {
    init(view: CustomerVisitRecordConfirmationViewProtocol,networkService: APICustomerVisitRecordConfirmationProtocol, router: LoginRouterProtocol,customerVisit: CustomerRecord?)
    func saveCustomerVisit()
}

class CustomerVisitRecordConfirmationViewPresenter: CustomerVisitRecordConfirmationViewPresenterProtocol {
   
   weak var view: CustomerVisitRecordConfirmationViewProtocol?
   var router: LoginRouterProtocol?
   let networkService:APICustomerVisitRecordConfirmationProtocol!
   var customerVisit: CustomerRecord?
    
    required init(view: CustomerVisitRecordConfirmationViewProtocol,networkService: APICustomerVisitRecordConfirmationProtocol, router: LoginRouterProtocol, customerVisit: CustomerRecord?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.customerVisit = customerVisit
 
    }
    func saveCustomerVisit() {
        print("отправить через  api запись клиента")
    }
}
