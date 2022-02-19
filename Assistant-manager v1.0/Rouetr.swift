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
    func initalLoginViewControler()
    func initalMainTabControler()

  
    func popToRoot()
    
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
    func initalMainTabControler() {
     
        //tabBarControler?.setViewControllers([ferst,secend], animated: true)
        if let tabBarControler = tabBarControler , let navigationControler = navigationControler {
            tabBarControler.view.backgroundColor = .blue
            
         //  let ferst = LoginControler()
         //  ferst.tabBarItem.title = "Login"
         //  let secend = RegistrationController()
         //  secend.tabBarItem.title = "Registration"
         //  let controllers = [ferst,secend]
         //  tabBarControler.setViewControllers(controllers, animated: true)
         //  navigationControler.viewControllers = [tabBarControler]
            
            
            //Рассходы
            let ExpensesButtom = createNavController(viewController: ExpensesViewController(collectionViewLayout: UICollectionViewFlowLayout()), title: "", selectadImage: #imageLiteral(resourceName: "icons8-прибыльность-96"), unselectedImage: #imageLiteral(resourceName: "icons8-прибыльность-96"))
            //В работе      касса
            let StartButtom = createNavController(viewController: StartWorckViewController(collectionViewLayout: UICollectionViewFlowLayout()), title: "", selectadImage: #imageLiteral(resourceName: "icons8-деньги-48"), unselectedImage: #imageLiteral(resourceName: "icons8-деньги-48"))
            //Стстистика
            let StatistikButtom = createNavController(viewController: StatistikViewController(collectionViewLayout: UICollectionViewFlowLayout()), title: "", selectadImage: #imageLiteral(resourceName: "icons8-статистика-48 (1)"), unselectedImage: #imageLiteral(resourceName: "icons8-статистика-48 (1)"))
            
            let CalendarButtom = createNavController(viewController: CalendarViewController(collectionViewLayout: UICollectionViewFlowLayout()), title: "", selectadImage: #imageLiteral(resourceName: "icons8-календарь-24"), unselectedImage: #imageLiteral(resourceName: "icons8-календарь-24"))
            
            let controllers = [ ExpensesButtom,  StartButtom, StatistikButtom,CalendarButtom]
            tabBarControler.setViewControllers(controllers, animated: true)
            navigationControler.viewControllers = [tabBarControler]
            
            
            
            
            
            
            
            
            
            
            
            
           
        }
   
    //        DispatchQueue.main.async {
    //
    //            let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
    //            if let maintabVC = keyWindow?.rootViewController as? MainTabVC {
    //                maintabVC.configure()
    //                // первая общая загрузка из базы данных
    //
    //             }
    //          //  self.dismiss(animated: true, completion: nil)
    //    }
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
    func popToRoot() {
        if let navigationControler = navigationControler{
            navigationControler.popToRootViewController(animated: true)
        }
    }
    
    
    
    func createNavController(viewController: UIViewController, title: String, selectadImage: UIImage, unselectedImage: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
      //  navigationControler.viewControllers = [rootViewController]
        //navigationController?.navigationBar.backgroundColor =  .clear
        navController.tabBarItem.title = title       // название в навигешн баре в низу
        viewController.navigationItem.title = title // название в навигешн баре в верху
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectadImage
      //  tabBar.barTintColor = .white
        // убираем стандартную настройку прозрачности таб бара и делаем ее не прозрачной
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
          //  tabBarAppearance.backgroundColor = UIColor.rgb(red: 255, green: 255, blue: 255)
            UITabBar.appearance().standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
        return navController
    }
    
    
    
    
    
    
    
    
    
  
    
}
