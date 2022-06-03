//
//  AddClientView.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 03/06/2022.
//

import UIKit

class AddClientView: UIViewController {
    var presenter: AddClientViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.grenAssistant)

    }
    


}

extension AddClientView: AddClientViewProtocol{
    func succes() {
        print("succes")
    }
    
    func failure(error: Error) {
        print("failure")
    }
  
}
