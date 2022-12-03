//
//  TeamPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 22/10/2022.
//
import Foundation
import UIKit

protocol TeamProtocol: AnyObject{
    func reloadTable()
    func failure(error: Error)
    func massage(title:String, message: String)
}

protocol TeamPresenterProtocol: AnyObject{
    init(view: TeamProtocol, networkService:ApiTeamProtocol, ruter:LoginRouterProtocol, user: User?,networkServiceAPIGlobalUser:APIGlobalUserServiceProtocol)
    var team: [Team]? {get set}
    func getTeam()
    func goToPageTeamUser(indexPathRowClient: Int)
    func deleteTeamUser(indexPathRow:Int)
    func redactTeamUser(indexPath: IndexPath)
    func confirmAddIdNewTeamUser(idNewTeamUser: String, status:String)
    func removeTeamAll()
    func createTaemForBossUser()
}

class TeamPresenter: TeamPresenterProtocol{
    weak var view: TeamProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiTeamProtocol!
    let networkServiceAPIGlobalUser:APIGlobalUserServiceProtocol!
    var user: User?
    var team: [Team]?
   
    required init(view: TeamProtocol, networkService: ApiTeamProtocol, ruter: LoginRouterProtocol, user: User?,networkServiceAPIGlobalUser:APIGlobalUserServiceProtocol) {
        self.view = view
        self.router = ruter
        self.networkService = networkService
        self.networkServiceAPIGlobalUser = networkServiceAPIGlobalUser
        self.user = user
        getTeam()
    }

    func getGlobalUser(){
        print("getGlobalUser")
            networkServiceAPIGlobalUser.fetchCurrentUser{[weak self] result in
            guard let self = self else {return}
                DispatchQueue.main.async {
                    switch result{
                    case.success(let user):
                        self.user = user
                        self.getTeam()
                    case.failure(let error):
                        self.view?.failure(error: error)
               }
            }
         }
     }
    
    func removeTeamAll(){
        switch self.user?.statusInGroup {
        case "Boss":
            networkService.removeTeam(user: self.user, team: self.team){ [weak self] result in
                guard self != nil else {return}
                DispatchQueue.main.async {
                    switch result{
                    case .success(_):
                        print("removeTeamAll")
                    case .failure(let error):
                        self?.view?.failure(error: error)
                    }
                }
            }
        default:
            self.view?.massage(title: "Operation is not possible.", message: "Deleting a group is possible only with the Boss status")
        }
    
    }
    func createTaemForBossUser(){
        guard  let userBoss = self.user else {return}
        let nameForGroup = "Name Group"
        let category = "Boss"
        let avatarGroup: UIImage = #imageLiteral(resourceName: "Icon_512x512").withRenderingMode(.alwaysOriginal)
        networkService.createNewGroup(userCreate: userBoss, nameGroup: nameForGroup , profileImageGroup: avatarGroup, categoryTeamMember: category) { [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async { [self] in
                switch result{
                case .success(let mark):
                    guard mark == true else {return}
                     self?.getGlobalUser()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
    func confirmAddIdNewTeamUser(idNewTeamUser: String ,status: String){
        switch self.user?.statusInGroup {
        case "Boss","Administrator":
            networkServiceAPIGlobalUser.addRequestAddTeam(userBoss: self.user, idNewTeamUser: idNewTeamUser, statusInGroup: status) { [weak self] result in
                guard self != nil else {return}
                DispatchQueue.main.async { [self] in
                    switch result{
                    case .success(_):
                        self?.view?.massage(title: "Request has been sent", message: "After the request is confirmed by a new member, he will be added to the group.")
                    case .failure(let error):
                        self?.view?.failure(error: error)
                    }
                }
            }
        default:
            self.view?.massage(title: "Operation is not possible.", message: "Adding a user is only possible with the Boss status")
        }
      
    }
    func redactTeamUser(indexPath: IndexPath){
        switch self.user?.statusInGroup {
        case "Boss","Administrator":
            if self.team?[indexPath.row].categoryTeamMember == "Boss" && self.user?.statusInGroup == "Administrator"  {
                self.view?.reloadTable()
                self.view?.massage(title: "Operation is not possible.", message: "Editing a user with the Boss status is not possible")
                break
            }
            print("redactTeamUser\(indexPath)")
    default:
            self.view?.reloadTable()
            self.view?.massage(title: "Operation is not possible.", message: "User editing is possible only with the Boss status")
     }
    }
    func deleteTeamUser(indexPathRow:Int){
        switch self.user?.statusInGroup {
        case "Boss","Administrator":
            if self.team?[indexPathRow].categoryTeamMember == "Boss" && self.user?.statusInGroup == "Administrator"  {
                self.view?.reloadTable()
                self.view?.massage(title: "Operation is not possible.", message: "Deleting a user with the Boss status is not possible")
                break
            }
            print("deleteTeamUser\(indexPathRow)")
            guard let idTeamUser = self.team?[indexPathRow].id else {return}
            networkService.deleteTeamUser(user:self.user,idTeamUser: idTeamUser){ [weak self] result in
                guard self != nil else {return}
                DispatchQueue.main.async {
                    switch result{
                    case .success(let mark):
                        guard mark == true else {return}
                        self?.view?.reloadTable()
                    case .failure(let error):
                        self?.view?.failure(error: error)
                    }
                }
           }
        default:
            self.view?.reloadTable()
            self.view?.massage(title: "Operation is not possible.", message: "Deleting a user is possible only with the Boss status")
        }
   
    }
    func goToPageTeamUser(indexPathRowClient: Int){
        print("goToPageTeamUser\(indexPathRowClient)")
    }
    func getTeam(){
        networkService.getTeam(user: self.user){ [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let team):
                    print("3")
                    self?.team = team
                    self?.view?.reloadTable()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
}
