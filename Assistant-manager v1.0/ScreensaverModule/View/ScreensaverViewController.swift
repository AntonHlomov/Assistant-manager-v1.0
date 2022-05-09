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
        sleep(1)
        self.presenter.authCheck()
    }
}

extension ScreensaverViewController: ScreensaverViewProtocol {
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }

}
