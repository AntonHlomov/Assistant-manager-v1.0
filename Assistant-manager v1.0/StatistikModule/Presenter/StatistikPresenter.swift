//
//  StatistikPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 19/02/2022.
//
import Foundation

protocol StatistikViewProtocol: AnyObject {
    func loadDashboardPage(url: URL)
}

protocol StatistikViewPresenterProtocol: AnyObject {
    init(view: StatistikViewProtocol, apiService: StatistikAPIProtocol, router: LoginRouterProtocol,user: User?)
    func viewDidLoad()
}


class StatistikPresenter: StatistikViewPresenterProtocol {

    
  
    
    weak var view: StatistikViewProtocol?
    let apiService: StatistikAPIProtocol
    var router: LoginRouterProtocol?
    var user: User?
    
    required init(view: StatistikViewProtocol, apiService: StatistikAPIProtocol, router: LoginRouterProtocol,user: User?) {
        self.view = view
        self.apiService = apiService
        self.router = router
        self.user = user
    }
    
    func viewDidLoad() {
        // Можно вызывать API, если нужно получить ссылку динамически
        // Но сейчас у нас статичный URL
        if let url = URL(string: "https://platform.assistantaicall.com/") {
            view?.loadDashboardPage(url: url)
        }
    }
}









/*
import Foundation

protocol StatistikViewProtocol: AnyObject {
    func success()
    func failure(error:Error)
}

protocol StatistikViewPresenterProtocol: AnyObject {
    init(view: StatistikViewProtocol,router: LoginRouterProtocol,user: User?)
    func data()
}

class StatistikPresentor: StatistikViewPresenterProtocol{

    weak var view: StatistikViewProtocol?
    var router: LoginRouterProtocol?
    var user: User?
    
    required init(view: StatistikViewProtocol, router: LoginRouterProtocol,user: User?) {
        self.view = view
        self.router = router
        self.user = user
    }
    func data(){
    }
}
*/
