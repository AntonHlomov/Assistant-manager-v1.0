//
//  CustomerVisitRecordConfirmationViewPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/06/2022.
//

import Foundation
import UIKit

protocol CustomerVisitRecordConfirmationViewProtocol: AnyObject {
    func setInfoMaster(image: String,name:String,nameProfesion:String)
    func setInfoClient(image: String,name:String)
    func setInfoDate(dateStart:String)
    func succes()
    func failure(error: Error)
}

protocol CustomerVisitRecordConfirmationViewPresenterProtocol: AnyObject {
    init(view: CustomerVisitRecordConfirmationViewProtocol,networkService: APICustomerVisitRecordConfirmationProtocol, router: LoginRouterProtocol,customerVisit: CustomerRecord?,master:Team?,client: Client?,services:[Price]?)
    
    func saveCustomerVisit()
    func setDtata()
    var master: Team? {get}
    var client: Client? {get}
    var user: User? {get}
    var services:[Price]? {get}
    var customerVisit: CustomerRecord? {get set}
}

class CustomerVisitRecordConfirmationViewPresenter: CustomerVisitRecordConfirmationViewPresenterProtocol {
   
    weak var view: CustomerVisitRecordConfirmationViewProtocol?
    var router: LoginRouterProtocol?
    let networkService:APICustomerVisitRecordConfirmationProtocol!
    var customerVisit: CustomerRecord?
    var master: Team?
    var client: Client?
    var user: User?
    var services:[Price]?
    
    required init(view: CustomerVisitRecordConfirmationViewProtocol,networkService: APICustomerVisitRecordConfirmationProtocol, router: LoginRouterProtocol, customerVisit: CustomerRecord?,master:Team?,client: Client?,services:[Price]?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.customerVisit = customerVisit
        self.master = master
        self.client = client
        self.services = services
        setDtata()
    }
    func setDtata(){
        let imageMaster = master?.profileImageURLTeamMember ?? ""
        let nameMaster = master?.nameTeamMember ?? ""
        let fullNameMaster = master?.fullnameTeamMember ?? ""
        let profecionMaster = master?.professionName ?? ""
        let nameFullNameMaster = nameMaster.capitalized + (" ") + fullNameMaster.capitalized
        self.view?.setInfoMaster(image: imageMaster, name: nameFullNameMaster, nameProfesion: profecionMaster)
        
        let imageClient = client?.profileImageClientUrl ?? ""
        let nameClient = client?.nameClient ?? ""
        let fullNameClient = client?.fullName ?? ""
        let nameFullNameClient = nameClient.capitalized + (" ") + fullNameClient.capitalized
        self.view?.setInfoClient(image: imageClient, name: nameFullNameClient)
        
        let dateStart = customerVisit?.dateTimeStartService ?? ""
        self.view?.setInfoDate(dateStart: dateStart)
    }
    func saveCustomerVisit() {
        print("отправить через  api запись клиента")
        
    }
}
