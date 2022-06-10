//
//  PricePresentor.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 08/06/2022.
//

import Foundation

protocol PriceProtocol: AnyObject{
    func succesTotalListPrice(totalList:String)
    func succesReloadTable()
    func failure(error: Error)
}

protocol PricePresenterProtocol: AnyObject{
    init(view: PriceProtocol, networkService:APIPriceProtocol, ruter:LoginRouterProtocol)
    var price: [Price]? {get set}
    var filterPrice: [Price]? {get set}
    var checkmarkServises: [Price] {get set}
    func getPrice()
    func addNewService()
    func redactServise(indexPath: IndexPath)
    func deleteServise(indexPath: IndexPath)
    func filter(text: String)
    func offCheckmarkSaveServise(indexPath: IndexPath)
    func onCheckmarkSaveServise(indexPath: IndexPath)
    func checkTotalServices()
    }
    
class PricePresenter: PricePresenterProtocol{
       
    weak var view: PriceProtocol?
    var router: LoginRouterProtocol?
    let networkService:APIPriceProtocol!
    var price: [Price]?
    var filterPrice: [Price]?
    var checkmarkServises = [Price]()

    
    required init(view: PriceProtocol, networkService: APIPriceProtocol, ruter: LoginRouterProtocol) {
        self.view = view
        self.router = ruter
        self.networkService = networkService
        getPrice()
    }
    func addNewService(){
        print("newService")
        self.checkmarkServises.removeAll()
        checkTotalServices()
        self.router?.showAddNewServiceView(editMode: false, price: nil)
        self.view?.succesReloadTable()
    }
    func redactServise(indexPath: IndexPath) {
        print("redactClient")
        self.checkmarkServises.removeAll()
        checkTotalServices()
        self.router?.showAddNewServiceView(editMode: true, price: filterPrice?[indexPath.row])
        self.view?.succesReloadTable()
    }
    func deleteServise(indexPath: IndexPath) {
        print("deleteClient")
        self.checkmarkServises.removeAll()
        checkTotalServices()
        guard let id = self.price?[ indexPath.row].idPrice else {return}
        self.price?.remove(at: indexPath.row)
        self.filterPrice?.remove(at: indexPath.row)
        networkService.deleteServise(id: id) {[weak self] result in
        guard let self = self else {return}
            DispatchQueue.main.async {
                switch result{
                case.success(_):
                    print("delete")
                case.failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
      self.view?.succesReloadTable()
    }
    
    func getPrice() {
        self.checkmarkServises.removeAll()
        networkService.getPriceAPI{ [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let price):
                    self?.price = price?.sorted{$0.nameServise<$1.nameServise}
                    self?.filterPrice = self?.price
                    self?.view?.succesReloadTable()
                case .failure(let error):
                    self?.view?.failure(error: error)
                  
                }
            }
        }
    }
    
    func filter(text: String) {
        if text == "" {
            filterPrice = price?.sorted{ $0.nameServise < $1.nameServise } }
        else {
            filterPrice = price?.filter( {$0.nameServise.lowercased().contains(text.lowercased()) || String(Int($0.priceServies)).lowercased().contains(text.lowercased())})
        }
        self.view?.succesReloadTable()
    }
    
    func onCheckmarkSaveServise(indexPath: IndexPath){
        guard let checServies = self.filterPrice?[indexPath.row] else {return}
        self.checkmarkServises.append(checServies)
        checkTotalServices()
        
        
    }
    func offCheckmarkSaveServise(indexPath: IndexPath){
       guard let offChecServies = filterPrice?[indexPath.row].idPrice else {return}
       let index = self.checkmarkServises.firstIndex{$0.idPrice.contains(offChecServies)}
       if let index = index {
           self.checkmarkServises.remove(at: index)
       }
        checkTotalServices()
    }
    
    func checkTotalServices(){
        guard self.checkmarkServises.isEmpty == false else {
            self.view?.succesTotalListPrice(totalList: "0.0");
            return
        }
        let total = self.checkmarkServises.compactMap({$0.priceServies}).reduce(0, +)
        let totalString =  String(format: "%.1f", total)
        self.view?.succesTotalListPrice(totalList: totalString)
    }
    
    
        
        
}

