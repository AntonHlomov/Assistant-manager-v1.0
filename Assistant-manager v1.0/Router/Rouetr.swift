//
//  Rouetr.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 16/02/2022.
//

import UIKit

protocol RouterLogin{
    var navigationControler: UINavigationController? {get set}
    var tabBarControler: UITabBarController? {get set}
    var assemblyBuilder: AsselderBuilderProtocol? {get set}
}

protocol LoginRouterProtocol: RouterLogin {
    func initalScreensaverControler()
    // пример передачи обекта
    //  func showDetailUserController(user:User?)
    func showRegistrationController()
    func showLoginController()
    func showClientsTableViewController()
    func showPrice(newVisitMode: Bool, client: Client?)
    func showChoiceVisitDateModule(serviceCheck: [Price]?,clientCheck: Client?)
    func showCustomerVisitRecordConfirmationViewModule(customerVisit: CustomerRecord?,master:Team?,client: Client?,services:[Price]?)
    func showClientPage(client: Client?)
    func showAddClientView(editMode: Bool, client: Client?)
    func showAddNewServiceView(editMode: Bool, price: Price?)
    func showOptionesViewController(user: User?)
    func initalLoginViewControler()
    func initalMainTabControler()
    func initalClientsTableViewController()
    func popToRoot()
    func backTappedFromRight()
    func popViewControler()
   // func dismiss()
    
}

class Router: LoginRouterProtocol{
 
    var navigationControler: UINavigationController?
    var tabBarControler: UITabBarController?
    var assemblyBuilder: AsselderBuilderProtocol?
    
    init(navigationControler: UINavigationController,tabBarControler: UITabBarController,assemblyBuilder: AsselderBuilderProtocol){
        self.navigationControler = navigationControler
        self.tabBarControler = tabBarControler
        self.assemblyBuilder = assemblyBuilder
    }

    func initalScreensaverControler() {
        if let navigationControler = navigationControler{
            guard let MainViewControler = assemblyBuilder?.createScreensaverModule(router: self) else {return}
            navigationControler.viewControllers = [MainViewControler]
        }
    }
    
    func initalLoginViewControler() {
        if let navigationControler = navigationControler{
            guard let MainViewControler = assemblyBuilder?.createLoginModule(router: self) else {return}
            navigationControler.viewControllers = [MainViewControler]
        }
    }
    
    func initalClientsTableViewController() {
        if let navigationControler = navigationControler{
            guard let MainViewControler = assemblyBuilder?.createClientsTableModule(router: self) else {return}
            navigationControler.viewControllers = [MainViewControler]
          
        }
    }

    func initalMainTabControler() {
        if let tabBarControler = tabBarControler , let navigationControler = navigationControler {
            //tabBarControler.view.backgroundColor = .blue
            guard let CalendarControler = assemblyBuilder?.createCalendarModule(router: self) else {return}
            guard let ExpensesControler = assemblyBuilder?.createExpensesModule(router: self) else {return}
            guard let StartControler = assemblyBuilder?.createStartWorckModule(router: self) else {return}
            guard let StatistikControler = assemblyBuilder?.createStatistikModule(router: self) else {return}
            let controllers = [CalendarControler.buuton, ExpensesControler.buuton, StartControler.buuton, StatistikControler.buuton]
            tabBarControler.setViewControllers(controllers, animated: true)
           // navigationControler.navigationBar.isHidden = true
        
            
            navigationControler.viewControllers = [tabBarControler]
      
        }
    }
  
//   func showDetailUserController(user: User?) {
//       if let navigationControler = navigationControler{
//           guard let loginViewControler = assemblyBuilder?.createLoginModule(user:User?) else {return}
//           navigationControler.viewControllers = [loginViewControler]
//       }
    
 //   }
    func showLoginController() {
        if let navigationControler = navigationControler{
            guard let registrationControler = assemblyBuilder?.createLoginModule(router: self) else {return}
            navigationControler.pushViewController(registrationControler, animated: true)
        }
    }
    func showRegistrationController() {
        if let navigationControler = navigationControler{
            guard let registrationControler = assemblyBuilder?.createRegistrationModule(router: self) else {return}
            navigationControler.pushViewController(registrationControler, animated: true)
        }
    }
    func showClientsTableViewController() {
        if let navigationControler = navigationControler{
            guard let registrationControler = assemblyBuilder?.createClientsTableModule(router: self) else {return}
            navigationControler.pushViewController(registrationControler, animated: true)
        }
    }
    func showPrice(newVisitMode: Bool, client: Client?) {
        if let navigationControler = navigationControler{
            guard let registrationControler = assemblyBuilder?.createPriceModule(router: self,newVisitMode: newVisitMode, client: client) else {return}
            navigationControler.pushViewController(registrationControler, animated: true)
        }
    }
    func showChoiceVisitDateModule(serviceCheck: [Price]?,clientCheck: Client?) {
        if let navigationControler = navigationControler{
            guard let registrationControler = assemblyBuilder?.createChoiceVisitDateModule(router: self,serviceCheck: serviceCheck,clientCheck: clientCheck) else {return}
            navigationControler.pushViewController(registrationControler, animated: true)
        }
    }
    func showCustomerVisitRecordConfirmationViewModule(customerVisit: CustomerRecord?,master:Team?,client: Client?,services:[Price]?) {
        if let navigationControler = navigationControler {
            guard let registrationControler = assemblyBuilder?.crateCustomerVisitRecordConfirmationModule(router: self, customerVisit: customerVisit,master:master,client: client,services:services) else {return}
          //  navigationControler.pushViewController(registrationControler, animated: true)
            navigationControler.present(registrationControler, animated: true, completion: nil)
        }
    }
    func showClientPage(client: Client?){
        if let navigationControler = navigationControler {
            guard let registrationControler = assemblyBuilder?.craateClientPageModule(router: self, client: client) else {return}
          
            navigationControler.pushViewController(registrationControler, animated: true)
        }
    }
    func showAddClientView(editMode: Bool, client: Client?) {
        if let navigationControler = navigationControler{
            guard let registrationControler = assemblyBuilder?.createAddClientModule( router: self, editMode: editMode, client: client) else {return}
            navigationControler.pushViewController(registrationControler, animated: true)
        }
    }
    func showAddNewServiceView(editMode: Bool, price: Price?) {
        if let navigationControler = navigationControler{
            guard let registrationControler = assemblyBuilder?.addNewServiceModule( router: self, editMode: editMode, price: price) else {return}
            navigationControler.pushViewController(registrationControler, animated: true)
        }
    }
    func showOptionesViewController(user: User?) {
            if let navigationControler = navigationControler{
                guard let registrationControler = assemblyBuilder?.createOptionesModule(router: self, user: user) else {return}
              //  navigationControler.pushViewController(registrationControler, animated: true)
                navigationControler.customPopViewFromLeft(registrationControler)
            }
        }
    func popToRoot() {
        if let navigationControler = navigationControler{
            navigationControler.popToRootViewController(animated: true)
        }
    }
    func popViewControler() {
        if let navigationControler = navigationControler{
            navigationControler.popViewController(animated: true)
        }
    }
    
    func backTappedFromRight(){
        if let navigationControler = navigationControler{
            navigationControler.customBackTappedViewFromRight()
        }
    }
    

    
}

extension UINavigationController {
    func customPopViewFromLeft(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
    func customBackTappedViewFromRight() {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.layer.add(transition, forKey: nil)
        popToRootViewController(animated: true)
    }
}
