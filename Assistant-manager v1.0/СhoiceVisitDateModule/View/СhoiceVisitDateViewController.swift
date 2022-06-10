//
//  СhoiceVisitDateViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 11/06/2022.
//

import UIKit

class ChoiceVisitDateViewController: UIViewController {
    var presenter: СhoiceVisitDatePresenterProtocol!
    
    fileprivate let confirm =  UIButton.setupButton(title: "Confirm", color: UIColor.appColor(.pinkAssistant)!, activation: true, invisibility: false, laeyerRadius: 12, alpha: 1, textcolor: UIColor.appColor(.whiteAssistant)!.withAlphaComponent(0.9))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        configureUI()
        handlers()
    }
    
    func configureUI(){
        view.addSubview(confirm)
        confirm.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 0, left: 20, bottom: 5, right: 20), size: .init(width: 0, height: 40))
    }
    func handlers() {
        confirm.addTarget(self, action: #selector(puchConfirm), for: .touchUpInside)
    }
    @objc fileprivate func puchConfirm(){
        presenter.puchConfirm()
    }

}

extension ChoiceVisitDateViewController{
    func alertMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
}

extension ChoiceVisitDateViewController: СhoiceVisitDateProtocol {
    func succes() {
       print("succes ->ChoiceVisitDateViewController")
    }
    
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertMassage(title: "Error", message: error)
    }

}
