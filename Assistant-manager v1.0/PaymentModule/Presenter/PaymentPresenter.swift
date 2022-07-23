//
//  PaymentPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/07/2022.
//

import Foundation
import UIKit

protocol PaymentProtocol: AnyObject {
    func failure(error: Error)
    func dataLoading (customerRecord: CustomerRecord?, master: Team?)
    func relowDataBillTable(total: String)
}

protocol PaymentPresenterProtocol: AnyObject{
    init(view: PaymentProtocol,networkService:ApiPaymentServiceProtocol,router:LoginRouterProtocol, customerRecordent: CustomerRecord?, master: Team?)
    func pushPay(payCard:Bool,comment: String)
    var bill: [Price]? {get set}
}

class PaymentPresenter: PaymentPresenterProtocol{
  
    weak var view: PaymentProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiPaymentServiceProtocol!
    var customerRecord: CustomerRecord?
    var master: Team?
    var bill: [Price]?

    
    required init(view: PaymentProtocol,networkService:ApiPaymentServiceProtocol, router:LoginRouterProtocol,customerRecordent: CustomerRecord?, master: Team?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.customerRecord = customerRecordent
        self.master = master
        self.bill = [Price]()
        
        dataForBill()
        self.view?.dataLoading(customerRecord: customerRecordent, master: master)
    }
    func dataForBill(){
        
            var totalSum = [Double]()
            var totalText = ""
        
            for (service) in self.customerRecord?.service ?? [[String : Any]](){
                let priceVolue = service["priceServies"] as! Double
                let nameServise = service["nameServise"] as! String
                self.bill?.append(Price(dictionary: ["priceServies": priceVolue,"nameServise": nameServise]))
                totalSum.append( priceVolue)
                   }
            totalText = String(totalSum.compactMap { Double($0) }.reduce(0, +))
            self.view?.relowDataBillTable(total: totalText)

        
    }
    func pushPay(payCard:Bool,comment: String){
        var cash = false
        var card = false
      
        var cardPrice = 0.0
        var cashPrice = 0.0
        
        var totalSum = [Double]()
        for (serv) in customerRecord!.service {
            totalSum.append( serv["priceServies"] as! Double )
        }
        let total = totalSum.compactMap { Double($0) }.reduce(0, +)
        
        switch payCard {
        case false:
            cash = true
            card = false
            cashPrice = total
        case true:
            cash = false
            card = true
            cardPrice = total
        }
        
        
        networkService.addNewTransactionUser(card: card, cash: cash,cashPrice: cashPrice,cardPrice: cardPrice, comment: comment, customerRecordent: customerRecord, master: master){[weak self] result in
            guard let self = self else {return}
                DispatchQueue.main.async {
                    switch result{
                    case.success(_):
                      print("закрыть")
                        self.router?.dismiss()
                        self.router?.popToRoot()
                    case.failure(let error):
                        self.view?.failure(error: error)
                    }
                }
            }
        
        
       
    }
}

