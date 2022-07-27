//
//  CalendarPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 29/01/2022.
//

import Foundation

// отправляет сообщение в View о входе  и не входе (аунтификация пользователя)
//outPut
protocol CalendadrViewProtocol: AnyObject {
    func successUserData(user: User?)
    func updateDataCalendar(update: Bool, indexSetInt: Int)
    func failure(error:Error)
}

// делаем протокол который завязываемся не на View а на протоколе ViewProtocol и делаем инициализатор которой захватывает ссылку на View принцип  Solid сохряняем уровень абстракции
//inPut
protocol CalendadrViewPresenterProtocol: AnyObject {

    init(view: CalendadrViewProtocol,networkService: APIUserDataServiceProtocol,networkServiceStatistic: APiStatistikMoneyServiceProtocol, router: LoginRouterProtocol)
    
   // func getUserData(completion: @escaping (User?) ->())
    func getUserData()
    func getRevenueStatistic(indicatorPeriod: String,completion: @escaping (Double?) -> ())
    func getExpensesStatistic(indicatorPeriod: String,completion: @escaping (Double?) -> ())
    func completeArrayServicesPrices(indexPath:IndexPath,completion: @escaping (_ services:String?,_ prices:String?,_ total:String?) ->())
    func getProfitStatistic(completion: @escaping (Double?) ->())
    func getCalendarDate()
    func getStatistic()
    func pushClientsButton()
    func pushOptionsButton()
    func pushRecorderClient(indexPath:IndexPath)
    func deletCustomerRecorder(idCustomerRecorder:String)
    func filter(text: String)
    
    var user: User? { get set }
    var profit: Double? { get set } //прибыль
    var revenueToday: Double? { get set } //выручка
    var expensesToday: Double? { get set } //расходы
    var calendarToday: [CustomerRecord]?{ get set }
    var filterCalendarToday: [CustomerRecord]? { get set }
    var today: String { get set }
    var tomorrow: String { get set }
}

// заввязываемся на протоколе
class CalendadrPresentor: CalendadrViewPresenterProtocol {
   
    
  
   var user: User?
   var revenueToday: Double?
   var expensesToday: Double?
   var profit: Double?
   var calendarToday: [CustomerRecord]?
   var filterCalendarToday: [CustomerRecord]?
   var today: String
   var tomorrow: String
   var team: [Team]
    
   weak var view: CalendadrViewProtocol?
   var router: LoginRouterProtocol?
   let networkService:APIUserDataServiceProtocol!
   let networkServiceStatistic: APiStatistikMoneyServiceProtocol!

    required init(view: CalendadrViewProtocol,networkService: APIUserDataServiceProtocol,networkServiceStatistic: APiStatistikMoneyServiceProtocol, router: LoginRouterProtocol) {
        
        self.view = view
        self.router = router
        self.networkService = networkService
        self.networkServiceStatistic = networkServiceStatistic
        self.expensesToday = 0.0
        self.revenueToday = 0.0
        self.profit = 0.0
        self.calendarToday = [CustomerRecord]()
        self.filterCalendarToday = [CustomerRecord]()
        self.today = ""
        self.tomorrow = ""
        self.team = [Team]()
        
      
       
        getTeam()
        dataTodayTomorrow()
        getUserData()
      //  getCalendarDate()
    }
    
  
    func getTeam(){
        print("getTeam")
        DispatchQueue.global(qos: .utility).async {
        self.networkService.getTeam{ [weak self] result in
            guard self != nil else {return}
           
                switch result{
                case .success(let team):
                    self?.team = team ?? [Team]()
                    self?.getCalendarDate()
                    print("getTeam!")
                case .failure(_): break
                   // self?.view?.failure(error: error)
                }
          }
        }
        
    }
    func dataTodayTomorrow(){
        print("dataTodayTomorrow")
        let date = Date()
        self.today = date.todayDMYFormat()
        self.tomorrow = date.tomorrowDMYFormat()
    }
    
    
    func deletCustomerRecorder(idCustomerRecorder:String) {
        DispatchQueue.main.async {
            self.networkService.deletCustomerRecorder(idRecorder: idCustomerRecorder){[weak self] result in
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
       // let today = Date().todayDMYFormat()
        DispatchQueue.main.async {
            self.networkService.getCustomerRecord(today: self.today,team: self.team ){[weak self] result in
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
    
   // func getUserData(completion: @escaping (User?) ->()){
   //     DispatchQueue.main.async {
   //         self.networkService.fetchCurrentUser{[weak self] result in
   //         guard let self = self else {return}
   //                 switch result{
   //                 case.success(let user):
   //                     self.user = user
   //                     completion(user)
   //                 case.failure(let error):
   //                     self.view?.failure(error: error)
   //                 }
   //             }
   //     }
   // }
    func getUserData(){
        print("getUserData")
        DispatchQueue.main.async {
            self.networkService.fetchCurrentUser{[weak self] result in
            guard let self = self else {return}
                    switch result{
                    case.success(let user):
                        self.user = user
                        self.view?.updateDataCalendar(update: true, indexSetInt: 0)
                    case.failure(let error):
                        self.view?.failure(error: error)
                    }
                }
        }
    }
    func pushClientsButton() {
        print("Push Clients Button")
        self.router?.showClientsTableViewController()
       }
    
    func pushOptionsButton() {
        print("Push Options Button")
        self.router?.showOptionesViewController(user: self.user)
       }
    func pushRecorderClient(indexPath:IndexPath) {
        let idClient = (calendarToday?[indexPath.row].idClient ?? "") as String
        DispatchQueue.main.async {
            self.networkService.fetchCurrentClient(idClient: idClient){[weak self] result in
            guard let self = self else {return}
                    switch result{
                    case.success(let client):
                        self.router?.showClientPage(client: client)
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
    
    
   // let user: User
   // required init(view: LoginViewProtocol, user: User)
  
}
