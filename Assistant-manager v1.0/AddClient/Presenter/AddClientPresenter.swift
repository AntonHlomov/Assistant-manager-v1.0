//
//  AddClientPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 03/06/2022.
//

import Foundation
import UIKit

protocol AddClientViewProtocol: AnyObject {
    func failure(error: Error)
}

protocol AddClientViewPresenterProtocol: AnyObject {
    init(view: AddClientViewProtocol,networkService: ApiAddClientDataServiceProtocol, router: LoginRouterProtocol)
    func addClient(nameClient: String, fullName: String,telefonClient: String, profileImageClient:UIImage,genderClient: String, ageClient: Int,textAboutClient: String)

    
}

class AddClientPresenter: AddClientViewPresenterProtocol {
    
    weak var view: AddClientViewProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiAddClientDataServiceProtocol!
    
    required init(view: AddClientViewProtocol, networkService: ApiAddClientDataServiceProtocol, router: LoginRouterProtocol) {
           self.view = view
           self.router = router
           self.networkService = networkService
       }
    
    func addClient(nameClient: String,fullName: String, telefonClient: String, profileImageClient: UIImage, genderClient: String, ageClient: Int, textAboutClient: String) {
        networkService.addClient(nameClient: nameClient, fullName: fullName, telefonClient: telefonClient, profileImageClient: profileImageClient, genderClient: genderClient, ageClient: ageClient, textAboutClient: textAboutClient){[weak self] result in
            guard let self = self else {return}
                DispatchQueue.main.async {
                    switch result{
                    case.success(_):
                        self.router?.showClientsTableViewController()
                       // self.router?.dismiss()
                    case.failure(let error):
                        self.view?.failure(error: error)
                    }
                }
            }
        
    }
    
 
    
}

