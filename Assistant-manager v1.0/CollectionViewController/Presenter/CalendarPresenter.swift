//
//  CalendarPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 29/01/2022.
//

import Foundation

// отправляет сообщение LoginView о входе  и не входе (аунтификация пользователя)
//outPut
protocol CalendadrViewProtocol: AnyObject {
    //func setLoginIndicator(indicator: Bool, error: String)
}

// делаем протокол который завязываемся не на View а нв протоколе LoginViewProtocol и делаем инициализатор которой захватывает ссылку на View принцип  Solid сохряняем уровень абстракции
//inPut
protocol CalendadrViewPresenterProtocol: AnyObject {
   // init(view: LoginViewProtocol,user: User)
    init(view: CalendadrViewProtocol)
   // func showLoginIndicator(emailAuth: String, passwordAuth: String)
}

// заввязываемся на протоколе
class CalendadrPresentor: CalendadrViewPresenterProtocol{
    var view: CalendadrViewProtocol?
    required init(view: CalendadrViewProtocol) {
        self.view = view
    }
   // let user: User
   // required init(view: LoginViewProtocol, user: User)
  
}