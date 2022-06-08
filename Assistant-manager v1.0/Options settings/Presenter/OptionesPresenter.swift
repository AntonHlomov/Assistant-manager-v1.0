//
//  OptionesPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 12/05/2022.
//

import Foundation
import UIKit
// отправляет сообщение в View 
//outPut
protocol OptionesViewProtocol: AnyObject {
    func succesForAlert(title: String, message: String)
    func succes()
    func failure(error: Error)
 
}

// делаем протокол который завязываемся не на View а на протоколе ViewProtocol и делаем инициализатор которой захватывает ссылку на View принцип  Solid сохряняем уровень абстракции
//inPut
protocol OptionesViewPresenterProtocol: AnyObject {

    init(view: OptionesViewProtocol,networkService: APIOptionesDataServiceProtocol, router: LoginRouterProtocol,user: User?)
    var user: User?  { get set }
    func goToBackTappedViewFromRight()
    func redactUserDataButton()
    func schowClientsButoon()
    func schowPriceButoon()
    func schowTeamButoon()
    func changeStatus()
    func exitUser()
    func removeUser()
    func safeIdUserForSharing()
    

}

// заввязываемся на протоколе
class OptionesViewPresentor: OptionesViewPresenterProtocol {
   
    

   weak var view: OptionesViewProtocol?
   var router: LoginRouterProtocol?
   let networkService:APIOptionesDataServiceProtocol!
   var user: User?

    required init(view: OptionesViewProtocol,networkService: APIOptionesDataServiceProtocol, router: LoginRouterProtocol, user: User?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.user = user
 
    }
    
    func goToBackTappedViewFromRight() {
        router?.backTappedFromRight()
    }
    
    func redactUserDataButton() {
        print("redactUserDataButton")
    }
    
    func schowClientsButoon() {
        print("schowClientsButoon")
        self.router?.showClientsTableViewController()
    }
    
    func schowPriceButoon() {
        print("schowPriceButoon")
        self.router?.showPrice()
    }
    
    func schowTeamButoon() {
        print("schowTeamButoon")
     
    }
    
    func changeStatus() {
        print("changeStatus")
    }
    
    func exitUser() {
        print("exitUser")
        networkService.signOutUser() {[weak self] result in
        guard let self = self else {return}
            DispatchQueue.main.async {
                switch result{
                case.success(_):
                    self.router?.initalLoginViewControler()
                case.failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func removeUser() {
        print("removeUser")
    }
    
    func safeIdUserForSharing() {
        print("safeIdUserForSharing")
        guard let idUser = user?.uid else {return}
        UIPasteboard.general.string = idUser
        self.view?.succesForAlert(title: "Your ID has been copied to the clipboard.", message: "Id: " + idUser)
    }

}

