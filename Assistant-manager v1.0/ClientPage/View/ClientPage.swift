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
    
    lazy var nameClient: UILabel = {
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
        text.textColor = UIColor.appColor(.whiteAssistantwithAlpha)!
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
        var attributedTitle = NSMutableAttributedString(string: "0", attributes: [.font:UIFont.systemFont (ofSize: 40), .foregroundColor: UIColor.appColor(.blueAssistant)!])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(goToVisitStatisyc), for: .touchUpInside) // переход на экран история записи
        return button
    }()
    
     lazy var textCountComeClientLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = (NSAttributedString(string: "HISTORY\nOF VISITS",  attributes: [.font: UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor: UIColor.appColor(.blueAssistant)!]))
        label.attributedText = attributedText
        return label
    }()
    lazy var stackVisitClient = UIStackView(arrangedSubviews: [countComeClient, textCountComeClientLabel])
    
    lazy var monyComeClient: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "0", attributes: [.font:UIFont.systemFont (ofSize: 40), .foregroundColor: UIColor.appColor(.blueAssistant)!])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(goToFinansStatisyc), for: .touchUpInside) // переход на экран фин статистики
        return button
    }()
    
    lazy var textMonyComeClientLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = (NSAttributedString(string: "AVERAGE\nBILL",  attributes: [.font: UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor: UIColor.appColor(.blueAssistant)!]))
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            self.circlForAvaViewBlue.layer.borderColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)?.cgColor
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        configureNavigationBar()
        configureUI()
        handlers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAllIndicator()
       }
    fileprivate func handlers(){
        clientInvitationButton.addTarget(self, action: #selector(pressСlientInvitationButton), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(pressСallButton), for: .touchUpInside)
    }
    // MARK: - NavigationBar
    fileprivate func configureNavigationBar(){
        let visitDatesButton : UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "calBL").withRenderingMode(.alwaysOriginal), style:.plain, target: self, action:#selector(visitDates))
        let reminderButton : UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "SB").withRenderingMode(.alwaysOriginal), style:.plain, target: self, action:#selector(reminder))
        let buttons : NSArray = [ reminderButton,visitDatesButton]
        self.navigationItem.rightBarButtonItems = (buttons as! [UIBarButtonItem])
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
        presenter.pressСlientInvitationButton()
    }
    @objc fileprivate func pressСallButton(){
        presenter.pressСallButton()
    }
    @objc fileprivate func goToVisitStatisyc(){
        presenter.goToVisitStatisyc()
    }
    @objc fileprivate func goToFinansStatisyc(){
        presenter.goToFinansStatisyc()
    }
    @objc fileprivate func goToWorck(){
        presenter.goToWorck()
    }
    @objc fileprivate func visitDates(){
        presenter.visitDates()
    }
    @objc fileprivate func reminder(){
        alertReminderMassage()
    }
    
    func checkAllIndicator(){
        presenter.checkIndicatorVisitDates()
        presenter.checkIndicatorReminder()
        presenter.massageClientReminder()
        presenter.checkIndicatorVisitStatisyc()
        presenter.checkIndicatorFinansStatisyc()
        presenter.checkIndicatorGoToWorck()
    }
  

}
// alert
extension ClientPage{
    func alertRegistrationControllerMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
    func alertOk(message: String){
        let alertControler = UIAlertController(title: "Ok", message: "\n\(message)", preferredStyle: .alert)
        present(alertControler, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            alertControler.dismiss(animated: true, completion: nil)
           }
    }
    
    func alertReminderMassage(){
        let alertControler = UIAlertController(title: "Reminder", message: nil, preferredStyle: .alert)
        alertControler.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
         
        alertControler.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter reminder text..."
        })
         
        alertControler.addAction(UIAlertAction(title: "Select date", style: .default, handler: { action in
         
            if let textReminder = alertControler.textFields?.first?.text {
              //  print("Text: \(textReminder)")
                self.alertDatePicker(text: textReminder)
            }
    
        }))
        self.present(alertControler, animated: true)
    }
    
    func alertDatePicker(text:String){
        let myDatePicker: UIDatePicker = UIDatePicker()
           myDatePicker.timeZone = NSTimeZone.local
        //myDatePicker.preferredDatePickerStyle = .wheels
        myDatePicker.preferredDatePickerStyle = .automatic
         //  myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
          myDatePicker.frame = CGRect(x: 0, y: 50, width: 230, height: 50)
           let alertController = UIAlertController(title: "Select date and time \n\n", message: nil, preferredStyle: .alert)
           alertController.view.addSubview(myDatePicker)
           let backAction = UIAlertAction(title: "Back", style: .default, handler: { _ in
               self.alertReminderMassage()
           })
           let selectAction = UIAlertAction(title: "Save", style: .default, handler: { _ in
            //  print("Selected Date: \(myDatePicker.date)")
               self.presenter.reminder(text: text, date: myDatePicker.date)
           })
           alertController.addAction(backAction)
           alertController.addAction(selectAction)
           present(alertController, animated: true)
    }
    
    
}
//связывание вью с презентером что бы получать от него ответ и делать какие то действия в вью
extension ClientPage: ClientPageProtocol {
    func massageReminder(massge: String) {
        alertRegistrationControllerMassage(title: "Reminder", message: massge)
    }
    
    func setClient(client: Client?) {
  
        profileImageView.loadImage(with: client?.profileImageClientUrl ?? "")
        guard let name = client?.nameClient else {return}
        guard let fullName = client?.fullName else {return}
        guard let textAboutClient =  client?.textAboutClient else {return}
        guard let countVisits =  client?.countVisits else {return}
        nameClient.text = name.capitalized + " " + fullName.capitalized
        abautCient.text = textAboutClient
        let attributed = NSMutableAttributedString(string: "\(String(countVisits))", attributes: [.font:UIFont.systemFont (ofSize: 40), .foregroundColor: UIColor.appColor(.blueAssistant)!])
        countComeClient.setAttributedTitle(attributed, for: .normal)

    }
    func openAlertOk(message:String){
        alertOk(message: message)
    }
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertRegistrationControllerMassage(title: "Error", message: error)
    }
    func changeVisitDates(indicatorVisits: Bool){
        guard indicatorVisits == true else {return}
        self.navigationItem.rightBarButtonItems?[1] = UIBarButtonItem(image: #imageLiteral(resourceName: "CAlBLue").withRenderingMode(.alwaysOriginal), style:.plain, target: self, action:#selector(visitDates))
    }
    func changeReminder(indicatorReminder: Bool){
        guard indicatorReminder == true else {return}
        self.navigationItem.rightBarButtonItems?[0] = UIBarButtonItem(image: #imageLiteral(resourceName: "SCOL").withRenderingMode(.alwaysOriginal), style:.plain, target: self, action:#selector(reminder))
       
    }
    func changeVisitStatisyc(countVisits: String){
       
        
    }
    func changeFinansStatisyc(countAverageBill: String){
        let attributedTitleMonyComeClient = NSMutableAttributedString(string: countAverageBill, attributes: [.font:UIFont.systemFont (ofSize: 40), .foregroundColor: UIColor.appColor(.blueAssistant)!])
        self.monyComeClient.setAttributedTitle(attributedTitleMonyComeClient, for: .normal)
        
    }
    func changeGoToWorck(indicatorWorck: Bool){
        guard indicatorWorck == true else {return}
        self.goToWorckButton.layer.borderColor = UIColor.appColor(.pinkAssistant)!.cgColor
       
    }
    
    
   
    

}
