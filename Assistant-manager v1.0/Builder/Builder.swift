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
    
    func createPaymentModule(router: LoginRouterProtocol,customerRecordent: CustomerRecord?, master: Team?) -> UIViewController
    
    func createClientsTableModule(router: LoginRouterProtocol) -> UIViewController
    
    func createPriceModule(router: LoginRouterProtocol,newVisitMode: Bool, client: Client?) -> UIViewController
    
    func addNewServiceModule(router: LoginRouterProtocol,editMode: Bool, price: Price?) -> UIViewController
    
    func createChoiceVisitDateModule(router:LoginRouterProtocol,serviceCheck: [Price]?,clientCheck: Client?) -> UIViewController
    
    func crateCustomerVisitRecordConfirmationModule(router: LoginRouterProtocol,customerVisit: CustomerRecord?,master:Team?,client: Client?,services:[Price]?) -> UIViewController
    
    func craateClientPageModule(router:LoginRouterProtocol,client: Client?) -> UIViewController
    
    func createAddClientModule(router:LoginRouterProtocol,editMode: Bool, client: Client?) -> UIViewController
    
    func createOptionesModule(router: LoginRouterProtocol,user: User?) -> UIViewController
    
    func createCalendarModule(router: LoginRouterProtocol) -> (view:UIViewController, buuton: UIViewController)
    func createExpensesModule(router: LoginRouterProtocol) -> (view:UIViewController, buuton: UIViewController)
    func createStartWorckModule(router: LoginRouterProtocol) -> (view:UIViewController, buuton: UIViewController)
    func createStatistikModule(router: LoginRouterProtocol) -> (view:UIViewController, buuton: UIViewController)
   
}
// сборщик
class AsselderModelBuilder: AsselderBuilderProtocol{
    
    func crateCustomerVisitRecordConfirmationModule(router: LoginRouterProtocol,customerVisit: CustomerRecord?,master:Team?,client: Client?,services:[Price]?) -> UIViewController {
        let view = CustomerVisitRecordConfirmationView()
        let networkService = APICustomerVisitRecordConfirmation()
        let presenter = CustomerVisitRecordConfirmationViewPresenter(view: view, networkService: networkService, router: router, customerVisit: customerVisit,master:master,client: client,services:services)
        view.presenter = presenter
        return view
    }
    
  
    
    func addNewServiceModule(router: LoginRouterProtocol, editMode: Bool, price: Price?) -> UIViewController {
        let view = AddNewServiceViewController()
        let networkService = ApiAddNewService()
        let presenter = AddNewServicePresenter(view: view, networkService: networkService, ruter: router,editMode: editMode, price: price)
        view.presenter = presenter
        return view
    }
    
    func createAddClientModule( router: LoginRouterProtocol, editMode: Bool, client: Client?) -> UIViewController {
        let view = AddClientView()
        let networkService = ApiAddClient()
        let presenter = AddClientPresenter(view: view, networkService: networkService, router: router,editMode: editMode, client: client)
        view.presenter = presenter
        return view
    }
    
    func craateClientPageModule(router: LoginRouterProtocol,client: Client?) -> UIViewController {
        let view = ClientPage()
        let networkService = ApiAllClientPageDataService()
        let presenter = ClientPagePresenter(view: view, networkService: networkService,router: router, client: client)
        view.presenter = presenter
        return view
    }
    
    
    func createClientsTableModule(router: LoginRouterProtocol) -> UIViewController {
        let view = ClientsTableViewController()
        let networkService = ApiAllClientsDataService()
        let presenter = ClientsTabPresentor(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createPaymentModule(router: LoginRouterProtocol,customerRecordent: CustomerRecord?, master: Team?) -> UIViewController {
        let view = PaymentController()
        let networkService = ApiPayment()
        let presenter = PaymentPresenter(view: view, networkService: networkService, router: router, customerRecordent: customerRecordent, master: master)
        view.presenter = presenter
        return view
    }
    
    func createPriceModule(router: LoginRouterProtocol,newVisitMode: Bool, client: Client?) -> UIViewController {
        let view = PriceViewController()
        let networkService = APIPrice()
        let presenter = PricePresenter(view: view, networkService: networkService, ruter: router,newVisitMode: newVisitMode, client: client)
        view.presenter = presenter
        return view
    }
    
    func createChoiceVisitDateModule(router: LoginRouterProtocol,serviceCheck: [Price]?,clientCheck: Client?) -> UIViewController {
        let view = ChoiceVisitDateViewController()
        let networkService = ApiСhoiceVisitDate()
        let presenter = СhoiceVisitDatePresenter(view: view, networkService:networkService, ruter:router,serviceCheck: serviceCheck,clientCheck: clientCheck)
        view.presenter = presenter
        return view
    }
    
    func createOptionesModule(router: LoginRouterProtocol,user: User?) -> UIViewController {
        let view = OptionesController()
        let networkService = APIOptionesDataService()
        let presenter = OptionesViewPresentor(view: view, networkService: networkService, router: router, user: user)
        view.presenter = presenter
        return view
    }
    
    func createLoginModule(router: LoginRouterProtocol) -> UIViewController {
        let view = LoginControler()
        let networkService = APILoginService()
        let networkServiceGlobalUser = APIGlobalUserService()
        let presenter = LoginPresentor(view: view, networkService: networkService, router: router, networkServiceGlobalUser: networkServiceGlobalUser)
        view.presenter = presenter
        return view
    }
    
    func createRegistrationModule(router: LoginRouterProtocol) -> UIViewController {
        let view = RegistrationController()
        let networkService = APIRegistrationService()
        let networkServiceGlobalUser = APIGlobalUserService()
        let presenter = RegistrationPresentor(view: view, networkService: networkService,router: router,networkServiceGlobalUser: networkServiceGlobalUser)
        view.presenter = presenter
        return view
    }
    
     func createScreensaverModule(router: LoginRouterProtocol) -> UIViewController {
        let view = ScreensaverViewController()
        let networkService = APIGlobalUserService()
        let presenter = ScreensaverPresentor(view: view, router: router, networkService:networkService)
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
        let networkService = ApiCustomerCardPaymentToday()
        let presenter = StartWorckPresentor(view: view, router: router, networkService: networkService)
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
        navController.navigationBar.isHidden = true
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

