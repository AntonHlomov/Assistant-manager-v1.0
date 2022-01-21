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
    let logoImageViw = UIImageView(image: #imageLiteral(resourceName: "Assistant").withRenderingMode(.alwaysOriginal))
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        logoImageViw.contentMode = .scaleAspectFill

        view.addSubview(logoImageViw)
        logoImageViw.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, pading: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 50))
        logoImageViw.centerInSuperview() //выстовляет по середине экрана
    
    
    }
    override func viewDidAppear(_ animated: Bool) {
        sleep(4)
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





