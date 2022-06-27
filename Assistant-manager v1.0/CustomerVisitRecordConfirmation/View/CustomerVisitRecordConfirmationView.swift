//
//  CustomerVisitRecordConfirmationView.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/06/2022.
//
import UIKit

class CustomerVisitRecordConfirmationView: UIViewController {
    var presenter: CustomerVisitRecordConfirmationViewPresenterProtocol!
    
    let bodyView: UIView = {
        let body = UIView()
        body.backgroundColor = UIColor.appColor(.blueAssistantFon)
        body.layer.cornerRadius = 20
        return body
    }()
    
    let lineView: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.whiteAssistantwithAlpha)?.withAlphaComponent(0.3)
         return line
    }()
    
    let imageView = CustomUIimageView(frame: .zero)
    
    let nameShurname: UILabel = {
        let Label = UILabel()
        Label.text = "Name Shurname"
        Label.textAlignment = .left
        Label.textColor = UIColor.appColor(.whiteAssistant)
        Label.font = UIFont.systemFont(ofSize: 13)
        Label.numberOfLines = 1
        return Label
    }()
    
    let profession: UILabel = {
        let Label = UILabel()
        Label.text = "Hair staylist"
        Label.textAlignment = .left
        Label.textColor = UIColor.appColor(.whiteAssistant)
        Label.font = UIFont.systemFont(ofSize: 10)
        Label.numberOfLines = 1
        return Label
    }()
    
    lazy var circlForImageClient: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.blueAssistantFon)
        line.layer.cornerRadius = 100
        line.layer.borderColor = UIColor.appColor(.whiteAssistant)?.cgColor
        line.layer.borderWidth = 3
        return line
    }()
    
    lazy var clientImageView = CustomUIimageView(frame: .zero )
    
    lazy var nameClient: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Name Client"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.appColor(.whiteAssistant)
        return label
    }()
    
    let textAddComent: UILabel = {
        let Label = UILabel()
        Label.text = "Add a comment"
        Label.textAlignment = .left
        Label.textColor = UIColor.appColor(.whiteAssistant)?.withAlphaComponent(0.5)
        Label.font = UIFont.systemFont(ofSize: 10)
        Label.numberOfLines = 1
        return Label
    }()
    
    lazy var commitCustomerVisitRecord: UITextView = {
        var text = UITextView()
        text.textAlignment = .center
        text.text = ""
        text.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        text.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)!
        text.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        text.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.withAlphaComponent(0.5).cgColor
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 15
        text.isEditable = true
        return text
    }()
    
    var dateTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Visit date: "
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.appColor(.whiteAssistant)
        return label
    }()
    
    lazy var dataDate: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "2022-06-23 13:30"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.appColor(.whiteAssistant)
        return label
    }()
    
    lazy var stackDate = UIStackView(arrangedSubviews: [dateTextLabel,dataDate])
    
    fileprivate let confirmButton = UIButton.setupButton(title: "Confirm", color: UIColor.appColor(.pinkAssistant)!, activation: true, invisibility: false, laeyerRadius: 12, alpha: 1, textcolor: UIColor.appColor(.whiteAssistant)!.withAlphaComponent(0.9))
// MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupNotificationObserver()
        setupTapGesture()
        hadleres()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
// MARK: - hadleres
    
    fileprivate func hadleres() {
        confirmButton.addTarget(self, action: #selector(saveCustomerVisit), for: .touchUpInside)
    }
// MARK: - configureUI
    
    fileprivate func configureUI() {
        view.addSubview(bodyView)
        bodyView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,pading: .init(top: view.frame.height/9, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: view.frame.height/1.3))
      
        bodyView.addSubview(lineView)
        lineView.anchor(top: bodyView.topAnchor, leading: nil, bottom: nil, trailing: nil, pading: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width/6, height: 6))
        lineView.layer.cornerRadius = 6/2
        lineView.centerXAnchor.constraint(equalTo:  bodyView.centerXAnchor).isActive = true
        
        bodyView.addSubview(imageView)
        imageView.anchor(top: lineView.bottomAnchor, leading: bodyView.leadingAnchor, bottom: nil, trailing: nil, pading: .init(top: view.frame.height/40, left: 8, bottom: 0, right: 0), size: .init(width: 25, height: 25))
            imageView.layer.cornerRadius = 25/2
       
        bodyView.addSubview(nameShurname)
        nameShurname.anchor(top: imageView.topAnchor, leading: imageView.trailingAnchor, bottom: nil, trailing: nil, pading: .init( top: 0, left: 10, bottom: 0, right: 0), size: .init(width: 0, height: 0))
       
        bodyView.addSubview(profession)
        profession.anchor(top: nameShurname.bottomAnchor, leading: nameShurname.leadingAnchor, bottom: nil, trailing: nil, pading: .init( top: 1, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        
        bodyView.addSubview(circlForImageClient)
        circlForImageClient.anchor(top: bodyView.topAnchor, leading: nil, bottom: nil, trailing: nil,pading: .init(top: view.frame.height/8, left: 0, bottom: 0, right: 0),  size: .init(width: 100, height: 100))
        circlForImageClient.layer.cornerRadius = 100 / 2
        circlForImageClient.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true
        
        bodyView.addSubview(clientImageView)
        clientImageView.anchor(top: circlForImageClient.topAnchor, leading: circlForImageClient.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: 10, left: 10, bottom: 0, right: 0),  size: .init(width: 80, height: 80))
        clientImageView.layer.cornerRadius = 80 / 2
        clientImageView.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true //выстовляет по середине экрана
        
        bodyView.addSubview(nameClient)
        nameClient.anchor(top: circlForImageClient.bottomAnchor, leading: nil, bottom: nil, trailing: nil,  pading: .init(top: view.frame.height/80, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 20))
        nameClient.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true
        
        stackDate.axis = .horizontal
        stackDate.spacing = 0
        stackDate.distribution = .equalSpacing
        bodyView.addSubview(stackDate)
        stackDate.anchor(top: nameClient.bottomAnchor, leading: nil, bottom:nil, trailing: nil, pading: .init(top: view.frame.height/80, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        stackDate.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true //выстовляет по середине экрана
        
        bodyView.addSubview(commitCustomerVisitRecord)
        commitCustomerVisitRecord.anchor(top: stackDate.bottomAnchor, leading: bodyView.leadingAnchor, bottom: nil, trailing: bodyView.trailingAnchor,  pading: .init(top: view.frame.height/13, left: 30, bottom: 0, right: 30), size: .init(width: 0, height: view.frame.height/7))
        commitCustomerVisitRecord.centerXAnchor.constraint(equalTo: bodyView.centerXAnchor).isActive = true //выстовляет по середине экрана
        
        bodyView.addSubview(textAddComent)
        textAddComent.anchor(top: nil, leading: nil, bottom: commitCustomerVisitRecord.topAnchor, trailing: nil, pading: .init( top: 0, left: 0, bottom: view.frame.height/80, right: 0), size: .init(width: 0, height: 0))
        textAddComent.centerXAnchor.constraint(equalTo: commitCustomerVisitRecord.centerXAnchor).isActive = true
     
        bodyView.addSubview(confirmButton)
        confirmButton.anchor(top: nil, leading: bodyView.leadingAnchor, bottom: bodyView.bottomAnchor, trailing: bodyView.trailingAnchor, pading: .init(top: 0, left: 50, bottom: view.frame.height/25, right: 50), size: .init(width: 0, height: 40))
    }

    @objc fileprivate func saveCustomerVisit(){
      //  guard let nameServise = nameServise.text?.lowercased() else {return}
      //  guard let timeAtWorkMin = Int(timeAtWorkMin.text ?? "0") else {return}
      //  guard let timeReturnServiseDays = Int(timeReturnServiseDays.text ?? "0") else {return}
      //  guard let priceServies = Double(priceServies.text ?? "0.0") else {return}
        if commitCustomerVisitRecord.text.isEmpty == true {
           commitCustomerVisitRecord.text = ""
        }
        presenter.saveCustomerVisit(commment: commitCustomerVisitRecord.text)
        //presenter.addNewServies(nameServise: nameServise, priceServies: priceServies, timeAtWorkMin: timeAtWorkMin, timeReturnServiseDays: timeReturnServiseDays)
        confirmButton.isEnabled = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.commitCustomerVisitRecord.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.withAlphaComponent(0.5).cgColor
    }
//MARK: - Keyboard
    
    fileprivate func  setupNotificationObserver(){
        // listener up keybord
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardSwow), name: UIResponder.keyboardWillShowNotification, object: nil)
        // listener down keybord
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardSwowHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        //clean keybord from memoey
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    //frame keybord
    @objc fileprivate func handleKeyboardSwow(notification: Notification){
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        //frame keybord
        let keyboardframe = value .cgRectValue
        //how high moving the window be
        let bottomSpace = commitCustomerVisitRecord.frame.height + commitCustomerVisitRecord.frame.height/4
        let difference = keyboardframe.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 15)
    }
    //down keybord
    @objc fileprivate func handleKeyboardSwowHide(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity     // how high moving the window be
        }, completion: nil)
    }
    fileprivate func setupTapGesture(){
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    @objc fileprivate func handleTapDismiss(){
        view.endEditing(true)
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
extension CustomerVisitRecordConfirmationView: CustomerVisitRecordConfirmationViewProtocol {
    func setInfoDate(dateStart: String) {
        dataDate.text = dateStart
    }
    
    func setInfoMaster(image: String, name: String, nameProfesion: String) {
        print("info master")
        imageView.loadImage(with: image )
        nameShurname.text = name
        profession.text = nameProfesion
    }
    
    func setInfoClient(image: String, name: String) {
        print("infoClient")
        clientImageView.loadImage(with: image)
        nameClient.text = name
    }
    
    func succes() {
    }
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertRegistrationControllerMassage(title: "Error", message: error)
    }
}
