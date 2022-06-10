//
//  AddNewServicePresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 09/06/2022.
//

import Foundation

protocol AddNewServiceProtocol: AnyObject{
    func succes()
    func failure(error: Error)
    func setPriceForEditMode(price: Price?)
}

protocol AddNewServicePresenterProtocol: AnyObject{
    init(view: AddNewServiceProtocol, networkService:ApiAddNewServiceProtocol, ruter:LoginRouterProtocol,editMode: Bool, price: Price?)
    func addNewServies(nameServise: String,priceServies: Double,timeAtWorkMin: Int,timeReturnServiseDays: Int)
    var price: Price? {get set}
    
    }

class AddNewServicePresenter: AddNewServicePresenterProtocol{
   
    weak var view: AddNewServiceProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiAddNewServiceProtocol!
    var price: Price?
    var editMode: Bool?
   
    required init(view: AddNewServiceProtocol, networkService: ApiAddNewServiceProtocol, ruter: LoginRouterProtocol,editMode: Bool,price: Price?) {
        self.view = view
        self.router = ruter
        self.networkService = networkService
        self.price = price
        self.editMode = editMode
        
        checkEditMode()
    }
    func addNewServies(nameServise: String, priceServies: Double, timeAtWorkMin: Int, timeReturnServiseDays: Int) {
        switch editMode{
        case true:
            guard let idPrice = price?.idPrice else {return}
          
            networkService.editServies(idPrice: idPrice, nameServise: nameServise, priceServies: priceServies, timeAtWorkMin: timeAtWorkMin, timeReturnServiseDays: timeReturnServiseDays){[weak self] result in
                guard let self = self else {return}
                    DispatchQueue.main.async {
                        switch result{
                        case.success(_):
                          print("закрыть")
                          self.router?.popViewControler()
                          
                        case.failure(let error):
                            self.view?.failure(error: error)
                        }
                    }
                }
            
        case false:
            networkService.addServies(nameServise: nameServise, priceServies: priceServies, timeAtWorkMin: timeAtWorkMin, timeReturnServiseDays: timeReturnServiseDays){[weak self] result in
                guard let self = self else {return}
                    DispatchQueue.main.async {
                        switch result{
                        case.success(_):
                            self.router?.popViewControler()
                        case.failure(let error):
                            self.view?.failure(error: error)
                        }
                    }
                }
       
        default:
            return
        }
 
    }
    
    func checkEditMode(){
        guard self.editMode == true else {return}
        view?.setPriceForEditMode(price: price)
    }
    
}
