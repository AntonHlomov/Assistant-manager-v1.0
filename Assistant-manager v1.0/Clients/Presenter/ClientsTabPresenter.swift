//
//  ClientsTabPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 12/05/2022.
//

import Foundation
protocol ClientsTabViewProtocol: AnyObject {
    func succesReload()
    func failure(error: Error)
}

protocol ClientsTabViewPresenterProtocol: AnyObject {
    init(view: ClientsTabViewProtocol,networkService: ApiAllClientsDataServiceProtocol, router: LoginRouterProtocol)
    func getClients()
    func filter(text: String)
    var clients: [Client]? {get set}
    var filterClients: [Client]? {get set}
    func goToPageClient(indexPathRowClient:Int)
    

    
}

// заввязываемся на протоколе
class ClientsTabPresentor: ClientsTabViewPresenterProtocol {
   
    weak var view: ClientsTabViewProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiAllClientsDataServiceProtocol!
    var clients: [Client]?
    var filterClients: [Client]?

    required init(view: ClientsTabViewProtocol,networkService: ApiAllClientsDataServiceProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        getClients()
 
    }
    func filter(text: String) {
        if text == "" {
            filterClients = clients?.sorted{ $0.nameClient < $1.nameClient } }
        else {
               filterClients = clients?.filter( {$0.nameClient.lowercased().contains(text.lowercased()) || $0.fullName.lowercased().contains(text.lowercased()) || $0.textAboutClient.lowercased().contains(text.lowercased())})
        }
        self.view?.succesReload()
    }
    
    func getClients() {
        networkService.getClients{ [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let clients):
                    self?.clients = clients
                    self?.filterClients = clients
                    self?.view?.succesReload()
                case .failure(let error):
                    self?.view?.failure(error: error)
                  
                }
            }
            
        }
    }
    func goToPageClient(indexPathRowClient: Int) {
        print("открыть клиента",indexPathRowClient)
        self.router?.showClientPage(client: clients?[indexPathRowClient])
    }
   
}
