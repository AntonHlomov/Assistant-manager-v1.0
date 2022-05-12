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
    func createClientsTableModule(router: LoginRouterProtocol) -> UIViewController
    func createOptionesModule(router: LoginRouterProtocol) -> UIViewController
    
    func createCalendarModule(router: LoginRouterProtocol) -> (view:UIViewController, buuton: UIViewController)
    func createExpensesModule(router: LoginRouterProtocol) -> (view:UIViewController, buuton: UIViewController)
    func createStartWorckModule(router: LoginRouterProtocol) -> (view:UIViewController, buuton: UIViewController)
    func createStatistikModule(router: LoginRouterProtocol) -> (view:UIViewController, buuton: UIViewController)
   
}
// сборщик
class AsselderModelBuilder: AsselderBuilderProtocol{
    
    func createClientsTableModule(router: LoginRouterProtocol) -> UIViewController {
        let view = ClientsTableViewController()
        let networkService = ApiAllClientsDataService()
        let presenter = ClientsTabPresentor(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createOptionesModule(router: LoginRouterProtocol) -> UIViewController {
        let view = OptionesController()
        let networkService = APIOptionesDataService()
        let presenter = OptionesViewPresentor(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
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
    
    func createCalendarModule(router: LoginRouterProtocol) -> (view:UIViewController, buuton: UIViewController) {
       let view = CalendarViewController(collectionViewLayout: UICollectionViewFlowLayout())
       let networkService = APIUserDataService()
       let networkServiceStatistic = APiStatistikMoneyService()
        
       let presenter = CalendadrPresentor(view: view, networkService: networkService,networkServiceStatistic: networkServiceStatistic, router: router )
       view.presenter = presenter
        let CalendarButtom = createNavController(viewController: view, title: "", selectadImage: #imageLiteral(resourceName: "icons8-календарь-24"), unselectedImage: #imageLiteral(resourceName: "icons8-календарь-24"))
       return (view:view, buuton: CalendarButtom)
    }
    
    func createExpensesModule(router: LoginRouterProtocol) -> (view:UIViewController, buuton: UIViewController)  {
       let view = ExpensesViewController(collectionViewLayout: UICollectionViewFlowLayout())
       let ExpensesButtom = createNavController(viewController: ExpensesViewController(collectionViewLayout: UICollectionViewFlowLayout()), title: "", selectadImage: #imageLiteral(resourceName: "icons8-прибыльность-96"), unselectedImage: #imageLiteral(resourceName: "icons8-прибыльность-96"))
       let networkService = APILoginService()
       let presenter = ExpensesPresentor(view: view, networkService: networkService, router: router)
       view.presenter = presenter
       return (view:view, buuton: ExpensesButtom)
    }
    
    func createStartWorckModule(router: LoginRouterProtocol) -> (view:UIViewController, buuton: UIViewController) {
       let view = StartWorckViewController(collectionViewLayout: UICollectionViewFlowLayout())
       let presenter = StartWorckPresentor(view: view, router: router)
       view.presenter = presenter
       let StartButtom = createNavController(viewController: view, title: "", selectadImage: #imageLiteral(resourceName: "icons8-деньги-48"), unselectedImage: #imageLiteral(resourceName: "icons8-деньги-48"))
       return (view:view, buuton: StartButtom)
    }
    
    func createStatistikModule(router: LoginRouterProtocol) -> (view:UIViewController, buuton: UIViewController) {
       let view = StatistikViewController(collectionViewLayout: UICollectionViewFlowLayout())
       let presenter = StatistikPresentor(view: view, router: router)
       view.presenter = presenter
       let StatistikButtom = createNavController(viewController: view, title: "", selectadImage: #imageLiteral(resourceName: "icons8-статистика-48 (1)"), unselectedImage: #imageLiteral(resourceName: "icons8-статистика-48 (1)"))
       return (view:view, buuton: StatistikButtom)
    }
    
    
    func createNavController(viewController: UIViewController, title: String, selectadImage: UIImage, unselectedImage: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
      //navigationController?.navigationBar.backgroundColor =  .clear
        navController.tabBarItem.title = title       // название в навигешн баре в низу
        viewController.navigationItem.title = title // название в навигешн баре в верху
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectadImage
      //tabBar.barTintColor = .white
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

