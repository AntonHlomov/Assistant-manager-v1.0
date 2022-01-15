//
//  LoginControler.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//

import UIKit



class LoginControler: UIViewController {
    
    var indicatorLogin = false
    
    // подключаемся к презентеру через протокол чтобы передавать нажатия итд из этого view
    var presenter: LoginViewPresenterProtocol!

    
    //MARK: - Properties Headter
    private let logoContainerView: UIView = {
        let view = UIView()
        let logoImageViw = UIImageView(image: #imageLiteral(resourceName: "Assistant").withRenderingMode(.alwaysOriginal))
        let zigzagImageView = UIImageView(image: #imageLiteral(resourceName: "BlueFonZigZag").withRenderingMode(.alwaysOriginal))
        logoImageViw.contentMode = .scaleAspectFill
        view.addSubview(zigzagImageView)
        view.addSubview(logoImageViw)
        zigzagImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0)) // примагничиваем "зигзаг" к краям
        zigzagImageView.centerInSuperview()
        logoImageViw.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, pading: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 50))
        logoImageViw.centerInSuperview()
        view.backgroundColor = UIColor.init(white: 0, alpha: 0)
        return view
    }()
    //MARK: - Properties Body
    private let textEnter: UILabel = {
        let text = UILabel()
        text.text = "Login"
        text.tintColor = .darkGray
        text.font = UIFont .systemFont(ofSize: 40)
       return text
    }()
    private let registrationNewUser: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Registration", attributes: [.font:UIFont.systemFont (ofSize: 18), .foregroundColor: UIColor.rgb(red: 170, green: 92, blue: 178) ])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(goToRegistration), for: .touchUpInside)
        return button
    }()
    fileprivate let emailTextfield = UITextField.setupTextField(title: "Email..", hideText: false, enabled: true)
    fileprivate let passwordTextField = UITextField.setupTextField(title: "Password..", hideText: true, enabled: true)
    fileprivate let loginButton = UIButton.setupButton(title: "Enter", color: UIColor.rgb(red: 190, green: 140, blue: 196), activation: false, invisibility: false, laeyerRadius: 12, alpha: 1, textcolor: UIColor.rgb(red: 255, green: 255, blue: 255).withAlphaComponent(0.9))
  
    fileprivate let registrationWithFacebook: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Sign in with  ", attributes: [.font:UIFont.systemFont (ofSize: 18), .foregroundColor: UIColor.lightGray ])
        attributedTitle.append(NSAttributedString(string: "Facebook", attributes: [.font:UIFont.systemFont (ofSize: 18), .foregroundColor: UIColor.rgb(red: 170, green: 92, blue: 178) ]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    lazy var stacUpElementsView =  UIStackView(arrangedSubviews: [textEnter,registrationNewUser])
    lazy var stackView =  UIStackView(arrangedSubviews: [emailTextfield, passwordTextField, loginButton])
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true // скрыть навигейшн бар
        setupNotificationObserver()
        configureViewComponents()
        setupTapGesture()
        handlers()
        
    }
    // MARK: - ConfigureView
    fileprivate func configureViewComponents(){
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,  size: .init(width: 0, height: view.frame.height / 3.5))
         
        stacUpElementsView.axis = .horizontal
        stacUpElementsView.distribution = .fillEqually
             
        view.addSubview(stacUpElementsView)
        stacUpElementsView.anchor(top: logoContainerView.bottomAnchor,leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,pading: .init(top: view.frame.height/15, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 44))
        
        stackView.axis = .vertical
        stackView.spacing = view.frame.height/25
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.anchor(top: stacUpElementsView.bottomAnchor,leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,pading: .init(top: view.frame.height/20, left: 20, bottom: 0, right:20), size: .init(width: 0, height: view.frame.height/4.2))
        
        // определяем кнопку зайти через фесбук
        view.addSubview(registrationWithFacebook)
        registrationWithFacebook.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 0, left: 40, bottom: 10, right: 40))
    }
    
    // MARK: - Handlers
    fileprivate func handlers(){
        passwordTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged )
        emailTextfield.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    @objc fileprivate func handleLogin() {
        guard let email = emailTextfield.text else {return}
        guard let password = passwordTextField.text else {return}
        // говорим презентеру на меня тапнули сделай эту бизнес логику
        self.presenter.showLoginIndicator(emailAuth: email, passwordAuth: password)
      
    }

    @objc fileprivate func formValidation() {
        guard
            passwordTextField.hasText,
            emailTextfield.hasText
        else {
            self.loginButton.isEnabled = false
            self.loginButton.backgroundColor = UIColor.rgb(red: 190, green: 140, blue: 196)
            return
        }
       loginButton.isEnabled = true
       loginButton.backgroundColor = UIColor.rgb(red: 170, green: 92, blue: 178)
    }

    @objc fileprivate func goToRegistration(){
         let view = RegistrationController()
         let navController = UINavigationController(rootViewController: view)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
}
    // MARK: - Keyboard

    fileprivate func  setupNotificationObserver(){
        // следит когда подниметься клавиатура
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardSwow), name: UIResponder.keyboardWillShowNotification, object: nil)
        // следит когда пbcxtpftn
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
// alert
extension LoginControler{
    func alertRegistrationControllerMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
}

 //связывание вью с презентером что бы получать от него ответ и делать какие то действия в вью
extension LoginControler: LoginViewProtocol {
 
    func setLoginIndicator(indicator: Bool, error: String) {
        //передаем  индикатор в вью значение индикатора из презентера
        self.indicatorLogin = indicator
        if indicator == true {
           let view = MainViewControler()
           let navController = UINavigationController(rootViewController: view)
           navController.modalPresentationStyle = .fullScreen
           present(navController, animated: true, completion: nil)
       
        } else {
            alertRegistrationControllerMassage(title: "Error", message: error)
        }
    
    }
}




