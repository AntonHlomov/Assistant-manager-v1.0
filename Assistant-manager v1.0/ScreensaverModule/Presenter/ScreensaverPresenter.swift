//
//  ScreensaverPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 18/01/2022.
//

import Foundation
import Firebase

//outPut
protocol ScreensaverViewProtocol: AnyObject {
    func authScreensaverViewIndicator(indicator: Bool)
}

//inPut
protocol ScreensaverPresenterProtocol: AnyObject {
    init(view: ScreensaverViewProtocol)
    func authCheck()
}

class ScreensaverPresentor: ScreensaverPresenterProtocol{
    let view: ScreensaverViewProtocol?
    
    required init(view: ScreensaverViewProtocol) {
        self.view = view
    }
    
    func authCheck() {
       
        if Auth.auth().currentUser != nil{
            self.view?.authScreensaverViewIndicator(indicator: true)
            print(Auth.auth().currentUser ?? "")
        } else {
            self.view?.authScreensaverViewIndicator(indicator: false)
        }
    }
}
