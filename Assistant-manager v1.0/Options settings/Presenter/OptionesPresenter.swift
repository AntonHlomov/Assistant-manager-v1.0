//
//  OptionesPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 12/05/2022.
//
var clickDarkModeIndicator = 1 // mode 1"Dark" 2"light" 3"system"

import Foundation
import UIKit

// отправляет сообщение в View 
//outPut
protocol OptionesViewProtocol: AnyObject {
    func succesForAlert(title: String, message: String)
    func succes()
    func failure(error: Error)
    func reloadIndex(indexPath: IndexPath)
 
}

// делаем протокол который завязываемся не на View а на протоколе ViewProtocol и делаем инициализатор которой захватывает ссылку на View принцип  Solid сохряняем уровень абстракции
//inPut
protocol OptionesViewPresenterProtocol: AnyObject {

    init(view: OptionesViewProtocol,networkService: APIOptionesDataServiceProtocol, router: LoginRouterProtocol,user: User?,networkServiceAPIGlobalUser:APIGlobalUserServiceProtocol)
    var user: User?  { get set }
    var countClients: Int { get set }
    var countPrice: Int { get set }
    var countTeam: Int { get set }
   // var status: String { get set }
   // var click: Int { get set }
    func goToBackTappedViewFromRight()
    func redactUserDataButton()
    func schowClientsButoon()
    func schowPriceButoon()
    func schowTeamButoon()
    func changeStatus()
    func changeDarkMode(click:Int)
    func exitUser()
    func removeUser()
    func safeIdUserForSharing()
    

}

// заввязываемся на протоколе
class OptionesViewPresentor: OptionesViewPresenterProtocol {
   
    

   weak var view: OptionesViewProtocol?
   var router: LoginRouterProtocol?
   let networkService:APIOptionesDataServiceProtocol!
   let networkServiceAPIGlobalUser:APIGlobalUserServiceProtocol!
   var user: User?
   var countClients: Int
   var countPrice: Int
   var countTeam: Int
   //var status: String




    required init(view: OptionesViewProtocol,networkService: APIOptionesDataServiceProtocol, router: LoginRouterProtocol, user: User?,networkServiceAPIGlobalUser:APIGlobalUserServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.networkServiceAPIGlobalUser = networkServiceAPIGlobalUser
        self.user = user
        self.countClients = 0
        self.countPrice = 0
        self.countTeam = 0
       // self.status = user?.statusInGroup ?? ""
       getGlobalUser()
      
        
       //getCountClients(user: user)
     //  getCountPrice(user: user)
      // getCountTeam(user: user)
    }
    
  
 
  
    func getCountClients(user: User?) {
        networkService.countClients(user: user){ [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let count):
                    self?.countClients = count
                    self?.view?.reloadIndex(indexPath: [2, 0])
                case .failure(let error):
                    self?.view?.failure(error: error)
                  
                }
            }
        }
    }
    func getCountPrice(user: User?) {
        networkService.countPrice(user: user){ [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let count):
                    self?.countPrice = count
                    self?.view?.reloadIndex(indexPath: [2, 1])
                case .failure(let error):
                    self?.view?.failure(error: error)
                  
                }
            }
        }
    }
    func getCountTeam(user: User?) {
        networkService.countTeam(user: user){ [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let count):
                    self?.countTeam = count
                    self?.view?.reloadIndex(indexPath: [2, 2])
                case .failure(let error):
                    self?.view?.failure(error: error)
                  
                }
            }
        }
    }
    
    
    func goToBackTappedViewFromRight() {
        router?.backTappedFromRight()
    }
    
    func redactUserDataButton() {
        print("redactUserDataButton")
    }
    
    func schowClientsButoon() {
        print("schowClientsButoon")
        self.router?.showClientsTableViewController(user: self.user, markAddMassageReminder: false)
    }
    
    func schowPriceButoon() {
        print("schowPriceButoon")
        self.router?.showPrice(newVisitMode: false, client: nil, user: self.user)
    }
    
    func schowTeamButoon() {
        print("schowTeamButoon")
        self.router?.showTeam(user: self.user)
     
    }
    
    func changeStatus() {
        print("changeStatus")
        
        
    }
    func changeDarkMode(click:Int){
       // click = click + 1
        switch click{
        case 1:
            UserDefaults.standard.setValue(Theme.dark.rawValue, forKey: "theme")
            clickDarkModeIndicator = 2
        case 2:
            UserDefaults.standard.setValue(Theme.light.rawValue, forKey: "theme")
            clickDarkModeIndicator = 3
        case 3:
            UserDefaults.standard.setValue(Theme.system.rawValue, forKey: "theme")
            clickDarkModeIndicator = 1
            
        default:
            UserDefaults.standard.setValue(Theme.system.rawValue, forKey: "theme")
        }
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
        getGlobalUser()
        
    }
    func getGlobalUser(){
        print("getGlobalUser")
     
            networkServiceAPIGlobalUser.fetchCurrentUser{[weak self] result in
            guard let self = self else {return}
                DispatchQueue.main.async {
                    switch result{
                    case.success(let user):
                        self.user = user
                        self.view?.reloadIndex(indexPath: [2, 3])
                        self.getCountClients(user: user)
                        self.getCountPrice(user: user)
                        self.getCountTeam(user: user)
                    case.failure(let error):
                        self.view?.failure(error: error)
                       
               }
            }
         }
     }
    
    func safeIdUserForSharing() {
        print("safeIdUserForSharing")
        guard let idUser = user?.uid else {return}
        UIPasteboard.general.string = idUser
        self.view?.succesForAlert(title: "Your ID has been copied to the clipboard.", message: "Id: " + idUser)
    }

}

