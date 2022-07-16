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
}

protocol PaymentPresenterProtocol: AnyObject{
    init(view: PaymentProtocol,networkService:ApiPaymentServiceProtocol,router:LoginRouterProtocol, customerRecordent: CustomerRecord?, master: Team?)
    func pushPay(payCard:Bool)
}

class PaymentPresenter: PaymentPresenterProtocol{
  
    weak var view: PaymentProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiPaymentServiceProtocol!
    var client: Client?
    var master: Team?

    
    required init(view: PaymentProtocol,networkService:ApiPaymentServiceProtocol, router:LoginRouterProtocol,customerRecordent: CustomerRecord?, master: Team?) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
    func pushPay(payCard:Bool){
        switch payCard {
        case false: print("pushCash")
        case true: print("payCard")
        }
       
    }
}

