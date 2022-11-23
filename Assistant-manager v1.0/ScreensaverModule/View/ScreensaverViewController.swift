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
       self.presenter.authCheck()
      
        
    }
}
extension ScreensaverViewController{
    func alertMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
    
 
}

extension ScreensaverViewController: ScreensaverViewProtocol {
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertMassage(title: "Error", message: error)
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
