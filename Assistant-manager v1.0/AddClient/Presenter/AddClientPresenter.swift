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
    func setClientForEditMode(client: Client?)
}

protocol AddClientViewPresenterProtocol: AnyObject {
    init(view: AddClientViewProtocol,networkService: ApiAddClientDataServiceProtocol, router: LoginRouterProtocol,editMode: Bool,client: Client?, user: User?)
    
    func addClient(nameClient: String, fullName: String,telefonClient: String, profileImageClient:UIImage,genderClient: String, ageClient: Int,textAboutClient: String)

    
}

class AddClientPresenter: AddClientViewPresenterProtocol {
 
    weak var view: AddClientViewProtocol?
    var router: LoginRouterProtocol?
    let networkService:ApiAddClientDataServiceProtocol!
    var client: Client?
    var editMode: Bool?
    var user: User?
    
    required init(view: AddClientViewProtocol, networkService: ApiAddClientDataServiceProtocol, router: LoginRouterProtocol, editMode: Bool, client: Client?,user: User?) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.client = client
        self.editMode = editMode
        self.user = user
        
        checkEditMode()
        

       }
    
    func addClient(nameClient: String,fullName: String, telefonClient: String, profileImageClient: UIImage, genderClient: String, ageClient: Int, textAboutClient: String) {
        
        switch editMode{
        case true:
            guard let user = self.user else {return}
            guard let idClient = client?.idClient else {return}
            guard let olderUrlImageClient = client?.profileImageClientUrl else {return}
            let  olderImageView = CustomUIimageView(frame: .zero)
            olderImageView.loadImage(with: client?.profileImageClientUrl ?? "")
            let data1: Data? = olderImageView.image?.pngData()
            let data2: Data? = profileImageClient.pngData()
            let changePhoto:Bool
            if data1 == data2 {
                changePhoto = false
            } else {
                changePhoto = true
            }
            networkService.editClient(changePhoto:changePhoto, idClient: idClient,olderUrlImageClient: olderUrlImageClient,nameClient: nameClient, fullName: fullName, telefonClient: telefonClient, profileImageClient: profileImageClient, genderClient: genderClient, ageClient: ageClient, textAboutClient: textAboutClient,user: user){[weak self] result in
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
            networkService.addClient(nameClient: nameClient, fullName: fullName, telefonClient: telefonClient, profileImageClient: profileImageClient, genderClient: genderClient, ageClient: ageClient, textAboutClient: textAboutClient,user: self.user){[weak self] result in
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
         view?.setClientForEditMode(client: client)
     }
    
    
 
    
}

