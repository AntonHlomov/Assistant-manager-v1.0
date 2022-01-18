//
//  ScreensaverViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 18/01/2022.
//

import UIKit

class ScreensaverViewController: UIViewController {
    var indicatorAUTH = false
    var presenter: ScreensaverPresenterProtocol!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.presenter.authCheck()
    }

}

extension ScreensaverViewController: ScreensaverViewProtocol {
    func authScreensaverViewIndicator(indicator: Bool) {
        
        self.indicatorAUTH = indicator
        if indicator == true {
          //  _ = navigationController?.popToRootViewController(animated: true)
            
           //установить рут контролер
           guard let window = UIApplication.shared.keyWindow else {
               return
          }

           guard let rootViewController = window.rootViewController else {
               return
          }

           let vc = MainTabVC()
           vc.view.frame = rootViewController.view.frame
           vc.view.layoutIfNeeded()

           UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
               window.rootViewController = vc
            }, completion: { completed in
               // maybe do something here
           })
            
        } else {
        
            let viewModule = ModelBuilder.createLoginModule()
            navigationController?.pushViewController(viewModule, animated: true)
            }
            
        }
    }





