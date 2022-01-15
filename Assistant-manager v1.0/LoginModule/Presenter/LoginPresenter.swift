//
//  LoginPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//

import Foundation
import Firebase

// отправляет сообщение LoginView о входе  и не входе (аунтификация пользователя)
//outPut
protocol LoginViewProtocol: class {
    func setLoginIndicator(indicator: Bool)
}

// делаем протокол который завязываемся не на View а нв протоколе LoginViewProtocol и делаем инициализатор которой захватывает ссылку на View принцип  Solid сохряняем уровень абстракции
//inPut
protocol LoginViewPresenterProtocol: class {
   // init(view: LoginViewProtocol,user: User)
    init(view: LoginViewProtocol)
    func showLoginIndicator()
}
// заввязываемся на протоколе
class LoginPresentor: LoginViewPresenterProtocol{
    let view: LoginViewProtocol
   // let user: User
   // required init(view: LoginViewProtocol, user: User)
    required init(view: LoginViewProtocol) {
        self.view = view
       // self.user = user
    }
    
    func showLoginIndicator() {
    // здесь делаем бизнес логику
        let indicator = true
    // здесь презентер говорит вьюхе(абстрактной) что ей сделать
        self.view.setLoginIndicator(indicator: indicator)
    }
    
    
}

