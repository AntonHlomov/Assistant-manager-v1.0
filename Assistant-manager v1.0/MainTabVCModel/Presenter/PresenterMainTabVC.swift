//
//  PresenterMainTabVC.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 16/02/2022.
//

import Foundation


protocol MainTabVCProtocol: AnyObject {

}
protocol MainTabVCPresenterProtocol: AnyObject {
    init(view: MainTabVCProtocol, router: LoginRouterProtocol)
}
class MainTabVCPresentor: MainTabVCPresenterProtocol{

    weak var view: MainTabVCProtocol?
    var router: LoginRouterProtocol?

    required init(view: MainTabVCProtocol, router: LoginRouterProtocol) {
        self.router = router
        self.view = view
    }





}
