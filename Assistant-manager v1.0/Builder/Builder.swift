//
//  Builder.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/01/2022.
//

import UIKit

protocol AsselderBuilderProtocol{
    func createLoginModule(router: LoginRouterProtocol) -> UIViewController
    func createRegistrationModule(router: LoginRouterProtocol) -> UIViewController
    func createScreensaverModule(router: LoginRouterProtocol) -> UIViewController
 //   func createMainTabModul() -> UIViewController
   
}
// сборщик
class AsselderModelBuilder: AsselderBuilderProtocol{
    

    func createLoginModule(router: LoginRouterProtocol) -> UIViewController {
        let view = LoginControler()
        let networkService = APILoginService()
        let presenter = LoginPresentor(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createRegistrationModule(router: LoginRouterProtocol) -> UIViewController {
        let view = RegistrationController()
        let networkService = APIRegistrationService()
        let presenter = RegistrationPresentor(view: view, networkService: networkService,router: router)
        view.presenter = presenter
        return view
    }
    
     func createScreensaverModule(router: LoginRouterProtocol) -> UIViewController {
        let view = ScreensaverViewController()
        let presenter = ScreensaverPresentor(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
 // func createMainTabModul(router: LoginRouterProtocol) -> UIViewController{
 //     //Календарь
 //
 //    }
  
}

