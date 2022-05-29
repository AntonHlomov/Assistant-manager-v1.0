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
    func pressСlientInvitationButton(idClient: String)
    func pressСallButton(idClient: String)
    func goToVisitStatisyc(idClient: String)
    func goToFinansStatisyc(idClient: String)
    func goToWorck(idClient: String)
    func visitDates(idClient: String)
    func reminder(idClient: String)
   
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
    func pressСlientInvitationButton(idClient: String) {
        print("pressСlientInvitationButton",idClient)
    }
    
    func pressСallButton(idClient: String) {
        print("pressСallButton",idClient)
    }
    func goToVisitStatisyc(idClient: String) {
        print("goToVisitStatisyc",idClient)
    }
       
    func goToFinansStatisyc(idClient: String) {
        print("goToFinansStatisyc",idClient)
    }
    func goToWorck(idClient: String){
        print("goToWorck",idClient)
    }
    func visitDates(idClient: String){
        print("visitDates",idClient)
    }
    func reminder(idClient: String){
        print("reminder",idClient)
    }
    
}
