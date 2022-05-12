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
    func failure(error:Error)
   
}

// делаем протокол который завязываемся не на View а на протоколе ViewProtocol и делаем инициализатор которой захватывает ссылку на View принцип  Solid сохряняем уровень абстракции
//inPut
protocol CalendadrViewPresenterProtocol: AnyObject {

    init(view: CalendadrViewProtocol,networkService: APIUserDataServiceProtocol,networkServiceStatistic: APiStatistikMoneyServiceProtocol, router: LoginRouterProtocol)
    
    func getUserData(completion: @escaping (User?) ->())
    func getRevenueStatistic(indicatorPeriod: String,completion: @escaping (Double?) -> ())
    func getExpensesStatistic(indicatorPeriod: String,completion: @escaping (Double?) -> ())
    func getProfitStatistic(completion: @escaping (Double?) ->())
    func getStatistic()
    func pushClientsButton()
    func pushOptionsButton()
    
    var user: User? { get set }
    var profit: Double? { get set } //прибыль
    var revenueToday: Double? { get set } //выручка
    var expensesToday: Double? { get set } //расходы
   
}

// заввязываемся на протоколе
class CalendadrPresentor: CalendadrViewPresenterProtocol {
    
   var user: User?
   var revenueToday: Double?
   var expensesToday: Double?
   var profit: Double?
    
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
    
    func getUserData(completion: @escaping (User?) ->()){
        DispatchQueue.main.async {
            self.networkService.fetchCurrentUser{[weak self] result in
            guard let self = self else {return}
                    switch result{
                    case.success(let user):
                        self.user = user
                        completion(user)
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
        self.router?.showOptionesViewController()
       }
    
    
   // let user: User
   // required init(view: LoginViewProtocol, user: User)
  
}
