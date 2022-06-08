//
//  PriceViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 08/06/2022.
//

import UIKit

class PriceViewController: UIViewController {
    var presenter: PriceProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
extension PriceViewController{
    func alertMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
}

extension PriceViewController: PriceProtocol {
    func succesReloadTable() {
        // tableView.reloadData()
    }
    
    func filure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertMassage(title: "Error", message: error)
    }
    
   
    

}
