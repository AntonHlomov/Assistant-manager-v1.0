//
//  CustomerVisitRecordConfirmationView.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/06/2022.
//

import UIKit
import SwiftUI

class CustomerVisitRecordConfirmationView: UIViewController {
    var presenter: CustomerVisitRecordConfirmationViewPresenterProtocol!
    
    let bodyView: UIView = {
        let body = UIView()
        body.backgroundColor = UIColor.appColor(.blueAssistantFon)
        body.layer.cornerRadius = 20
        return body
     }()
    
    let  imageView = CustomUIimageView(frame: .zero)
    
    let nameShurname: UILabel = {
        let Label = UILabel()
        Label.text = "Name Shurname"
        Label.textAlignment = .left
        Label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
        Label.font = UIFont.systemFont(ofSize: 13)
        Label.numberOfLines = 1
        return Label
    }()
    let profession: UILabel = {
        let Label = UILabel()
        Label.text = "Hair staylist"
        Label.textAlignment = .left
        Label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
        Label.font = UIFont.boldSystemFont(ofSize: 16)
        Label.numberOfLines = 1
        return Label
    }()
    let status: UILabel = {
        let Label = UILabel()
        Label.text = "Master"
        Label.textAlignment = .left
        Label.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)
        Label.font = UIFont.systemFont(ofSize: 14)
        Label.numberOfLines = 1
        Label.adjustsFontSizeToFitWidth = true
        return Label
    }()
    

    lazy var circlForImageClient: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.blueAssistantFon)
        line.layer.cornerRadius = 100
        line.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
        line.layer.borderWidth = 3
        return line
     }()
    lazy var clientImageView = CustomUIimageView(frame: .zero )
    
    lazy var commitCustomerVisitRecord: UITextView = {
        var text = UITextView()
        text.textAlignment = .left
        text.text = "Add a comment"
        text.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        text.textColor = UIColor.appColor(.whiteAssistantwithAlpha)!
        text.backgroundColor = UIColor.appColor(.blueAssistantFon)
        text.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
        text.layer.borderWidth = 3
        text.layer.cornerRadius = 15
        //нельзя редактировать
        text.isEditable = true
        return text
    }()
    
    lazy var nameClient: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Name Client"
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = UIColor.appColor(.whiteAssistant)
        return label
     }()
    
    fileprivate let saveButton = UIButton.setupButton(title: "Save", color: UIColor.appColor(.pinkAssistant)!, activation: true, invisibility: false, laeyerRadius: 12, alpha: 1, textcolor: UIColor.appColor(.whiteAssistant)!.withAlphaComponent(0.9))


    override func viewDidLoad() {
        super.viewDidLoad()
       // view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        
        configureUI()
        hadleres()

        // Do any additional setup after loading the view.
    }
    fileprivate func hadleres() {
        saveButton.addTarget(self, action: #selector(saveCustomerVisit), for: .touchUpInside)
    }
        // MARK: - configureUI
    fileprivate func configureUI() {
        view.addSubview(bodyView)
        bodyView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor,pading: .init(top: view.frame.height/15, left: view.frame.width/15, bottom: view.frame.height/60, right: view.frame.width/15), size: .init(width: 0, height: 0))
        
        bodyView.addSubview(imageView)
        imageView.anchor(top: bodyView.topAnchor, leading: bodyView.leadingAnchor, bottom: nil, trailing: nil, pading: .init(top: 8, left: 8, bottom: 0, right: 0), size: .init(width: 25, height: 25))
            imageView.layer.cornerRadius = 25/2
       
        bodyView.addSubview(nameShurname)
        nameShurname.anchor(top: imageView.topAnchor, leading: imageView.trailingAnchor, bottom: nil, trailing: nil, pading: .init( top: 0, left: 10, bottom: 0, right: 0), size: .init(width: 0, height: 0))
       
        bodyView.addSubview(profession)
        profession.anchor(top: nameShurname.bottomAnchor, leading: nameShurname.leadingAnchor, bottom: nil, trailing: nil, pading: .init( top: 8, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
           // profession.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        bodyView.addSubview(status)
        status.anchor(top: profession.bottomAnchor, leading: profession.leadingAnchor, bottom: nil, trailing: nil, pading: .init( top: 4, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        
        
        bodyView.addSubview(circlForImageClient)
        circlForImageClient.anchor(top: status.topAnchor, leading: nil, bottom: nil, trailing: nil,pading: .init(top: 20, left: 0, bottom: 0, right: 0),  size: .init(width: 100, height: 100))
        circlForImageClient.layer.cornerRadius = 100 / 2
        circlForImageClient.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true
        
        bodyView.addSubview(clientImageView)
        clientImageView.anchor(top: circlForImageClient.topAnchor, leading: circlForImageClient.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 10, left: 10, bottom: 0, right: 0),  size: .init(width: 80, height: 80))
        clientImageView.layer.cornerRadius = 80 / 2
        clientImageView.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true //выстовляет по середине экрана
        
        bodyView.addSubview(nameClient)
        nameClient.anchor(top: circlForImageClient.bottomAnchor, leading: nil, bottom: nil, trailing: nil,  pading: .init(top: 18, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 20))
        nameClient.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true
        
        bodyView.addSubview(commitCustomerVisitRecord)
        commitCustomerVisitRecord.anchor(top: nameClient.bottomAnchor, leading: bodyView.leadingAnchor, bottom: nil, trailing: bodyView.trailingAnchor,  pading: .init(top: 15, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 100))
        commitCustomerVisitRecord.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true //выстовляет по середине экрана
        
       
        
        bodyView.addSubview(saveButton)
        saveButton.anchor(top: nil, leading: bodyView.leadingAnchor, bottom: bodyView.bottomAnchor, trailing: bodyView.trailingAnchor, pading: .init(top: 0, left: 50, bottom: 15, right: 50), size: .init(width: 0, height: 40))
        
       
        
    }
    
    @objc fileprivate func saveCustomerVisit(){
      //  guard let nameServise = nameServise.text?.lowercased() else {return}
      //  guard let timeAtWorkMin = Int(timeAtWorkMin.text ?? "0") else {return}
      //  guard let timeReturnServiseDays = Int(timeReturnServiseDays.text ?? "0") else {return}
      //  guard let priceServies = Double(priceServies.text ?? "0.0") else {return}
     
        presenter.saveCustomerVisit()
        //presenter.addNewServies(nameServise: nameServise, priceServies: priceServies, timeAtWorkMin: timeAtWorkMin, timeReturnServiseDays: timeReturnServiseDays)
        saveButton.isEnabled = false
  
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.circlForImageClient.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
        self.commitCustomerVisitRecord.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
    }
  
}

extension CustomerVisitRecordConfirmationView{
    func alertRegistrationControllerMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
}

//связывание вью с презентером что бы получать от него ответ и делать какие то действия в вью
extension CustomerVisitRecordConfirmationView: CustomerVisitRecordConfirmationViewProtocol {
    func succes() {
    }
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertRegistrationControllerMassage(title: "Error", message: error)
    }
    
   
    

}