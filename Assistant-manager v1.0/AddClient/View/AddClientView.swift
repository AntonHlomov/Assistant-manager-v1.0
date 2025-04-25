//
//  AddClientView.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 03/06/2022.
//
import UIKit

class AddClientView: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var presenter: AddClientViewPresenterProtocol!
    var imageSelected = false
    var gender = ""
    fileprivate let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
      //  button.backgroundColor = .white
        button.backgroundColor = UIColor.appColor(.blueAssistantFon)
        button.setTitleColor(.gray, for: .normal)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.appColor(.blueAndPink)!.withAlphaComponent(0.7).cgColor
        return button
    }()
    @objc fileprivate func selectPhoto(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    fileprivate let fullNameTexfield = UITextField.setupTextField(title: "Surname..", hideText: false, enabled: true)
    fileprivate let nameTexfield = UITextField.setupTextField(title: "Name..", hideText: false, enabled: true)
    fileprivate let ageClientTexfield = UITextField.setupTextField(title: "Approximate age..", hideText: false, enabled: true)
    fileprivate let telefonTexfield = UITextField.setupTextField(title: "Phone number..", hideText: false, enabled: true)
    fileprivate let textClientTexfield = UITextField.setupTextField(title: "Information about the client..", hideText: false, enabled: true)
    
    lazy var maleButton: UIButton = {
       let button = UIButton(type: .system)
        var attributedTitle = NSMutableAttributedString(string: "male", attributes: [.font:UIFont.systemFont (ofSize: 18), .foregroundColor: UIColor.appColor(.geryAssistant)!.withAlphaComponent(0.4) ])
          button.setAttributedTitle(attributedTitle, for: .normal)
          button.addTarget(self, action: #selector(checkMale), for: .touchUpInside)
          return button
      }()
    lazy var femaleButton: UIButton = {
        let button = UIButton(type: .system)
        var attributedTitle = NSMutableAttributedString(string: "female", attributes: [.font:UIFont.systemFont (ofSize: 18), .foregroundColor: UIColor.appColor(.geryAssistant)!.withAlphaComponent(0.4) ])
            button.setAttributedTitle(attributedTitle, for: .normal)
            button.addTarget(self, action: #selector(checkFemale), for: .touchUpInside)
            return button
    }()
    fileprivate let addButton =    UIButton.setupButton(title: "Add", color: UIColor.appColor(.pinkAssistant)!, activation: false, invisibility: false, laeyerRadius: 12, alpha: 0.7, textcolor: UIColor.appColor(.whiteAssistant)!)
    lazy var genderStack = UIStackView(arrangedSubviews: [maleButton,femaleButton])
    lazy var stackView = UIStackView(arrangedSubviews: [nameTexfield,fullNameTexfield,ageClientTexfield,telefonTexfield,textClientTexfield,genderStack,addButton])

    override func viewDidLoad() {
        super.viewDidLoad()
      //  view.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTapDismiss), name: UIApplication.willResignActiveNotification, object:nil)
        self.navigationController?.navigationBar.tintColor = UIColor.appColor(.blueAndWhite)
        configureViewComponents()
        setupNotificationObserver()
        setupTapGesture()
        hadleres()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.selectPhotoButton.layer.borderColor = UIColor.appColor(.blueAndPink)?.withAlphaComponent(0.7).cgColor
    }
    fileprivate func configureViewComponents(){
        view.addSubview(selectPhotoButton)
        selectPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, pading: .init(top: view.frame.height/48, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.height/3.9, height: view.frame.height/3.9))
        selectPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true //выстовляет по середине экрана
        selectPhotoButton.layer.cornerRadius = view.frame.height/3.9 / 2
        
        genderStack.axis = .horizontal
        genderStack.spacing = 20
        genderStack.distribution = .fillEqually
        
        stackView.axis = .vertical
        stackView.spacing = view.frame.height/35
        stackView.distribution = .fillEqually  // для корректного отображения
        view.addSubview(stackView)
        stackView.anchor(top: selectPhotoButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, pading: .init(top: view.frame.height/12, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: view.frame.height/2.1))
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {
            imageSelected = false
            return
        }
        selectPhotoButton.layer.cornerRadius = selectPhotoButton.frame.width / 2
        selectPhotoButton.layer.masksToBounds = true
        selectPhotoButton.layer.backgroundColor = UIColor.black.cgColor
        selectPhotoButton.layer.borderWidth = 2
        selectPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        imageSelected = true
        formValidation()
        self.dismiss(animated: true, completion: nil)
    }
    fileprivate func hadleres() {
        nameTexfield.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        fullNameTexfield.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        ageClientTexfield.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        ageClientTexfield.keyboardType = .numberPad
        telefonTexfield.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        telefonTexfield.keyboardType = .phonePad
        textClientTexfield.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        //selectPhotoButton.addTarget(self, action: #selector(formValidation), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addClient), for: .touchUpInside)
        selectPhotoButton.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
       
    }
    @objc fileprivate func formValidation(){
        guard
            nameTexfield.hasText,
            telefonTexfield.hasText,
            fullNameTexfield.hasText,
            imageSelected == true,
            gender != ""
        else {
            addButton.isEnabled = false
            addButton.backgroundColor = UIColor.appColor(.pinkAssistant)!.withAlphaComponent(0.7)
            return
            }
        addButton.isEnabled = true
        addButton.backgroundColor = UIColor.appColor(.pinkAssistant)
        }
    @objc fileprivate func addClient(){
        self.handleTapDismiss()
        guard let name = nameTexfield.text?.lowercased() else {return}
        guard let fullName = fullNameTexfield.text?.lowercased() else {return}
        guard let ageClient = Int(ageClientTexfield.text ?? "0") else {return}
        guard let telefon = telefonTexfield.text else {return}
        guard let profileImage = self.selectPhotoButton.imageView?.image else {return}
        guard let textClient = textClientTexfield.text else {return}
        presenter.addClient(nameClient: name, fullName: fullName, telefonClient: telefon, profileImageClient: profileImage, genderClient: self.gender, ageClient: ageClient, textAboutClient: textClient)
        addButton.isEnabled = false
    }
    @objc fileprivate func checkMale(){
        let attributedTitleM = NSMutableAttributedString(string: "male", attributes: [.font:UIFont.systemFont (ofSize: 18), .foregroundColor: UIColor.appColor(.blueAssistant)!])
        let attributedTitleFm = NSMutableAttributedString(string: "female", attributes: [.font:UIFont.systemFont (ofSize: 18), .foregroundColor: UIColor.appColor(.geryAssistant)!.withAlphaComponent(0.4) ])
        self.femaleButton.setAttributedTitle(attributedTitleFm, for: .normal)
        self.maleButton.setAttributedTitle(attributedTitleM, for: .normal)
        gender = "male"
        formValidation()
    }
    @objc fileprivate func checkFemale(){
        let attributedTitleM = NSMutableAttributedString(string: "male", attributes: [.font:UIFont.systemFont (ofSize: 18), .foregroundColor: UIColor.appColor(.geryAssistant)!.withAlphaComponent(0.4)])
        let attributedTitleFm = NSMutableAttributedString(string: "female", attributes: [.font:UIFont.systemFont (ofSize: 18), .foregroundColor: UIColor.appColor(.blueAssistant)! ])
        self.femaleButton.setAttributedTitle(attributedTitleFm, for: .normal)
        self.maleButton.setAttributedTitle(attributedTitleM, for: .normal)
        gender = "female"
        formValidation()
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

extension AddClientView{
    func alertRegistrationControllerMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
}

extension AddClientView: AddClientViewProtocol{
    func setClientForEditMode(client: Client?) {
        print(client?.nameClient ?? "")
        let  clientImageView = CustomUIimageView(frame: .zero)
        clientImageView.loadImage(with: client?.profileImageClientUrl ?? "")
        guard let clientname = client?.nameClient else {return}
        guard let fullname = client?.fullName else {return}
        guard let ageClient = client?.ageClient else {return}
        guard let telefonclient = client?.telefonClient else {return}
        guard let textAboutClient = client?.textAboutClient else {return}
        guard let genderClient = client?.genderClient else {return}
        
        self.nameTexfield.text = clientname.capitalized
        self.fullNameTexfield.text = fullname.capitalized
        self.ageClientTexfield.text = String(ageClient)
        self.telefonTexfield.text = telefonclient
        self.textClientTexfield.text = textAboutClient
        self.gender = genderClient
        switch self.gender {
        case "male": checkMale()
        case "female": checkFemale()
        default:
            return
        }
        self.selectPhotoButton.setImage(clientImageView.image?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectPhotoButton.layer.cornerRadius = selectPhotoButton.frame.width / 2
        selectPhotoButton.layer.masksToBounds = true
        selectPhotoButton.layer.borderWidth = 2
        self.imageSelected = true
        self.addButton.setTitle("Save", for: .normal)
        formValidation()
    }
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertRegistrationControllerMassage(title: "Error", message: error)
    }
}
