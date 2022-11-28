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
    
    func createPaymentModule(router: LoginRouterProtocol,customerRecordent: CustomerRecord?, master: Team?, user: User?) -> UIViewController
    
    func createClientsTableModule(router: LoginRouterProtocol, user: User?,markAddMassageReminder: Bool) -> UIViewController
    
    func createPriceModule(router: LoginRouterProtocol,newVisitMode: Bool, client: Client?,user: User?) -> UIViewController
    
    func addNewServiceModule(router: LoginRouterProtocol,editMode: Bool, price: Price?,user: User?) -> UIViewController
    
    func createChoiceVisitDateModule(router:LoginRouterProtocol,serviceCheck: [Price]?,clientCheck: Client?,user: User?) -> UIViewController
    
    func crateCustomerVisitRecordConfirmationModule(router: LoginRouterProtocol,customerVisit: CustomerRecord?,master:Team?,client: Client?,services:[Price]?,user: User?) -> UIViewController
    
    func craateClientPageModule(router:LoginRouterProtocol,client: Client?,user: User?,massage: String?,idReminder:String?,openWithMarkAddMassageReminder: Bool) -> UIViewController
    
    func createAddClientModule(router:LoginRouterProtocol,editMode: Bool, client: Client?,user: User?) -> UIViewController
    
    func createOptionesModule(router: LoginRouterProtocol,user: User?) -> UIViewController
    
    func teamModule(router: LoginRouterProtocol,user: User?) -> UIViewController
    
    func statusSwitchModule(router: LoginRouterProtocol,user: User?) -> UIViewController
    
    func createCalendarModule(router: LoginRouterProtocol,user: User?) -> UIViewController
    
    func createExpensesModule(router: LoginRouterProtocol,user: User?) -> UIViewController
    
    func createStartWorckModule(router: LoginRouterProtocol,user: User?) -> UIViewController
    
    func createStatistikModule(router: LoginRouterProtocol,user: User?) -> UIViewController
   
}
// сборщик
class AsselderModelBuilder: AsselderBuilderProtocol{
    
    func statusSwitchModule(router: LoginRouterProtocol, user: User?) -> UIViewController {
        let view = StatusSwitchTableView()
        let networkService = StatusSwitchApi()
        let presenter = StatusSwitchPresenter(view: view, networkService: networkService, router: router, user: user)
        view.presenter = presenter
        return view
    }
    

    func teamModule(router: LoginRouterProtocol, user: User?) -> UIViewController {
        let view = TeamTableViewController()
        let networkService = ApiTeam()
        let networkServiceAPIGlobalUser = APIGlobalUserService()
        let presenter = TeamPresenter(view: view, networkService: networkService, ruter: router, user: user, networkServiceAPIGlobalUser: networkServiceAPIGlobalUser)
        view.presenter = presenter
        return view
    }
    
    
    func crateCustomerVisitRecordConfirmationModule(router: LoginRouterProtocol,customerVisit: CustomerRecord?,master:Team?,client: Client?,services:[Price]?,user: User?) -> UIViewController {
        let view = CustomerVisitRecordConfirmationView()
        let networkService = APICustomerVisitRecordConfirmation()
        let presenter = CustomerVisitRecordConfirmationViewPresenter(view: view, networkService: networkService, router: router, customerVisit: customerVisit,master:master,client: client,services:services, user: user)
        view.presenter = presenter
        return view
    }
    
  
    
    func addNewServiceModule(router: LoginRouterProtocol, editMode: Bool, price: Price?,user: User?) -> UIViewController {
        let view = AddNewServiceViewController()
        let networkService = ApiAddNewService()
        let presenter = AddNewServicePresenter(view: view, networkService: networkService, ruter: router,editMode: editMode, price: price, user: user)
        view.presenter = presenter
        return view
    }
    
    func createAddClientModule( router: LoginRouterProtocol, editMode: Bool, client: Client?,user: User?) -> UIViewController {
        let view = AddClientView()
        let networkService = ApiAddClient()
        let presenter = AddClientPresenter(view: view, networkService: networkService, router: router,editMode: editMode, client: client, user: user)
        view.presenter = presenter
        return view
    }
    
    func craateClientPageModule(router: LoginRouterProtocol,client: Client?,user: User?,massage: String?,idReminder:String?,openWithMarkAddMassageReminder: Bool) -> UIViewController {
        let view = ClientPage()
        let networkService = ApiAllClientPageDataService()
        let networkServiceTeam = ApiTeam()
        let presenter = ClientPagePresenter(view: view, networkService: networkService, networkServiceTeam: networkServiceTeam,router: router, client: client, user: user, massage: massage,idReminder:idReminder, openWithMarkAddMassageReminder: openWithMarkAddMassageReminder)
        view.presenter = presenter
        return view
    }
    
    
    func createClientsTableModule(router: LoginRouterProtocol, user: User?,markAddMassageReminder: Bool) -> UIViewController {
        let view = ClientsTableViewController()
        let networkService = ApiAllClientsDataService()
        let presenter = ClientsTabPresentor(view: view, networkService: networkService, router: router, user: user, markAddMassageReminder: markAddMassageReminder)
        view.presenter = presenter
        return view
    }
    
    func createPaymentModule(router: LoginRouterProtocol,customerRecordent: CustomerRecord?, master: Team?, user: User?) -> UIViewController {
        let view = PaymentController()
        let networkService = ApiPayment()
        let presenter = PaymentPresenter(view: view, networkService: networkService, router: router, customerRecordent: customerRecordent, master: master,user: user)
        view.presenter = presenter
        return view
    }
    
    func createPriceModule(router: LoginRouterProtocol,newVisitMode: Bool, client: Client?,user: User?) -> UIViewController {
        let view = PriceViewController()
        let networkService = APIPrice()
        let presenter = PricePresenter(view: view, networkService: networkService, ruter: router,newVisitMode: newVisitMode, client: client, user: user)
        view.presenter = presenter
        return view
    }
    
    func createChoiceVisitDateModule(router: LoginRouterProtocol,serviceCheck: [Price]?,clientCheck: Client?,user: User?) -> UIViewController {
        let view = ChoiceVisitDateViewController()
        let networkService = ApiСhoiceVisitDate()
        let presenter = СhoiceVisitDatePresenter(view: view, networkService:networkService, ruter:router,serviceCheck: serviceCheck,clientCheck: clientCheck, user: user)
        view.presenter = presenter
        return view
    }
    
    func createOptionesModule(router: LoginRouterProtocol,user: User?) -> UIViewController {
        let view = OptionesController()
        let networkService = APIOptionesDataService()
        let networkServiceAPIGlobalUser = APIGlobalUserService()
        let presenter = OptionesViewPresentor(view: view, networkService: networkService, router: router, user: user,networkServiceAPIGlobalUser: networkServiceAPIGlobalUser)
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
    
    func createCalendarModule(router: LoginRouterProtocol,user: User?) -> UIViewController {
       let view = CalendarViewController(collectionViewLayout: UICollectionViewFlowLayout())
       let networkService = APIUserDataService()
       let networkServiceStatistic = APiStatistikMoneyService()
       let networkServiceUser = APIGlobalUserService()
       let networkServiceTeam = ApiTeam()
        
        let presenter = CalendadrPresentor(view: view, networkService: networkService,networkServiceStatistic: networkServiceStatistic,networkServiceUser: networkServiceUser, router: router, user: user, networkServiceTeam: networkServiceTeam )
       view.presenter = presenter
       return view
    }
    
    func createExpensesModule(router: LoginRouterProtocol,user: User?) -> UIViewController  {
       let view = ExpensesViewController(collectionViewLayout: UICollectionViewFlowLayout())
       let networkService = APILoginService()
        let presenter = ExpensesPresentor(view: view, networkService: networkService, router: router, user: user)
       view.presenter = presenter
       return view
    }
    
    func createStartWorckModule(router: LoginRouterProtocol,user: User?) -> UIViewController {
       let view = StartWorckViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let networkService = ApiCustomerCardPaymentToday()
        let networkServiceTeam = ApiTeam()
        let networkServiceUser = APIGlobalUserService()
        let presenter = StartWorckPresentor(view: view, router: router, networkService: networkService, user: user, networkServiceTeam: networkServiceTeam, networkServiceUser: networkServiceUser)
        view.presenter = presenter
       return view
    }
    
    func createStatistikModule(router: LoginRouterProtocol,user: User?) -> UIViewController {
       let view = StatistikViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let presenter = StatistikPresentor(view: view, router: router, user: user)
        view.presenter = presenter
       return view
    }

}
