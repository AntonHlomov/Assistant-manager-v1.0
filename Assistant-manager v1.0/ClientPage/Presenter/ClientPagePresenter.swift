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
    func massageReminder(massge: String)
    func changeVisitDates(indicatorVisits: Bool)
    func changeReminder(indicatorReminder: Bool)
    func changeVisitStatisyc(countVisits: String)
    func changeFinansStatisyc(countAverageBill: String)
    func changeGoToWorck(indicatorWorck: Bool)
    func openAlertOk(message:String)
    func enteringAreminder()
    func reloadColection()
    
}
 
protocol ClientPagePresenterProtocol: AnyObject{
    init(view: ClientPageProtocol,networkService:ApiAllClientPageServiceProtocol, networkServiceTeam:ApiTeamProtocol, router:LoginRouterProtocol, client: Client?,user: User?,massage: String?,idReminder:String?,openWithMarkAddMassageReminder: Bool)
    func setClient()
    func pressСlientInvitationButton()
    func pressСallButton()
    func goToVisitStatisyc()
    func goToFinansStatisyc()
    func goToWorck()
    func visitDates()
    func reminder(text:String,date:Date)
    func checkIndicatorGoToWorck()
    func checkIndicatorVisitDates()
    func checkIndicatorReminder()
    func checkIndicatorVisitStatisyc()
    func checkIndicatorFinansStatisyc()
    var user: User? {get set}
    func massageClientReminder()
    func deleteReminder()
    var team: [Team]? {get set}
    func getTeam()
    var idUserWhoIsTheMessage: String!{get set}
}

class ClientPagePresenter: ClientPagePresenterProtocol{
  
    weak var view: ClientPageProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiAllClientPageServiceProtocol!
    let networkServiceTeam:ApiTeamProtocol!
    var client: Client?
    var user: User?
    var massage: String?
    var idReminder: String?
    var openWithMarkAddMassageReminder: Bool
    var team: [Team]?
    var idUserWhoIsTheMessage: String!
    
    required init(view: ClientPageProtocol,networkService:ApiAllClientPageServiceProtocol, networkServiceTeam:ApiTeamProtocol, router:LoginRouterProtocol, client: Client?, user: User?, massage: String?,idReminder:String?,openWithMarkAddMassageReminder: Bool) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.networkServiceTeam = networkServiceTeam
        self.client = client
        self.user = user
        self.massage = massage
        self.idReminder = idReminder
        self.openWithMarkAddMassageReminder = openWithMarkAddMassageReminder
        setClient()
        
        
    }
    func getTeam(){
        networkServiceTeam.getTeam(user: self.user){ [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let team):
                    print("3")
                    self?.team = team
                    self?.view?.reloadColection()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
    func deleteReminder(){
           guard let idReminderForDel = idReminder else {return}
        networkService.deleteReminder(user: user, idReminder: idReminderForDel)  { [weak self] result in
            guard let self = self else {return}
           
            DispatchQueue.main.async {
                switch result{
                case.success(let flag):
                    guard flag == true else {return}
                    self.view?.openAlertOk(message: "Reminder removed")
                case.failure(let error):
                    self.view?.failure(error: error)
                }
            }
            
        }
    }
    func massageClientReminder(){
        if openWithMarkAddMassageReminder == true {
            self.view?.enteringAreminder()
        }
        if openWithMarkAddMassageReminder == false {
            guard massage != nil else{return}
            guard massage != "" else {return}
            self.view?.massageReminder(massge: massage ?? "")
        }
    }
    func setClient() {
        self.view?.setClient(client: client)
    }
    func pressСlientInvitationButton() {
        print("pressСlientInvitationButton")
        self.router?.showPrice(newVisitMode: true, client: client, user: self.user)
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
    func reminder(text:String,date:Date){
        guard let idClient = client?.idClient else {return}
        guard let nameClient = client?.nameClient else {return}
        guard let fulnameClient = client?.fullName else {return}
        guard let urlImage = client?.profileImageClientUrl else {return}
        let dateDMY = date.formatterDateDMY(date: date)
        var userWhoIsTheMessage = ""
        
        switch user?.statusInGroup {
        case "Individual","Master":
            guard let id = self.user?.uid else {return}
            userWhoIsTheMessage =  id
    
        case "Administrator","Boss":
            userWhoIsTheMessage = self.idUserWhoIsTheMessage
           
        default: return
        }
        
    
     //   guard let idPrice = price?.idPrice else {return}
        networkService.addReminder(text: text, date: dateDMY, user: self.user,nameClient:nameClient,fulnameClient:fulnameClient,urlImage: urlImage, userReminder: true, sistemReminderColl: false, sistemReminderPeriodNextRecord: false, idClient: idClient, idUserWhoIsTheMessage: userWhoIsTheMessage) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result{
                case.success(let flag):
                    guard flag == true else {return}
                    self.view?.openAlertOk(message: "Reminder saved")
                case.failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
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
        self.view?.changeVisitStatisyc(countVisits: "0")
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
