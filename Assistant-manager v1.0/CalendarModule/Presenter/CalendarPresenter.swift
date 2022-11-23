//
//  CalendarPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 29/01/2022.
//

import Foundation

protocol CalendadrViewProtocol: AnyObject {
    func reloadData()
    func updateDataCalendar(update: Bool, indexSetInt: Int)
    func failure(error:Error)
    func alert(message: String)
    func dismiss()
    func openAlertAddInGroup(title: String, message: String)
   
}
protocol CalendadrViewPresenterProtocol: AnyObject {
    init(view: CalendadrViewProtocol, networkService: APIUserDataServiceProtocol,networkServiceStatistic: APiStatistikMoneyServiceProtocol,networkServiceUser: APIGlobalUserServiceProtocol, router: LoginRouterProtocol, user:User?,networkServiceTeam:ApiTeamProtocol)
 
    func getRevenueStatistic(indicatorPeriod: String,completion: @escaping (Double?) -> ())
    func getExpensesStatistic(indicatorPeriod: String,completion: @escaping (Double?) -> ())
    func completeArrayServicesPrices(indexPath:IndexPath,completion: @escaping (_ services:String?,_ prices:String?,_ total:String?) ->())
    func getProfitStatistic(completion: @escaping (Double?) ->())
    func getCalendarDate()
    func getReminders()
    func getStatistic()
    func pushClientsButton()
    func touchAddButoon()
    func pushOptionsButton()
    func pushRecorderClient(indexPath:IndexPath)
    func deletCustomerRecorder(idCustomerRecorder:String,masterId: String)
    func filter(text: String)
    func openClientWithReminder(reminder: Reminder?)
    func reloadData()
    func dataTodayTomorrow()
    func statusCheckUser()
    
    func goToScreen()
    func clinAddInGroup()
    func confirfAdInGroup()
    
    var user: User? { get set }
    var profit: Double? { get set } //прибыль
    var revenueToday: Double? { get set } //выручка
    var expensesToday: Double? { get set } //расходы
    var calendarToday: [CustomerRecord]?{ get set }
    var filterCalendarToday: [CustomerRecord]? { get set }
    var reminders: [Reminder]?{ get set }
    var today: String { get set }
    var tomorrow: String { get set }
   
}
class CalendadrPresentor: CalendadrViewPresenterProtocol {
   
   var user: User?
   var oldUser: User?
   var revenueToday: Double?
   var expensesToday: Double?
   var profit: Double?
   var calendarToday: [CustomerRecord]?
   var filterCalendarToday: [CustomerRecord]?
   var reminders: [Reminder]?
   var today: String {
        didSet{
            print("слушатель var today ")
             reloadData()
        }
    }
   var tomorrow: String
   var team: [Team]
   var idGroupRequest: String!
   var idUserRequest: String!
   var statusInGroupRequest: String!
   weak var view: CalendadrViewProtocol?
   var router: LoginRouterProtocol?
   weak var cell: CalendadrViewProtocol?
   let networkService:APIUserDataServiceProtocol!
   let networkServiceStatistic: APiStatistikMoneyServiceProtocol!
   let networkServiceUser: APIGlobalUserServiceProtocol!
   let networkServiceTeam:ApiTeamProtocol

    required init(view: CalendadrViewProtocol,networkService: APIUserDataServiceProtocol,networkServiceStatistic: APiStatistikMoneyServiceProtocol,networkServiceUser: APIGlobalUserServiceProtocol, router: LoginRouterProtocol,user: User?,networkServiceTeam:ApiTeamProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.networkServiceStatistic = networkServiceStatistic
        self.networkServiceUser = networkServiceUser
        self.networkServiceTeam = networkServiceTeam
        self.user = user
        self.oldUser = user
        self.expensesToday = 0.0
        self.revenueToday = 0.0
        self.profit = 0.0
        self.calendarToday = [CustomerRecord]()
        self.filterCalendarToday = [CustomerRecord]()
        self.today = Date().todayDMYFormat()
        self.tomorrow = Date().tomorrowDMYFormat()
        self.team = [Team]()
        self.reminders = [Reminder]()

        reloadData()
    }
    func confirfAdInGroup(){
      
        networkServiceTeam.addNewTeamUserAfterConfirm(userChief: idUserRequest, newTeamUser: self.user, categoryTeamMember: statusInGroupRequest ,idGroup: idGroupRequest) { [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async { [self] in
                switch result{
                case .success(_):
                     self?.clinAddInGroup()
                     self?.goToScreen()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
    
    
    func goToScreen(){
       
        self.router?.initalScreensaverControler()
        self.view?.dismiss()
    }
    func clinAddInGroup(){
        networkServiceUser.cancelRequestAddTeam{[weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async { [] in
                    switch result{
                    case.success(_):
                        self.idGroupRequest = ""
                        self.idUserRequest = ""
                        self.statusInGroupRequest = ""
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
                print("reloadData2")
                getTeam()
            }
            meQueueStatusCheck.sync {
                print("reloadData3")
                getReminders()
            }
            meQueueStatusCheck.sync {
                print("reloadData4")
                getCalendarDate()
            }
            meQueueStatusCheck.sync {
                print("reloadData5")
                getStatistic()
            }
            meQueueStatusCheck.sync {
                print("reloadData6")
                self.oldUser = self.user
                self.view?.reloadData()
            }
            
        }
    }
    
    
    
    

   
    func reloadData(){
        let meQueue = DispatchQueue(label: "reloadData")
        meQueue.sync {
            getGlobalUser()
           // print("reloadData1")
           // dataTodayTomorrow()
        }
      
        meQueue.sync {
            print("reloadData2")
            getTeam()
        }
        meQueue.sync {
            print("reloadData3")
            getReminders()
        }
        meQueue.sync {
            print("reloadData4")
            getCalendarDate()
        }
        meQueue.sync {
            print("reloadData5")
            getStatistic()
        }
        meQueue.sync {
            print("reloadData6")
            self.view?.reloadData()
        }
     
    }
    func getGlobalUser(){
        print("getGlobalUser")
       
        networkServiceUser.fetchCurrentUser{[weak self] result in
            guard let self = self else {return}
                DispatchQueue.main.async { [self] in
                    switch result{
                    case.success(let user):
                        print("success user")
                       // if user?.statusInGroup != self.user?.statusInGroup {
                        if user?.markerRequest == true {
                            guard user?.idGroupRequest != nil else {return}
                            guard user?.idUserRequest != nil else {return}
                            guard user?.statusInGroupRequest != nil else {return}
                            self.idGroupRequest = user?.idGroupRequest
                            self.idUserRequest = user?.idUserRequest
                            self.statusInGroupRequest = user?.statusInGroupRequest
                            self.view?.openAlertAddInGroup(title: "Request to be added to a group.", message: "Click OK to join the group, click Cancel to ignore this request.")
                        }
                        if self.user?.statusInGroup != user?.statusInGroup && user?.markerRequest == false{
                            self.view?.alert(message: "Your status has changed")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                                self.goToScreen()
                               }
                        }
                   
                    case.failure(let error):
                        self.view?.failure(error: error)
                       
               }
            }
         }
     }
    
    func getTeam(){
        print("getTeam")
        DispatchQueue.main.async{
        self.networkService.getTeam(user: self.user){[weak self] result in
            guard self != nil else {return}
                switch result{
                case .success(let team):
                    self?.team = team ?? [Team]()
                   // self?.getCalendarDate()
                    print("getTeam!")
                
                case .failure(let error):
                   // break
                    self?.view?.failure(error: error)
                }
            }
        }
    }
    func dataTodayTomorrow(){
        print("!!!!dataTodayTomorrow")
        let date = Date()
        self.today = date.todayDMYFormat()
        self.tomorrow = date.tomorrowDMYFormat()
    }
    func getReminders(){
        DispatchQueue.main.async {
            self.networkService.getReminder(user: self.user,date: self.today){[weak self] result in
            guard let self = self else {return}
                    switch result{
                    case.success(let remindersToday):
                        self.reminders? = remindersToday ?? [Reminder]()
                        self.view?.updateDataCalendar(update: true, indexSetInt: 0)
                        print("reminders!")
                    case.failure(let error):
                        self.view?.failure(error: error)
                    }
                }
         }
    }
    func deletCustomerRecorder(idCustomerRecorder:String,masterId: String) {
        DispatchQueue.main.async {
            self.networkService.deletCustomerRecorder(user: self.user,idRecorder: idCustomerRecorder,masterId: masterId){[weak self] result in
            guard let self = self else {return}
                    switch result{
                    case.success(_):
                        self.view?.updateDataCalendar(update: true, indexSetInt: 2)
                    case.failure(let error):
                        self.view?.failure(error: error)
                    }
                }
        }
    }
    func getCalendarDate() {
        print("getCalendarDate")
        DispatchQueue.main.async {
            self.networkService.getCustomerRecord(user: self.user,today: self.today,team: self.team){[weak self] result in
            guard let self = self else {return}
                    switch result{
                    case.success(let filterCalendar):
                        self.calendarToday = filterCalendar
                        self.filterCalendarToday = self.calendarToday
                        self.view?.updateDataCalendar(update: true, indexSetInt: 2)
                        print("getCalendarDate!")
                    case.failure(let error):
                        self.view?.failure(error: error)
                    }
                }
        }
    }
    func getRevenueStatistic(indicatorPeriod: String,completion: @escaping (Double?) -> ()) {
        DispatchQueue.main.async {
            self.networkServiceStatistic.getRevenue(indicatorPeriod: indicatorPeriod){[] result in 
                switch result{
                case.success(let revenueToday):
                    self.revenueToday = revenueToday
                    completion(revenueToday)
                case.failure(let error):
                    self.view?.failure(error: error)
                    
                }
            }
        }
    }
    func getExpensesStatistic(indicatorPeriod: String,completion: @escaping (Double?) -> ()) {
        DispatchQueue.main.async {
            self.networkServiceStatistic.getExpenses(indicatorPeriod: indicatorPeriod){[] result in
                switch result{
                case.success(let expensesToday):
                    self.expensesToday = expensesToday
                    completion(expensesToday)
                case.failure(let error):
                    self.view?.failure(error: error)
                    
                }
            }
        }
    }
    func getProfitStatistic(completion: @escaping (Double?) ->()){
        DispatchQueue.main.async(flags: .barrier) { [  self] in
            guard let revenueToday = self.revenueToday else {
            return
        }
            guard let expensesToday = self.expensesToday else {
            return
        }
        let profit = revenueToday - expensesToday
        completion(profit)
        }
    }
    func getStatistic(){
        DispatchQueue.main.async {
            self.networkServiceStatistic.getRevenue(indicatorPeriod: "today"){[] result in
                switch result{
                case.success(let revenueToday):
                    self.revenueToday = revenueToday
                case.failure(let error):
                    self.view?.failure(error: error)
                }
            }
            self.networkServiceStatistic.getExpenses(indicatorPeriod: "today"){[] result in
                switch result{
                case.success(let expensesToday):
                    self.expensesToday = expensesToday
                case.failure(let error):
                    self.view?.failure(error: error)
                }
        }
            guard let revenueToday = self.revenueToday else {
            return
        }
            guard let expensesToday = self.expensesToday else {
            return
        }
            self.profit = revenueToday - expensesToday
           
      }
    }
    func completeArrayServicesPrices(indexPath:IndexPath,completion: @escaping (_ services:String?,_ prices:String?,_ total:String?) ->()){
         DispatchQueue.main.async {
             var totalSum = [Double]()
             var nameServicesText = ""
             var pricesText = ""
             var totalText = ""
             for (service) in self.filterCalendarToday?[indexPath.row].service ?? [[String : Any]](){
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
    func touchAddButoon(){
        print("touchAddButoon")
        self.router?.showClientsTableViewController(user: self.user, markAddMassageReminder: true)
    }
    func pushClientsButton() {
        print("Push Clients Button")
        self.router?.showClientsTableViewController(user: self.user, markAddMassageReminder: false)
       }
    func pushOptionsButton() {
        print("Push Options Button")
        self.router?.showOptionesViewController(user: self.user)
       }
    func pushRecorderClient(indexPath:IndexPath) {
        guard calendarToday?.isEmpty == false else {return}
        let idClient = (filterCalendarToday?[indexPath.row].idClient ?? "") as String
        DispatchQueue.main.async {
            self.networkService.fetchCurrentClient(user: self.user,idClient: idClient,team: self.team){[weak self] result in
            guard let self = self else {return}
                    switch result{
                    case.success(let client):
                        self.router?.showClientPage(client: client, user: self.user, massage: nil, idReminder: nil, openWithMarkAddMassageReminder: false)
                    case.failure(let error):
                        self.view?.failure(error: error)
                    }
                }
        }
    }
    func filter(text: String) {
        var textFilter = text
        switch textFilter {
        case "today","Today" :
            textFilter = self.today
        case "tomorrow","Tomorrow" :
            textFilter = self.tomorrow
        default:
            textFilter = text
        }
        if textFilter == "" {
            filterCalendarToday = calendarToday?.sorted{ $0.dateTimeStartService < $1.dateTimeStartService } }
        else {
            filterCalendarToday = calendarToday?.filter( {$0.dateTimeStartService.lowercased().contains(textFilter.lowercased()) || $0.fullNameWhoWorks.lowercased().contains(textFilter.lowercased()) || $0.nameWhoWorks.lowercased().contains(textFilter.lowercased()) || $0.nameClient.lowercased().contains(textFilter.lowercased()) || $0.fullNameClient.lowercased().contains(textFilter.lowercased()) } )
        }
        self.view?.updateDataCalendar(update: true, indexSetInt: 2)
    }
    
    func openClientWithReminder(reminder: Reminder?){
        guard let idClient = reminder?.idClient  else {return}
        guard let massage = reminder?.commit  else {return}
        guard let idReminder = reminder?.idReminder  else {return}
        DispatchQueue.main.async {
            self.networkService.getClient(user: self.user,idClient: idClient){[weak self] result in
            guard let self = self else {return}
                    switch result{
                    case.success(let client):
                        self.router?.showClientPage(client: client, user: self.user, massage: massage, idReminder: idReminder, openWithMarkAddMassageReminder: false)
                    case.failure(let error):
                        self.view?.failure(error: error)
                    }
                }
        }
        
        
    }
}
