//
//  StatusSwitchPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 25/11/2022.
//
import Foundation
protocol StatusSwitchProtocol: AnyObject {
    func failure(error: Error)
    func reloadTable()
}

protocol StatusSwitchPresenterProtocol: AnyObject{
    init(view: StatusSwitchProtocol,networkService:StatusSwitchApiProtocol,router:LoginRouterProtocol,user: User?)
    func swapStatusSwitch()
    var user: User? {get set}
    var statuses: [String]? {get set}
    var nameGroupCoWorking: String? {get set}
}

class StatusSwitchPresenter: StatusSwitchPresenterProtocol {
    
    weak var view: StatusSwitchProtocol?
    var router: LoginRouterProtocol?
    let networkService:StatusSwitchApiProtocol!
    var user: User?
    var statuses:[String]?
    var nameGroupCoWorking: String?
    required init(view: StatusSwitchProtocol, networkService: StatusSwitchApiProtocol, router: LoginRouterProtocol,user: User?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.user = user
        self.statuses = [String]()
        getNameGroup()
        getStatuses()
       
    }
    func getStatuses(){
        guard let status = self.user?.statusInGroup else {return}
        guard let hiddenStatus = self.user?.hiddenStatus else {return}
        guard status == hiddenStatus else {
            statuses?.removeAll()
            statuses?.append(status)
            statuses?.append(hiddenStatus)
            self.view?.reloadTable()
            return
        }
        statuses?.append(status)
        self.view?.reloadTable()
    }
    /*
    func getNameGroup(){
        guard let idGroup = self.user?.idGroup else {return}
        
        networkService.getNameGroupCoWorking(idGroup: idGroup) {[weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let nameGroup):
                    self?.nameGroupCoWorking = nameGroup
                    self?.view?.reloadTable()
                    
                case .failure(let error):
                    self?.view?.failure(error: error)
                  
                }
            }
        }
        
    }
    */
    func getNameGroup() {
        guard let idGroup = self.user?.idGroup, !idGroup.isEmpty else {
            self.view?.failure(error: NSError(domain: "Firestore", code: -1, userInfo: [NSLocalizedDescriptionKey: "ID группы не найдено или пустое."]))
            return
        }
        networkService.getNameGroupCoWorking(idGroup: idGroup) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let nameGroup):
                    self.nameGroupCoWorking = nameGroup
                    self.view?.reloadTable()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func swapStatusSwitch() {
        guard let status = self.user?.statusInGroup else {return}
        guard let hiddenStatus = self.user?.hiddenStatus else {return}
        networkService.swapStatusSwitch(statusInGroup: status, hiddenStatus: hiddenStatus){ [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(_):
                    break
                case .failure(let error):
                    self?.view?.failure(error: error)
                  
                }
            }
        }
    }
}
