//
//  СhoiceVisitDatePresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 11/06/2022.
//

import Foundation
import UIKit

protocol СhoiceVisitDateProtocol: AnyObject{
    func succes()
    func failure(error: Error)
}

protocol СhoiceVisitDatePresenterProtocol: AnyObject{
    init(view: СhoiceVisitDateProtocol, networkService:ApiСhoiceVisitDateProtocol, ruter:LoginRouterProtocol,serviceCheck: [Price]?,clientCheck: Client?)
    
    func puchConfirm()
    func pressedMastersChoice(indexPath:IndexPath)
    func presedClient(indexPath:IndexPath)
    func dateChanged(senderDate: Date)
    func setDataForTeam()
    func setDataCustomerRecordForMaster()

    }

class СhoiceVisitDatePresenter: СhoiceVisitDatePresenterProtocol{
   
    weak var view: СhoiceVisitDateProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiСhoiceVisitDateProtocol!
    
    var customerRecordPast:[CustomerRecord]?
    var team: [Team]?
    var serviceCheck: [Price]?
    var client: Client?
    var newCustomerRecordPast:[CustomerRecord]?

    required init(view: СhoiceVisitDateProtocol, networkService:ApiСhoiceVisitDateProtocol, ruter:LoginRouterProtocol,serviceCheck: [Price]?,clientCheck: Client?) {
        self.view = view
        self.router = ruter
        self.networkService = networkService
        self.client = clientCheck
        self.serviceCheck = serviceCheck
        
        setDataForTeam()
        setDataCustomerRecordForMaster()
 
    }
    func setDataForTeam(){
        print("загрузить данные для коллекции мастеров team")
    }
    func setDataCustomerRecordForMaster(){
        print("загрузить данные для таблицы запись в течении дня для конкретного мастера ")
    }
    func puchConfirm(){
        print("puchConfirm",client?.nameClient ?? "")
    }
    func pressedMastersChoice(indexPath:IndexPath) {
        print("выбрал мастера кому записывать",indexPath)
        print("загрузить данные для таблицы (запись в течении дня) для мастера:",indexPath.row)
    }
    
    func presedClient(indexPath:IndexPath) {
        print("нажал на запись", indexPath)
    }
    
    func dateChanged(senderDate: Date) {
        print("выбор даты и времени для записи")
        let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
        let dateFormatterYar = DateFormatter()
        dateFormatterYar.dateFormat = "YYYY-MM-dd"
        let dateFormatterM = DateFormatter()
        dateFormatterM.dateFormat = "MM"
        print("Дата записи начала работы с клиентом в календарь \(dateFormatter.string(from: senderDate))")
    }
    
}
