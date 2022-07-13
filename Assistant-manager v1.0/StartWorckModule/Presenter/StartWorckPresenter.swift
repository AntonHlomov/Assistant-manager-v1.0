//
//  StartWorckPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 19/02/2022.
//

import Foundation

protocol StartWorckViewProtocol: AnyObject {
    func success()
    func updateDataCustomerRecord(update: Bool, indexSetInt: Int)
    func failure(error:Error)
}
protocol StartWorckViewPresenterProtocol: AnyObject {
    init(view: StartWorckViewProtocol,router: LoginRouterProtocol,networkService: ApiCustomerCardPaymentTodayProtocol)
    func data()
    func getCustomerRecord()
    func getDataForTeam()
    func filter(text: String)
    func deletCustomerRecorder(idCustomerRecorder:String)
 //   func pressedMastersChoice(indexPath:IndexPath) 
    var customersCardsPayment: [CustomerRecord]?{ get set }
    var filterCustomersCardsPayment: [CustomerRecord]? { get set }
    var team: [[Team]]? {get set}
    var checkMaster: Team? {get set}
    
}

class StartWorckPresentor: StartWorckViewPresenterProtocol{
  
    weak var view: StartWorckViewProtocol?
    var router: LoginRouterProtocol?
    let networkService: ApiCustomerCardPaymentTodayProtocol!
    var customersCardsPayment: [CustomerRecord]?
    var filterCustomersCardsPayment: [CustomerRecord]?
    var team: [[Team]]?
    var checkMaster: Team?
    
    
    required init(view: StartWorckViewProtocol, router: LoginRouterProtocol,networkService: ApiCustomerCardPaymentTodayProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.customersCardsPayment = [CustomerRecord]()
        self.filterCustomersCardsPayment = [CustomerRecord]()
        self.team = [[Team]]()
       
        getDataForTeam()
        
    }
    func deletCustomerRecorder(idCustomerRecorder:String) {
        let idMaster = checkMaster?.idTeamMember ?? ""
        DispatchQueue.main.async {
            self.networkService.deletCustomerRecorder(idRecorder: idCustomerRecorder,idMaster: idMaster){[weak self] result in
            guard let self = self else {return}
                    switch result{
                    case.success(_):
                        self.view?.updateDataCustomerRecord(update: true, indexSetInt: 2)
                    case.failure(let error):
                        self.view?.failure(error: error)
                    }
                }
        }
    }

    func filter(text: String) {
        let textFilter = text
        
        if textFilter == "" {
            filterCustomersCardsPayment = customersCardsPayment?.sorted{ $0.dateTimeStartService < $1.dateTimeStartService } }
        else {
            filterCustomersCardsPayment = customersCardsPayment?.filter( {$0.dateTimeStartService.lowercased().contains(textFilter.lowercased()) || $0.nameClient.lowercased().contains(textFilter.lowercased()) || $0.fullNameClient.lowercased().contains(textFilter.lowercased()) } )
        }
        self.view?.updateDataCustomerRecord(update: true, indexSetInt: 2)
    }
    
    func getDataForTeam(){
        networkService.getTeam{ [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let team):
                   let t = team?.sorted{$0.categoryTeamMember > $1.categoryTeamMember}
                    self?.team?.append(t ?? [Team]())
                    self?.view?.updateDataCustomerRecord(update: true, indexSetInt: 0)
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
    func getCustomerRecord(){
        let date = Date()
        let today = date.todayDMYFormat()
        let idCheckMaster = self.checkMaster?.idTeamMember ?? ""
      //  if self.checkMaster != nil {
      //      idCheckMaster = self.checkMaster?.idTeamMember ?? ""
      //  }
 
        DispatchQueue.main.async {
            self.networkService.getCustomerRecord(masterId: idCheckMaster ,today: today){[weak self] result in
            guard let self = self else {return}
                    switch result{
                    case.success(let filterCalendar):
                        self.customersCardsPayment = filterCalendar
                        self.filterCustomersCardsPayment = self.customersCardsPayment
                        self.view?.updateDataCustomerRecord(update: true, indexSetInt: 2)
                    case.failure(let error):
                        self.view?.failure(error: error)
                    }
                }
        }
    }
  
    func data(){
        
    }
}

