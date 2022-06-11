//
//  СhoiceVisitDateViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 11/06/2022.
//

import UIKit

class ChoiceVisitDateViewController: UIViewController {
    var presenter: СhoiceVisitDatePresenterProtocol!
    
    let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
    }()
    let scrollViewContainer: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.spacing = 10
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
    }()
    let redView: UIView = {
    let view = UIView()
   // view.heightAnchor.constraint(equalToConstant: 500).isActive = true
    view.backgroundColor = .red
    return view
    }()
    let blueView: UIView = {
    let view = UIView()
    //view.heightAnchor.constraint(equalToConstant: 200).isActive = true
    view.backgroundColor = .blue
    return view
    }()
    let greenView: UIView = {
    let view = UIView()
   // view.heightAnchor.constraint(equalToConstant: 1200).isActive = true
    view.backgroundColor = .green
    return view
    }()
    
    fileprivate let confirm =  UIButton.setupButton(title: "Confirm", color: UIColor.appColor(.pinkAssistant)!, activation: true, invisibility: false, laeyerRadius: 12, alpha: 1, textcolor: UIColor.appColor(.whiteAssistant)!.withAlphaComponent(0.9))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        configureUI()
        handlers()
    }
    
    func configureUI(){
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0))
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollViewContainer.addArrangedSubview(redView)
        redView.anchor(top: nil, leading: scrollViewContainer.leadingAnchor, bottom: nil, trailing: scrollViewContainer.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: scrollViewContainer.frame.width, height: view.frame.height/8))
        
        scrollViewContainer.addArrangedSubview(blueView)
        blueView.anchor(top: redView.bottomAnchor, leading: scrollViewContainer.leadingAnchor, bottom: nil, trailing: scrollViewContainer.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: scrollViewContainer.frame.width, height: view.frame.height/3))
        
        scrollViewContainer.addArrangedSubview(greenView)
        greenView.anchor(top: blueView.bottomAnchor, leading: scrollViewContainer.leadingAnchor, bottom: scrollViewContainer.safeAreaLayoutGuide.bottomAnchor, trailing: scrollViewContainer.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: scrollViewContainer.frame.width, height:view.frame.height/1.7))
        
        
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
