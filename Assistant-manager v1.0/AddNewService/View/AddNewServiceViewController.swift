//
//  AddNewServiceViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 09/06/2022.
//
import UIKit

class AddNewServiceViewController: UIViewController {
    var presenter: AddNewServicePresenterProtocol!
    fileprivate let nameServise = UITextField.setupTextField(title: "Name servise..", hideText: false, enabled: true)
    fileprivate let timeAtWorkMin = UITextField.setupTextField(title: "Service execution time(min)..", hideText: false, enabled: true)
    fileprivate let timeReturnServiseDays = UITextField.setupTextField(title: "After how many days to repeat the service..", hideText: false, enabled: true)
    fileprivate let priceServies = UITextField.setupTextField(title: "Price servies..", hideText: false, enabled: true)
    fileprivate let addButton =    UIButton.setupButton(title: "Add", color: UIColor.appColor(.pinkAssistant)!, activation: false, invisibility: false, laeyerRadius: 12, alpha: 0.7, textcolor: UIColor.appColor(.whiteAssistant)!)
    lazy var stackView = UIStackView(arrangedSubviews: [nameServise,timeAtWorkMin,timeReturnServiseDays,priceServies])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        configureViewComponents()
        setupNotificationObserver()
        setupTapGesture()
        hadleres()
    }
    fileprivate func configureViewComponents(){
        view.addSubview(addButton)
        addButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 0, left: 20, bottom: 5, right: 20), size: .init(width: 0, height: 40))
        stackView.axis = .vertical
        stackView.spacing = view.frame.height/35
        stackView.distribution = .fillEqually  // для корректного отображения
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing:  view.safeAreaLayoutGuide.trailingAnchor, pading: .init(top: view.frame.height/5, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: view.frame.height/3))
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    fileprivate func hadleres() {
        nameServise.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        timeAtWorkMin.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        timeAtWorkMin.keyboardType = .numberPad
        timeReturnServiseDays.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        timeReturnServiseDays.keyboardType = .numberPad
        priceServies.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        priceServies.keyboardType = .decimalPad
        addButton.addTarget(self, action: #selector(addService), for: .touchUpInside)
    }
    @objc fileprivate func formValidation(){
        guard
            nameServise.hasText,
            timeAtWorkMin.hasText,
            timeReturnServiseDays.hasText,
            priceServies.hasText
                
        else {
            addButton.isEnabled = false
            addButton.backgroundColor = UIColor.appColor(.pinkAssistant)!.withAlphaComponent(0.7)
            return
            }
        addButton.isEnabled = true
        addButton.backgroundColor = UIColor.appColor(.pinkAssistant)
        }
    @objc fileprivate func addService(){
        guard let nameServise = nameServise.text?.lowercased() else {return}
        guard let timeAtWorkMin = Int(timeAtWorkMin.text ?? "0") else {return}
        guard let timeReturnServiseDays = Int(timeReturnServiseDays.text ?? "0") else {return}
        guard let priceServies = priceServies.text?.doubleValue else {return}
        presenter.addNewServies(nameServise: nameServise, priceServies: Double(priceServies), timeAtWorkMin: timeAtWorkMin, timeReturnServiseDays: timeReturnServiseDays)
        addButton.isEnabled = false
    }
    //MARK: - Клавиатура
    fileprivate func  setupNotificationObserver(){
        // следит когда подниметься клавиатура
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardSwow), name: UIResponder.keyboardWillShowNotification, object: nil)
        // следит когда опускаеться
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardSwowHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
   override func viewWillDisappear(_ animated: Bool) {      //очищает клавиатуру из памяти обязательно делать если вызываешь клаву
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    //размеры клавиатуры
    @objc fileprivate func handleKeyboardSwow(notification: Notification){
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardframe = value .cgRectValue    //рамка клавиатуры
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height        //на сколько должна сдвинуть интерфейс
        let difference = keyboardframe.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 15)
    }
    //опускание клавиатуры
    @objc fileprivate func handleKeyboardSwowHide(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity     // интерфейс опускаеться в низ
        }, completion: nil)
    }
    fileprivate func setupTapGesture(){
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    @objc fileprivate func handleTapDismiss(){
        view.endEditing(true)
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
    func setPriceForEditMode(price: Price?) {
        guard let nameServise = price?.nameServise else {return}
        guard let timeAtWorkMin = price?.timeAtWorkMin else {return}
        guard let timeReturnServiseDays = price?.timeReturnServiseDays else {return}
        guard let priceServies = price?.priceServies else {return}        
        self.nameServise.text = nameServise.capitalized
        self.timeAtWorkMin.text = String(timeAtWorkMin)
        self.timeReturnServiseDays.text = String(timeReturnServiseDays)
        self.priceServies.text = String(priceServies)
        self.addButton.setTitle("Save", for: .normal)
        formValidation()
    }
    func succes() {
        print("succes")
    }
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertMassage(title: "Error", message: error)
    }
}

