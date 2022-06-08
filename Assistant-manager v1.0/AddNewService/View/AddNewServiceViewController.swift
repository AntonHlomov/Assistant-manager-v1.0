//
//  AddNewServiceViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 09/06/2022.
//

import UIKit

class AddNewServiceViewController: UIViewController {
    var presenter: AddNewServicePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
    }
    

    

}
extension AddNewServiceViewController{
    func alertMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
}
extension AddNewServiceViewController: AddNewServiceProtocol{
    func succes() {
        print("succes")
    }
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertMassage(title: "Error", message: error)
    }
}

