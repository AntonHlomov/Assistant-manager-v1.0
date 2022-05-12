//
//  OptionesPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 12/05/2022.
//

import Foundation
// отправляет сообщение в View 
//outPut
protocol OptionesViewProtocol: AnyObject {
 
}

// делаем протокол который завязываемся не на View а на протоколе ViewProtocol и делаем инициализатор которой захватывает ссылку на View принцип  Solid сохряняем уровень абстракции
//inPut
protocol OptionesViewPresenterProtocol: AnyObject {

    init(view: OptionesViewProtocol,networkService: APIOptionesDataServiceProtocol, router: LoginRouterProtocol)
    func goToBackTappedViewFromRight()

}

// заввязываемся на протоколе
class OptionesViewPresentor: OptionesViewPresenterProtocol {
  
   weak var view: OptionesViewProtocol?
   var router: LoginRouterProtocol?
   let networkService:APIOptionesDataServiceProtocol!

    required init(view: OptionesViewProtocol,networkService: APIOptionesDataServiceProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
 
    }
    
    func goToBackTappedViewFromRight() {
        router?.backTappedFromRight()
    }

}

