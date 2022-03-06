//
//  CalendarPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 29/01/2022.
//

import Foundation

// отправляет сообщение LoginView о входе  и не входе (аунтификация пользователя)
//outPut
protocol CalendadrViewProtocol: AnyObject {
    func successUserData(user: User?)
    func failure(error:Error)
    //func setLoginIndicator(indicator: Bool, error: String)
}

// делаем протокол который завязываемся не на View а на протоколе LoginViewProtocol и делаем инициализатор которой захватывает ссылку на View принцип  Solid сохряняем уровень абстракции
//inPut
protocol CalendadrViewPresenterProtocol: AnyObject {
   // init(view: LoginViewProtocol,user: User)
    init(view: CalendadrViewProtocol,networkService: APIUserDataServiceProtocol,networkServiceStatistic: APiStatistikMoneyServiceProtocol, router: LoginRouterProtocol)
    func getUserData(completion: @escaping (User?) ->())
    func getStatistic(indicatorPeriod: String,completion: @escaping (Double?) -> ())
    var user: User? { get set }
    var proceedsToday: Double? { get set } //выручка
    var expensesToday: Double? { get set } //расходы
}

// заввязываемся на протоколе
class CalendadrPresentor: CalendadrViewPresenterProtocol{
   var user: User?
   var proceedsToday: Double?
   var expensesToday: Double?
    
   weak var view: CalendadrViewProtocol?
   var router: LoginRouterProtocol?
   let networkService:APIUserDataServiceProtocol!
   let networkServiceStatistic: APiStatistikMoneyServiceProtocol!

    required init(view: CalendadrViewProtocol,networkService: APIUserDataServiceProtocol,networkServiceStatistic: APiStatistikMoneyServiceProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.networkServiceStatistic = networkServiceStatistic

     //   getStatistic()
       
    }
    func getStatistic(indicatorPeriod: String,completion: @escaping (Double?) -> ()) {
        DispatchQueue.main.async {
            self.networkServiceStatistic.getRevenue(indicatorPeriod: indicatorPeriod){[] result in 
                switch result{
                case.success(let proceedsToday):
                    self.proceedsToday = proceedsToday
                   // self.view?.successUserData(user: user)
                    completion(proceedsToday)
                case.failure(let error):
                    self.view?.failure(error: error)
                    
                }
                
            }
                
        }
        
        
        
    
        
   
  }
  //  func getStatistic(){
  //      DispatchQueue.main.async {
  //      self.networkServiceStatistic.getProceedsToday()
  //      self.expensesToday = self.networkServiceStatistic.expensesToday
  //      }
  //  }
  
    
    func getUserData(completion: @escaping (User?) ->()){
        DispatchQueue.main.async {
            self.networkService.fetchCurrentUser{[weak self] result in
            guard let self = self else {return}
                    switch result{
                    case.success(let user):
                        self.user = user
                       // self.view?.successUserData(user: user)
                        completion(user)
                    case.failure(let error):
                        self.view?.failure(error: error)
                    }
                }
            }
        
    }
    
    
   // let user: User
   // required init(view: LoginViewProtocol, user: User)
  
}
