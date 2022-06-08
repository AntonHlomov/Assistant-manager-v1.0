//
//  PricePresentor.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 08/06/2022.
//

import Foundation

protocol PriceProtocol: AnyObject{
    func succesReloadTable()
    func filure(error: Error)
}

protocol PricePresenterProtocol: AnyObject{
    init(view: PriceProtocol, networkService:APIPriceProtocol, ruter:LoginRouterProtocol)
    var price: [Price]? {get set}
    func getPrice()
    func addNewService()
    }
    
class PricePresenter: PricePresenterProtocol{
       
    weak var view: PriceProtocol?
    var router: LoginRouterProtocol?
    let networkService:APIPriceProtocol!
    var price: [Price]?

    
    required init(view: PriceProtocol, networkService: APIPriceProtocol, ruter: LoginRouterProtocol) {
        self.view = view
        self.router = ruter
        self.networkService = networkService
        getPrice()
    }
    func addNewService(){
        print("newService")
    }
    
    func getPrice() {
        networkService.getPriceAPI{ [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let price):
                    self?.price = price
                    self?.view?.succesReloadTable()
                case .failure(let error):
                    self?.view?.filure(error: error)
                  
                }
            }
        }
    }
    
        
        
}

