//
//  ClientPagePresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 29/05/2022.
//

import Foundation
import UIKit

protocol ClientPageProtocol: AnyObject {
    func setClient(client: Client?)
    func failure(error: Error)
    func changeVisitDates(indicatorVisits: Bool)
    func changeReminder(indicatorReminder: Bool)
    func changeVisitStatisyc(countVisits: String)
    func changeFinansStatisyc(countAverageBill: String)
    func changeGoToWorck(indicatorWorck: Bool)
    
}
 
protocol ClientPagePresenterProtocol: AnyObject{
    init(view: ClientPageProtocol,networkService:ApiAllClientPageServiceProtocol, router:LoginRouterProtocol, client: Client?)
    func setClient()
    func pressСlientInvitationButton()
    func pressСallButton()
    func goToVisitStatisyc()
    func goToFinansStatisyc()
    func goToWorck()
    func visitDates()
    func reminder()
    func checkIndicatorGoToWorck()
    func checkIndicatorVisitDates()
    func checkIndicatorReminder()
    func checkIndicatorVisitStatisyc()
    func checkIndicatorFinansStatisyc()
   
}

class ClientPagePresenter: ClientPagePresenterProtocol{
  
    weak var view: ClientPageProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiAllClientPageServiceProtocol!
    var client: Client?
    
    required init(view: ClientPageProtocol,networkService:ApiAllClientPageServiceProtocol, router:LoginRouterProtocol, client: Client?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.client = client
        setClient()
    }
    func setClient() {
        self.view?.setClient(client: client)
    }
    func pressСlientInvitationButton() {
        print("pressСlientInvitationButton")
        self.router?.showPrice(newVisitMode: true, client: client)
    }
    
    func pressСallButton() {
        print("pressСallButton")
        guard let numberPhone = client?.telefonClient else {return}
        if let phoneCallURL = URL(string: "telprompt://\(numberPhone))") {
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
          }
        }
    }
    func goToVisitStatisyc() {
        print("goToVisitStatisyc")
    }
       
    func goToFinansStatisyc() {
        print("goToFinansStatisyc")
    }
    func goToWorck(){
        print("goToWorck")
    }
    func visitDates(){
        print("visitDates")
    }
    func reminder(){
        print("reminder")
    }
    
    func checkIndicatorVisitDates() {
        print("checkIndicatorVisitDates")
        self.view?.changeVisitDates(indicatorVisits: true)
    }
    
    func checkIndicatorReminder() {
        print("checkIndicatorReminder")
        self.view?.changeReminder(indicatorReminder: true)
    }
    
    func checkIndicatorVisitStatisyc() {
        print("checkIndicatorVisitStatisyc")
        self.view?.changeVisitStatisyc(countVisits: "22")
    }
    
    func checkIndicatorFinansStatisyc() {
        print("checkIndicatorFinansStatisyc")
        guard let countVisits = client?.countVisits else {return}
        guard countVisits != 0 else {return}
        guard let sumTotal = client?.sumTotal else {return}
        let result = String(Int(sumTotal)/countVisits )
        self.view?.changeFinansStatisyc(countAverageBill: result)
    }
    func checkIndicatorGoToWorck() {
        print("checkIndicatorGoToWorck")
        self.view?.changeGoToWorck(indicatorWorck: true)
    }
    
}
