//
//  ClientsTabPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 12/05/2022.
//

import Foundation
// отправляет сообщение в View о входе  и не входе (аунтификация пользователя)
//outPut
protocol ClientsTabViewProtocol: AnyObject {
 
}

// делаем протокол который завязываемся не на View а на протоколе ViewProtocol и делаем инициализатор которой захватывает ссылку на View принцип  Solid сохряняем уровень абстракции
//inPut
protocol ClientsTabViewPresenterProtocol: AnyObject {

    init(view: ClientsTabViewProtocol,networkService: ApiAllClientsDataServiceProtocol, router: LoginRouterProtocol)
    func goToPageClient(indexPathRowClient:Int)
    

    
}

// заввязываемся на протоколе
class ClientsTabPresentor: ClientsTabViewPresenterProtocol {
   
   weak var view: ClientsTabViewProtocol?
   var router: LoginRouterProtocol?
   let networkService:ApiAllClientsDataServiceProtocol!

    required init(view: ClientsTabViewProtocol,networkService: ApiAllClientsDataServiceProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
 
    }
    func goToPageClient(indexPathRowClient: Int) {
        print("открыть клиента",indexPathRowClient)
        self.router?.showClientPage()
    }
   // let user: User:
   // required init(view: LoginViewProtocol, user: User)
  
}
