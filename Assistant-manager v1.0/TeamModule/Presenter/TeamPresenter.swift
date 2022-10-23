//
//  TeamPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 22/10/2022.
//

import Foundation

protocol TeamProtocol: AnyObject{
    func reloadTable ()
    func failure(error: Error)
}
protocol TeamPresenterProtocol: AnyObject{
    init(view: TeamProtocol, networkService:ApiTeamProtocol, ruter:LoginRouterProtocol, user: User?)
    var team: [Team]? {get set}
    func getTeam()
    func goToPageTeamUser(indexPathRowClient: Int)
    func deleteTeamUser(indexPath: IndexPath)
    func redactTeamUser(indexPath: IndexPath)
    func confirmAddIdNewTeamUser(idNewTeamUser: String, status:String)
    func removeTeamAll()
}
class TeamPresenter: TeamPresenterProtocol{
    weak var view: TeamProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiTeamProtocol!
    var user: User?
    var team: [Team]?
    
    required init(view: TeamProtocol, networkService: ApiTeamProtocol, ruter: LoginRouterProtocol, user: User?) {
        self.view = view
        self.router = ruter
        self.networkService = networkService
        self.user = user
        getTeam()
    }
    func removeTeamAll(){
        print("removeTeamAll")
    }
    func confirmAddIdNewTeamUser(idNewTeamUser: String ,status: String){
        print("confirmAddIdNewTeamUser idNewTeamUser: \(idNewTeamUser) status: \(status)")
    }
    func redactTeamUser(indexPath: IndexPath){
        print("redactTeamUser\(indexPath)")
    }
    func deleteTeamUser(indexPath: IndexPath){
        print("deleteTeamUser\(indexPath)")
     //   guard let id = self.team?[ indexPath.row].id else {return}
        self.team?.remove(at: indexPath.row)
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
                    self?.team = team
                    self?.view?.reloadTable()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
    
}
