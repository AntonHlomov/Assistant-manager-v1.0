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
    func failure(error: Error)
}

protocol СhoiceVisitDatePresenterProtocol: AnyObject{
    init(view: СhoiceVisitDateProtocol, networkService:ApiСhoiceVisitDateProtocol, ruter:LoginRouterProtocol,serviceCheck: [Price]?,clientCheck: Client?)
    
    var team: [Team]? {get set}
    var checkMaster: Team? {get set}
    var customerRecordNew: CustomerRecord? {get set}
    
    func puchConfirm()
    func pressedMastersChoice(indexPath:IndexPath)
    func presedClient(indexPath:IndexPath)
    func dateChanged(senderDate: Date)
    func getDataForTeam()
    func setDataCustomerRecordForMaster()
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
    var fullDateTimeStartServiceForFilter: String!
    var idClient: String!
    var genderClient: String!
    var ageClient:Int!
    var periodNextRecord: String!
    var commit: String!
   // var allServiceCheck: [Price]!
    var anUnfulfilledRecord: Bool!

    required init(view: СhoiceVisitDateProtocol, networkService:ApiСhoiceVisitDateProtocol, ruter:LoginRouterProtocol,serviceCheck: [Price]?,clientCheck: Client?) {
        self.view = view
        self.router = ruter
        self.networkService = networkService
        self.client = clientCheck
        self.serviceCheck = serviceCheck
      
        
        getDataForTeam()
        setDataCustomerRecordForMaster()
 
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
    func setDataCustomerRecordForMaster(){
        print("загрузить данные для таблицы запись в течении дня для конкретного мастера ")
    }
    func puchConfirm(){
        print("puchConfirm",client?.nameClient ?? "")
   
        self.router?.showCustomerVisitRecordConfirmationViewModule(customerVisit: customerRecordNew, master: checkMaster, client: client, services: serviceCheck)
    }
    func pressedMastersChoice(indexPath:IndexPath) {
        print("выбрал мастера кому записывать",indexPath)
        print("загрузить данные для таблицы (запись в течении дня) для мастера:",indexPath.row)
        checkMaster = team?[indexPath.row]
    }
    
    func presedClient(indexPath:IndexPath) {
        print("нажал на запись", indexPath)
    }
    
    func dateChanged(senderDate: Date) {
        print("выбор даты и времени для записи")
        let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
        let dateFormatterYar = DateFormatter()
        dateFormatterYar.dateFormat = "YYYY-MM-dd"
        let dateFormatterM = DateFormatter()
        dateFormatterM.dateFormat = "MM"
        print("Дата записи начала работы с клиентом в календарь \(dateFormatter.string(from: senderDate))")
        print("Дата записи начала работы с клиентом в календарь \(senderDate)")
        
        customerRecordNew?.dateTimeStartService.append(dateFormatter.string(from: senderDate))
       
      
        
    }
    
}
