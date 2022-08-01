//
//  СhoiceVisitDatePresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 11/06/2022.
//

import Foundation
import UIKit

protocol СhoiceVisitDateProtocol: AnyObject{
    func succesForTeamCollection()
    func succesForTableCustomerRecordPast()
    func failure(error: Error)
    func attentionString(error: String)
    }

protocol СhoiceVisitDatePresenterProtocol: AnyObject{
    init(view: СhoiceVisitDateProtocol, networkService:ApiСhoiceVisitDateProtocol, ruter:LoginRouterProtocol,serviceCheck: [Price]?,clientCheck: Client?)
    
    var team: [Team]? {get set}
    var checkMaster: Team? {get set}
    var customerRecordNew: CustomerRecord? {get set}
    var customerRecordPast:[CustomerRecord]? {get set}

    
    func puchConfirm()
    func pressedMastersChoice(indexPath:IndexPath)
    func presedClient(indexPath:IndexPath)
    func dateChanged(senderDate: Date)
    func getDataForTeam()
    func setDataCustomerRecordForMaster(idMaster: String, dateStartServiceDMY: String)
    }

class СhoiceVisitDatePresenter: СhoiceVisitDatePresenterProtocol{
   
    weak var view: СhoiceVisitDateProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiСhoiceVisitDateProtocol!
    
    var customerRecordPast:[CustomerRecord]?
    var team: [Team]?
    var checkMaster: Team?
    var serviceCheck: [Price]?
    var client: Client?
    var customerRecordNew: CustomerRecord?
    
    var idRecord: String!
    var idUserWhoRecorded: String!
    var idUserWhoWorks: String!
    var dateTimeStartService: String!
    var dateTimeEndService: String!
    var dateStartService: String!
    var fullDateTimeStartServiceForFilter: String!
    var idClient: String!
    var genderClient: String!
    var ageClient:Int!
    var commit: String!
    var anUnfulfilledRecord: Bool!
    
    

    required init(view: СhoiceVisitDateProtocol, networkService:ApiСhoiceVisitDateProtocol, ruter:LoginRouterProtocol,serviceCheck: [Price]?,clientCheck: Client?) {
        self.view = view
        self.router = ruter
        self.networkService = networkService
        self.client = clientCheck
        self.serviceCheck = serviceCheck
        getDataForTeam()
    }
    func getDataForTeam(){
        networkService.getTeam{ [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let team):
                    self?.team = team?.sorted{$0.categoryTeamMember > $1.categoryTeamMember}
                    self?.view?.succesForTeamCollection()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
    func setDataCustomerRecordForMaster(idMaster: String, dateStartServiceDMY: String){
        print("загрузить данные для таблицы запись в течении дня для конкретного мастера ")
        networkService.getCustomerRecordPast(idMaster: idMaster, dateStartServiceDMY: dateStartServiceDMY){ [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async{
                switch result{
                case .success(let customerRecord):
                    self?.customerRecordPast = customerRecord?.sorted{$1.dateTimeStartService > $0.dateTimeStartService}
                    self?.view?.succesForTableCustomerRecordPast()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
          }
      }
    }
    
    func puchConfirm(){
        print("puchConfirm",client?.nameClient ?? "")
        
        switch userGlobal?.statusInGroup {
        case "groupEmpty":
            guard
                checkMaster != nil,
                serviceCheck?.isEmpty == false
            else {
                var error = ""
                if serviceCheck?.isEmpty == true {error = error + "Services not selected."+"\n"}
                if checkMaster == nil { error = error + "Master not selected."+"\n"}
                self.view?.attentionString(error: error)
                return
                }
            // если не выбрана дата и время то выбрать сегодня и сейчас
            if dateTimeStartService == nil {
                self.dateTimeStartService = Date().todayDMYTimeFormat()
                self.dateStartService = Date().todayDMYFormat()
                var timeForWork = 0 // min
                for (servic) in serviceCheck! {
                    timeForWork = timeForWork + servic.timeAtWorkMin
                }
                self.dateTimeEndService = Date().addMin(n: timeForWork)
            }
  
            customerRecordNew = CustomerRecord(dictionary: [
                "idUserWhoWorks": userGlobal?.uid ?? "",
                "nameWhoWorks": userGlobal?.name ?? "",
                "fullNameWhoWorks": userGlobal?.fullName ?? "",
                "profileImageWhoWorks": userGlobal?.profileImage ?? "",
                "idClient": client?.idClient ?? "",
                "nameClient": client?.nameClient ?? "",
                "fullNameClient": client?.fullName ?? "",
                "profileImageClient": client?.profileImageClientUrl ?? "",
                "telefonClient": client?.telefonClient ?? "",
                "genderClient": client?.genderClient ?? "",
                "ageClient": client?.ageClient ?? "",
                "dateTimeStartService": dateTimeStartService ?? "",
                "dateTimeEndService": dateTimeEndService ?? "",
                "dateStartService": self.dateStartService ?? ""
            ])
            self.router?.showCustomerVisitRecordConfirmationViewModule(customerVisit: customerRecordNew, master: checkMaster, client: client, services: serviceCheck)
        case "Master":break
        case "Administrator":break
        case "Boss":
            guard
                checkMaster != nil,
                serviceCheck?.isEmpty == false
            else {
                var error = ""
                if serviceCheck?.isEmpty == true {error = error + "Services not selected."+"\n"}
                if checkMaster == nil { error = error + "Master not selected."+"\n"}
                self.view?.attentionString(error: error)
                return
                }
            // если не выбрана дата и время то выбрать сегодня и сейчас
            if dateTimeStartService == nil {
                self.dateTimeStartService = Date().todayDMYTimeFormat()
                self.dateStartService = Date().todayDMYFormat()
                var timeForWork = 0 // min
                for (servic) in serviceCheck! {
                    timeForWork = timeForWork + servic.timeAtWorkMin
                }
                self.dateTimeEndService = Date().addMin(n: timeForWork)
            }
         
            customerRecordNew = CustomerRecord(dictionary: [
                "idUserWhoWorks": checkMaster?.idTeamMember ?? "",
                "nameWhoWorks": checkMaster?.nameTeamMember ?? "",
                "fullNameWhoWorks": checkMaster?.fullnameTeamMember ?? "",
                "profileImageWhoWorks": checkMaster?.profileImageURLTeamMember ?? "",
                "idClient": client?.idClient ?? "",
                "nameClient": client?.nameClient ?? "",
                "fullNameClient": client?.fullName ?? "",
                "profileImageClient": client?.profileImageClientUrl ?? "",
                "telefonClient": client?.telefonClient ?? "",
                "genderClient": client?.genderClient ?? "",
                "ageClient": client?.ageClient ?? "",
                "dateTimeStartService": dateTimeStartService ?? "",
                "dateTimeEndService": dateTimeEndService ?? "",
                "dateStartService": self.dateStartService ?? ""
            ])
            self.router?.showCustomerVisitRecordConfirmationViewModule(customerVisit: customerRecordNew, master: checkMaster, client: client, services: serviceCheck)
        default: break
        }
        
    }
    func pressedMastersChoice(indexPath:IndexPath) {
        print("выбрал мастера кому записывать",indexPath)
        checkMaster = team?[indexPath.row]
        if dateStartService == nil {
            self.dateStartService = Date().todayDMYFormat()
        }
        setDataCustomerRecordForMaster(idMaster: checkMaster?.idTeamMember ?? "", dateStartServiceDMY: dateStartService)
    }
    
    func presedClient(indexPath:IndexPath) {
        print("нажал на запись", indexPath)
    }
    
    func dateChanged(senderDate: Date) {
        self.dateTimeStartService = senderDate.formatterDateDMYHM(date: senderDate)
        self.dateStartService = senderDate.formatterDateDMY(date: senderDate)
        
        var timeForWork = 0 // min
        for (servic) in serviceCheck! {
            timeForWork = timeForWork + servic.timeAtWorkMin
        }
        self.dateTimeEndService = senderDate.addMin(n: timeForWork)
        
        if checkMaster == nil && team?.isEmpty == false {
            checkMaster = team?[0]
        }
        setDataCustomerRecordForMaster(idMaster: checkMaster?.idTeamMember ?? "", dateStartServiceDMY: dateStartService)

    }

  
}
