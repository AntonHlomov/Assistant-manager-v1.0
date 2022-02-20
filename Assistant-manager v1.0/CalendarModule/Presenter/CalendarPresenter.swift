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

// делаем протокол который завязываемся не на View а нв протоколе LoginViewProtocol и делаем инициализатор которой захватывает ссылку на View принцип  Solid сохряняем уровень абстракции
//inPut
protocol CalendadrViewPresenterProtocol: AnyObject {
   // init(view: LoginViewProtocol,user: User)
    init(view: CalendadrViewProtocol,networkService: APIUserDataServiceProtocol, router: LoginRouterProtocol)
    func getUserData(completion: @escaping (User?) ->())
    var user: User? { get set }
}

// заввязываемся на протоколе
class CalendadrPresentor: CalendadrViewPresenterProtocol{
    var user: User?
      
   weak var view: CalendadrViewProtocol?
   var router: LoginRouterProtocol?
   let networkService:APIUserDataServiceProtocol!

    required init(view: CalendadrViewProtocol,networkService: APIUserDataServiceProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
       
    }
    
  //  func getUserData(completion: @escaping (User?) ->()){
    func getUserData(completion: @escaping (User?) ->()){
        DispatchQueue.main.async {
            self.networkService.fetchCurrentUser{[weak self] result in
            guard let self = self else {return}
                    switch result{
                    case.success(let user):
                        self.view?.successUserData(user: user)
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
