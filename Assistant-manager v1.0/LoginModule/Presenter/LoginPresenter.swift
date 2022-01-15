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
    func setLoginIndicator(indicator: Bool, error: String)
}

// делаем протокол который завязываемся не на View а нв протоколе LoginViewProtocol и делаем инициализатор которой захватывает ссылку на View принцип  Solid сохряняем уровень абстракции
//inPut
protocol LoginViewPresenterProtocol: class {
   // init(view: LoginViewProtocol,user: User)
    init(view: LoginViewProtocol)
    func showLoginIndicator(emailAuth: String, passwordAuth: String)
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
    
    func showLoginIndicator(emailAuth: String, passwordAuth: String) {
    // здесь делаем бизнес логику
        var indicator = false
        var errForAlert = ""
        Auth.auth().signIn(withEmail: emailAuth, password: passwordAuth) { (user, err) in
            if let err = err {
                print("!!!!!!!Filed to login with error", err.localizedDescription)
                errForAlert = "\(err.localizedDescription)"
                indicator = false
                // здесь презентер говорит вьюхе(абстрактной) что ей сделать
                self.view.setLoginIndicator(indicator: indicator, error: errForAlert)
                return
        }
            print("Successfuly signed user in")
            indicator = true
            // здесь презентер говорит вьюхе(абстрактной) что ей сделать
            self.view.setLoginIndicator(indicator: indicator, error: errForAlert)
        }
    }
}

