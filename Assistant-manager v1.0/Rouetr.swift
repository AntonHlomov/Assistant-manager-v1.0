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
    func showOptionesViewController()
    func initalLoginViewControler()
    func initalMainTabControler()
    func initalClientsTableViewController()
    func popToRoot()
    func backTappedFromRight()
    
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
    func showOptionesViewController() {
            if let navigationControler = navigationControler{
                guard let registrationControler = assemblyBuilder?.createOptionesModule(router: self) else {return}
              //  navigationControler.pushViewController(registrationControler, animated: true)
                navigationControler.customPopViewFromLeft(registrationControler)
            }
        }
    func popToRoot() {
        if let navigationControler = navigationControler{
            navigationControler.popToRootViewController(animated: true)
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
