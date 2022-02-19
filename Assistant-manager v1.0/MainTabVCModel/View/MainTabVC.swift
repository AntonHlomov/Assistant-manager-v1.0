//
//  MainTabVC.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 18/01/2022.
//

import UIKit

class MainTabVC: UITabBarController, UITabBarControllerDelegate {
   
  //  var presenter: MainTabVCPresenterProtocol!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBar.tintColor = UIColor.rgb(red: 245, green: 196, blue: 80)// цвет шрифта в таб баре
        tabBar.unselectedItemTintColor = UIColor.rgb(red: 245, green: 196, blue: 80)// цвет шрифта в таб баре
        
        // функция кнопки навинатора
        configure()
    }
    
    func configure()  {
        //Календарь
        let CalendarButtom = createNavController(viewController: CalendarViewController(collectionViewLayout: UICollectionViewFlowLayout()), title: "", selectadImage: #imageLiteral(resourceName: "icons8-календарь-24"), unselectedImage: #imageLiteral(resourceName: "icons8-календарь-24"))
        //Рассходы
        let ExpensesButtom = createNavController(viewController: ExpensesViewController(collectionViewLayout: UICollectionViewFlowLayout()), title: "", selectadImage: #imageLiteral(resourceName: "icons8-прибыльность-96"), unselectedImage: #imageLiteral(resourceName: "icons8-прибыльность-96"))
        //В работе      касса
        let StartButtom = createNavController(viewController: StartWorckViewController(collectionViewLayout: UICollectionViewFlowLayout()), title: "", selectadImage: #imageLiteral(resourceName: "icons8-деньги-48"), unselectedImage: #imageLiteral(resourceName: "icons8-деньги-48"))
        //Стстистика
        let StatistikButtom = createNavController(viewController: StatistikViewController(collectionViewLayout: UICollectionViewFlowLayout()), title: "", selectadImage: #imageLiteral(resourceName: "icons8-статистика-48 (1)"), unselectedImage: #imageLiteral(resourceName: "icons8-статистика-48 (1)"))
         viewControllers = [CalendarButtom, ExpensesButtom,  StartButtom, StatistikButtom]
      
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, selectadImage: UIImage, unselectedImage: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        self.navigationController?.navigationBar.backgroundColor =  .clear
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
//
//extension MainTabVC: MainTabVCProtocol {
//
//}
