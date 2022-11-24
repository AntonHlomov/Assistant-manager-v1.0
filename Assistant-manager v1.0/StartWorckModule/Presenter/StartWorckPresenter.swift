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
    init(view: StartWorckViewProtocol,router: LoginRouterProtocol,networkService: ApiCustomerCardPaymentTodayProtocol,user: User?,networkServiceTeam: ApiTeamProtocol,networkServiceUser: APIGlobalUserServiceProtocol)
    func statusCheckUser()
    func data()
    func getCustomerRecord()
    func getDataForTeam()
    func filter(text: String)
    func deletCustomerRecorder(idCustomerRecorder:String)
 //   func pressedMastersChoice(indexPath:IndexPath)
    func pushPayClient(indexPath: IndexPath)
    var customersCardsPayment: [CustomerRecord]?{ get set }
    var filterCustomersCardsPayment: [CustomerRecord]? { get set }
    var team: [[Team]]? {get set}
    var checkMaster: Team? {get set}
    func completeArrayServicesPrices(indexPath:IndexPath,completion: @escaping (_ services:String?,_ prices:String?,_ total:String?) ->())
    
}

class StartWorckPresentor: StartWorckViewPresenterProtocol{
  
    weak var view: StartWorckViewProtocol?
    var router: LoginRouterProtocol?
    let networkService: ApiCustomerCardPaymentTodayProtocol!
    let networkServiceTeam: ApiTeamProtocol!
    let networkServiceUser: APIGlobalUserServiceProtocol!
    var customersCardsPayment: [CustomerRecord]?
    var filterCustomersCardsPayment: [CustomerRecord]?
    var team: [[Team]]?
    var checkMaster: Team?
    var user: User?
    var oldUser: User?
    
    
    required init(view: StartWorckViewProtocol, router: LoginRouterProtocol,networkService: ApiCustomerCardPaymentTodayProtocol,user: User?,networkServiceTeam: ApiTeamProtocol,networkServiceUser: APIGlobalUserServiceProtocol) {
        
        self.view = view
        self.router = router
        self.networkService = networkService
        self.networkServiceTeam = networkServiceTeam
        self.networkServiceUser = networkServiceUser
        self.customersCardsPayment = [CustomerRecord]()
        self.filterCustomersCardsPayment = [CustomerRecord]()
        self.team = [[Team]]()
        self.user = user
        self.oldUser = user
       
        reloadData()
    }
    
    func reloadData(){
        let meQueue = DispatchQueue(label: "reloadDataStartWorck")
        meQueue.sync {
            getGlobalUser()
        }
      
        meQueue.sync {
            print("reloadData2")
            getDataForTeam()
        }
        meQueue.sync {
            print("reloadData6")
            //self.view?.reloadData()
        }
    }
    
    func getGlobalUser(){
        print("getGlobalUser")
       
        networkServiceUser.fetchCurrentUser{[weak self] result in
            guard let self = self else {return}
                DispatchQueue.main.async {
                    switch result{
                    case.success(let user):
                        if user?.statusInGroup != self.user?.statusInGroup {
                          //  self.view?.alert(message: "Вы писоеденины к группе. Обновление.CalendarPresenter.getGlobalUser...")
                            self.user = user
                        }
                       break
                    case.failure(let error):
                        self.view?.failure(error: error)
               }
            }
         }
     }
    
    func statusCheckUser(){
        if self.user?.statusInGroup == self.oldUser?.statusInGroup{
            print("неизменился statusInGroup")
        } else{
            let meQueueStatusCheck = DispatchQueue(label: "statusCheckUserReloadData")
           
            meQueueStatusCheck.sync {
                print("getDataForTeam")
                getDataForTeam()
            }
            meQueueStatusCheck.sync {
                print("reloadData6")
                self.oldUser = self.user
               // self.view?.reloadData()
            }
            
        }
    }
    
    func completeArrayServicesPrices(indexPath:IndexPath,completion: @escaping (_ services:String?,_ prices:String?,_ total:String?) ->()){
         DispatchQueue.main.async {
             var totalSum = [Double]()
             var nameServicesText = ""
             var pricesText = ""
             var totalText = ""
             
             for (service) in self.filterCustomersCardsPayment?[indexPath.row].service ?? [[String : Any]](){
                let name: String = service["nameServise"] as! String
                let nameDrop = name.prefix(14)
           
                let price: String = String(service["priceServies"] as! Double)
                totalSum.append( service["priceServies"] as! Double )
                 
                    if nameServicesText == "" {
                        nameServicesText = nameDrop.capitalized
                        pricesText = price
                    } else {
                        nameServicesText =  nameServicesText.capitalized + ("\n") + nameDrop.capitalized
                        pricesText =  pricesText + ("\n") + price
                    }
                }
             totalText = String(totalSum.compactMap { Double($0) }.reduce(0, +))
             
             completion(nameServicesText,pricesText, totalText)
         }
     }
    
    func pushPayClient(indexPath: IndexPath){
        guard filterCustomersCardsPayment?.isEmpty == false else {return}
        
        let clientWhoPay = filterCustomersCardsPayment?[indexPath.row]
        let masterWhoWork = checkMaster
        self.router?.showPaymentController(customerRecordent: clientWhoPay, master: masterWhoWork, user: self.user)
    }
    
    func deletCustomerRecorder(idCustomerRecorder:String) {
        let idMaster = checkMaster?.idTeamMember ?? ""
        DispatchQueue.main.async {
            self.networkService.deletCustomerRecorder(idRecorder: idCustomerRecorder,idMaster: idMaster,user: self.user){[weak self] result in
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
        switch user?.statusInGroup {
        case "Individual":
            var masterUserArray = [Team]()
            let masterUser = Team(dictionary: [
                "id": user?.uid ?? "",
                "categoryTeamMember": user?.statusInGroup ?? "",
                "idTeamMember": user?.uid ?? "",
                "nameTeamMember": user?.name ?? "",
                "fullnameTeamMember": user?.fullName ?? "",
                "profileImageURLTeamMember": user?.profileImage ?? ""
            ])
            self.team?.removeAll()
            masterUserArray.append(masterUser)
            self.team?.append(masterUserArray)
        case "Master":
            networkServiceTeam.getTeam(user: self.user){ [weak self] result in
                guard self != nil else {return}
                DispatchQueue.main.async { [self] in
                    switch result{
                    case .success(let team):
                        let sortedTeam = team?.filter{ $0.idTeamMember == self?.user?.uid }
                        self?.team?.append(sortedTeam ?? [Team]())
                    case .failure(let error):
                        self?.view?.failure(error: error)
                    }
                }
            }
       
        case "Administrator","Boss":
        networkServiceTeam.getTeam(user: self.user){ [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let team):
                    let sortedTeam = team?.sorted{$0.categoryTeamMember > $1.categoryTeamMember}
                   // self?.team?.removeAll()
                    self?.team?.append(sortedTeam ?? [Team]())
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }

        default: break
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
            self.networkService.getCustomerRecord(masterId: idCheckMaster ,today: today, user: self.user){[weak self] result in
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

