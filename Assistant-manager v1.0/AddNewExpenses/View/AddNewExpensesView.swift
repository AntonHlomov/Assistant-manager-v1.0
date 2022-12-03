//
//  AddNewExpensesView.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 29/11/2022.
//
import UIKit

class AddNewExpensesView: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var presenter: AddNewExpensesPresenterProtocol!
    var imageSelected = false
    fileprivate let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "foto"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = UIColor(white: 1, alpha: 0.5)
        return button
    }()
    fileprivate let expenseName = UITextField.setupTextField(title: "Name expense..", hideText: false, enabled: true)
    fileprivate let companyName = UITextField.setupTextField(title: "Name company..", hideText: false, enabled: true)
    fileprivate let category = UITextField.setupTextField(title: "Category expense..", hideText: false, enabled: true)
    fileprivate let priceExpenses = UITextField.setupTextField(title: "Price expense..", hideText: false, enabled: true)
    fileprivate let addButton =    UIButton.setupButton(title: "Add expense", color: UIColor.appColor(.pinkAssistant)!, activation: false, invisibility: false, laeyerRadius: 12, alpha: 0.7, textcolor: UIColor.appColor(.whiteAssistant)!)
    lazy var stackView = UIStackView(arrangedSubviews: [expenseName,companyName,category,priceExpenses])

    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        self.navigationController?.navigationBar.tintColor = UIColor.appColor(.blueAndWhite)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(openCamera))
        configureViewComponents()
        setupTapGesture()
        hadleres()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNotificationObserver()
        NotificationCenter.default.addObserver(self, selector: #selector(handleTapDismiss), name: UIApplication.willResignActiveNotification, object:nil)
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    }
    fileprivate func configureViewComponents(){
        view.addSubview(selectPhotoButton)
        selectPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, pading: .init(top: view.frame.height/15, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.height/6.5, height: view.frame.height/6))
        selectPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true //выстовляет по середине экрана
        selectPhotoButton.layer.cornerRadius = view.frame.height/7 / 2
        view.addSubview(addButton)
        addButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 0, left: 20, bottom: 5, right: 20), size: .init(width: 0, height: 40))   
        stackView.axis = .vertical
        stackView.spacing = view.frame.height/35
        stackView.distribution = .fillEqually  // для корректного отображения
        view.addSubview(stackView)
        stackView.anchor(top: selectPhotoButton.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing:  view.safeAreaLayoutGuide.trailingAnchor, pading: .init(top: view.frame.height/6.5, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: view.frame.height/3))
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    fileprivate func hadleres() {
        expenseName.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        companyName.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        category.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        priceExpenses.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        priceExpenses.keyboardType = .decimalPad
        addButton.addTarget(self, action: #selector(addService), for: .touchUpInside)
        selectPhotoButton.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
    }
    @objc fileprivate func formValidation(){
        guard
            expenseName.hasText,
            companyName.hasText,
            category.hasText,
            priceExpenses.hasText
        else {
            addButton.isEnabled = false
            addButton.backgroundColor = UIColor.appColor(.pinkAssistant)!.withAlphaComponent(0.7)
            return
            }
        addButton.isEnabled = true
        addButton.backgroundColor = UIColor.appColor(.pinkAssistant)
        }
    //MARK: - Add expenses
    @objc fileprivate func addService(){
        self.handleTapDismiss()
        guard let expenseName = expenseName.text?.lowercased() else {return}
        guard let companyName = companyName.text?.lowercased() else {return}
        guard let category = category.text?.lowercased() else {return}
        guard let priceExpenses = priceExpenses.text?.doubleValue else {return}
        guard let imageСheck = self.selectPhotoButton.imageView?.image else {return}
        presenter.add(name: expenseName, place: companyName, category: category, total: Double(priceExpenses), imageСheck:imageСheck)
        addButton.isEnabled = false
    }
    //MARK: - ImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.originalImage] as? UIImage else {
            print("No image found")
            imageSelected = false
            return
        }
        selectPhotoButton.layer.cornerRadius = 12
        selectPhotoButton.layer.masksToBounds = true
        selectPhotoButton.layer.backgroundColor = UIColor.appColor(.geryAssistant)?.cgColor
        selectPhotoButton.layer.borderWidth = 2
        selectPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        imageSelected = true
        formValidation()
        self.dismiss(animated: true, completion: nil)
    }
    @objc func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @objc func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
extension AddNewExpensesView{
    func alertMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
}
extension AddNewExpensesView: AddNewExpensesProtocol{
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertMassage(title: "Error", message: error)
    }
}
