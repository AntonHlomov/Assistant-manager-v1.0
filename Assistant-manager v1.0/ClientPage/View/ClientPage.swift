//
//  ClientPage.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 29/05/2022.
//

import UIKit

class ClientPage: UIViewController {
    var presenter: ClientPagePresenterProtocol!
    
    lazy var zigzagContainerView = SketchBorderView()

    let fonBlue: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.blueAssistantFon)
        return line
     }()
    
    lazy var boxViewBlue: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.blueAssistantFon)
        return line
     }()
    
    lazy var circlForAvaViewBlue: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.blueAssistantFon)
        line.layer.cornerRadius = 140
        line.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
        line.layer.borderWidth = 3
        
        return line
     }()
    
    lazy var profileImageView = CustomUIimageView(frame: .zero )
    
    let nameClient: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Name Client"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = UIColor.appColor(.whiteAssistant)
         return label
     }()
    
    lazy var abautCient: UITextView = {
       
        var text = UITextView()
        text.textAlignment = .center
        text.text = "Text abaut cient"
        text.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        text.textColor = UIColor.appColor(.whiteAssistant)
        text.backgroundColor = UIColor.appColor(.blueAssistantFon)
        //нельзя редактировать
        text.isEditable = false

             return text
    }()
    fileprivate let clientInvitationButton =    UIButton.setupButton(title: "New visit", color: UIColor.appColor(.blueAssistant)!, activation: true, invisibility: false, laeyerRadius: 12, alpha: 1, textcolor:  UIColor.appColor(.whiteAssistant)!.withAlphaComponent(0.9))
    
    fileprivate let callButton =    UIButton.setupButton(title: "Сall", color: UIColor.appColor(.pinkAssistant)!, activation: true, invisibility: false, laeyerRadius: 12, alpha: 1, textcolor: UIColor.appColor(.whiteAssistant)!.withAlphaComponent(0.9))
    
    lazy var stackButtonMakeCall = UIStackView(arrangedSubviews: [clientInvitationButton, callButton])
    
    lazy var countComeClient: UIButton = {
        let button = UIButton(type: .system)
        var attributedTitle = NSMutableAttributedString(string: "2220", attributes: [.font:UIFont.systemFont (ofSize: 40), .foregroundColor: UIColor.appColor(.blueAssistant)!])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(goToVisitStatisyc), for: .touchUpInside) // переход на экран история записи
        return button
    }()
    
     lazy var textCountComeClientLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = (NSAttributedString(string: "ИСТОРИЯ\nВИЗИТОВ",  attributes: [.font: UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor: UIColor.appColor(.blueAssistant)!]))
        label.attributedText = attributedText
        return label
    }()
    lazy var stackVisitClient = UIStackView(arrangedSubviews: [countComeClient, textCountComeClientLabel])
    
    lazy var monyComeClient: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "23230", attributes: [.font:UIFont.systemFont (ofSize: 40), .foregroundColor: UIColor.appColor(.blueAssistant)!])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(goToFinansStatisyc), for: .touchUpInside) // переход на экран фин статистики
        return button
    }()
    
    lazy var textMonyComeClientLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = (NSAttributedString(string: "СРЕДНИЙ\nЧЕК",  attributes: [.font: UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor: UIColor.appColor(.blueAssistant)!]))
        label.attributedText = attributedText
        return label
    }()
    lazy var stackMonyClient = UIStackView(arrangedSubviews: [monyComeClient, textMonyComeClientLabel])
    
    
    lazy var stackStatisyc = UIStackView(arrangedSubviews: [stackVisitClient, stackMonyClient])
    
    lazy var goToWorckButton: UIButton = {
        let button = UIButton(type: .system)
      //  button.setTitle("", for: .normal)
      //  button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        button.setTitleColor(.gray, for: .normal)
        button.layer.borderWidth = 8
        button.layer.borderColor =  UIColor.appColor(.blueAssistant)!.cgColor
        button.addTarget(self, action: #selector(goToWorck), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        configureNavigationBar()
        configureUI()
        handlers()
    }
    fileprivate func handlers(){
        clientInvitationButton.addTarget(self, action: #selector(pressСlientInvitationButton), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(pressСallButton), for: .touchUpInside)
    }
    // MARK: - NavigationBar
    fileprivate func configureNavigationBar(){
      
        let visitDatesButton : UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "CAlBLue").withRenderingMode(.alwaysOriginal), style:.plain, target: self, action:#selector(visitDates))
              
        let reminderButton : UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "SCOL").withRenderingMode(.alwaysOriginal), style:.plain, target: self, action:#selector(reminder))
        let buttons : NSArray = [ reminderButton,visitDatesButton]
        self.navigationItem.rightBarButtonItems = (buttons as! [UIBarButtonItem])
        navigationItem.leftBarButtonItem?.tintColor = .black // меняем цвет кнопки выйти
    }
    
    fileprivate func configureUI() {
   
        view.addSubview(boxViewBlue)
        boxViewBlue.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, pading: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: view.frame.height/4))
        boxViewBlue.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        zigzagContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(zigzagContainerView)
        zigzagContainerView.anchor(top: boxViewBlue.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, pading: .init(top: -10, left: -10, bottom: 0, right: -10),size: .init(width: 0 , height: 60))
  
        view.addSubview(circlForAvaViewBlue)
        circlForAvaViewBlue.anchor(top: boxViewBlue.topAnchor, leading: nil, bottom: nil, trailing: nil,pading: .init(top: -60, left: 0, bottom: 0, right: 0),  size: .init(width: 160, height: 160))
         
        circlForAvaViewBlue.layer.cornerRadius = 160 / 2
        circlForAvaViewBlue.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true //выстовляет по середине экрана
        
        view.addSubview(profileImageView)
        profileImageView.anchor(top: circlForAvaViewBlue.topAnchor, leading: nil, bottom: nil, trailing: nil,pading: .init(top: 10, left: 0, bottom: 0, right: 0),  size: .init(width: 140, height: 140))
         
        profileImageView.layer.cornerRadius = 140 / 2
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true //выстовляет по середине экрана
        
        view.addSubview(nameClient)
        nameClient.anchor(top: profileImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,  pading: .init(top: 22, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 20))
        nameClient.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(abautCient)
        abautCient.anchor(top: nameClient.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: zigzagContainerView.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor,  pading: .init(top: 10, left: 30, bottom: 5, right: 30), size: .init(width: boxViewBlue.frame.width - 20, height: 125))
        abautCient.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true //выстовляет по середине экрана
        
        stackButtonMakeCall.axis = .horizontal
        stackButtonMakeCall.spacing = view.frame.height/35
        stackButtonMakeCall.distribution = .fillEqually
        
        view.addSubview(stackButtonMakeCall)
        stackButtonMakeCall.anchor(top: zigzagContainerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, pading: .init(top: 50, left: 10, bottom: 0, right: 5), size: .init(width: 0, height: 40))
        
        stackVisitClient.axis = .vertical
        stackVisitClient.spacing = view.frame.height/70
        stackVisitClient.distribution = .fillEqually
        view.addSubview(stackVisitClient)
        
        stackMonyClient.axis = .vertical
        stackMonyClient.spacing = view.frame.height/70
        stackMonyClient.distribution = .fillEqually
        view.addSubview(stackMonyClient)
        
        stackStatisyc.axis = .horizontal
        stackStatisyc.spacing = 10
        stackStatisyc.distribution = .fillEqually
        view.addSubview(stackStatisyc)
        stackStatisyc.anchor(top: stackButtonMakeCall.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, pading: .init(top: 60, left: 10, bottom: 0, right: 5), size: .init(width: 0, height: view.frame.height/7))
        
        view.addSubview(goToWorckButton) // кнопка в работу
        goToWorckButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing:nil, pading: .init(top: 0, left: 0, bottom: 0,right: 0), size: .init(width: 80, height: 80))
        goToWorckButton.layer.cornerRadius = 80 / 2
        goToWorckButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    }
    @objc fileprivate func pressСlientInvitationButton(){
        let idClient = "0000000000001"
        presenter.pressСlientInvitationButton(idClient: idClient)
    }
    @objc fileprivate func pressСallButton(){
        let idClient = "0000000000001"
        presenter.pressСallButton(idClient: idClient)
    }
    @objc fileprivate func goToVisitStatisyc(){
        let idClient = "0000000000001"
        presenter.goToVisitStatisyc(idClient: idClient)
    }
    @objc fileprivate func goToFinansStatisyc(){
        let idClient = "0000000000001"
        presenter.goToFinansStatisyc(idClient: idClient)
    }
    @objc fileprivate func goToWorck(){
        let idClient = "0000000000001"
        presenter.goToWorck(idClient: idClient)
    }
    @objc fileprivate func visitDates(){
        let idClient = "0000000000001"
        presenter.visitDates(idClient: idClient)
    }
    @objc fileprivate func reminder(){
        let idClient = "0000000000001"
        presenter.reminder(idClient: idClient)
    }
  

}
//связывание вью с презентером что бы получать от него ответ и делать какие то действия в вью
extension ClientPage: ClientPageProtocol {
   
    

}
