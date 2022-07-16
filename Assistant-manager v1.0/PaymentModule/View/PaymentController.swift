//
//  PaymentController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/07/2022.
//

import UIKit

class PaymentController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var presenter: PaymentPresenterProtocol!
    
    let cell = "Cell"
    
    var tableView:UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var fonCheck: UIView = {
        let fon = UIView()
        fon.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        return fon
     }()
    var circleL: UIView = {
        let circle = UIView()
        circle.backgroundColor = UIColor.appColor(.blueAssistantFon)
        return circle
     }()
    var circleR: UIView = {
        let circle = UIView()
        circle.backgroundColor = UIColor.appColor(.blueAssistantFon)
        return circle
     }()
    var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.appColor(.blueAssistantFon)
       // line.layer.borderWidth = 3
    
        return line
     }()
    
    var circlForAvaMaster: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        line.layer.cornerRadius = 90
        line.layer.borderColor = UIColor.appColor(.blueAssistantFon)?.cgColor
        line.layer.borderWidth = 3
        
        return line
     }()
    
     var masterImageView = CustomUIimageView(frame: .zero )
 
     var nameMaster: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Name master"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.appColor(.whiteAssistant)
        return label
     }()
 
     var nameClientLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Client"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.appColor(.whiteAssistant)
        return label
     }()
     var nameClientValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Ivan Ivanov"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.appColor(.whiteAssistant)
        return label
     }()
     var totalBill: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Total Bill"
         label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.appColor(.whiteAssistant)
        return label
     }()
    
     var nameCurancy: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "$"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.appColor(.whiteAssistant)
        return label
     }()
    
     var totalBillValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "100"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.appColor(.whiteAssistant)
        return label
     }()
    lazy var stackCurancy = UIStackView(arrangedSubviews: [nameCurancy, totalBillValue])
    lazy var stackTotal = UIStackView(arrangedSubviews: [totalBill, stackCurancy])
    lazy var stackClientLabel = UIStackView(arrangedSubviews: [nameClientLabel, nameClientValue])
    
    lazy var stackFuterBill = UIStackView(arrangedSubviews: [stackClientLabel, stackTotal])
    
    var fonTable: UIView = {
        let fon = UIView()
        fon.backgroundColor = UIColor.appColor(.blueAssistantFon)
        return fon
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
    
    lazy var commit: UITextView = {
        var text = UITextView()
        text.textAlignment = .left
        text.text = ""
        text.font = UIFont.systemFont(ofSize: 13, weight: .light)
        text.textColor = UIColor.appColor(.whiteForDarkDarkForWhiteText)!
        text.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        //text.layer.cornerRadius = 15
        text.isEditable = true
        return text
    }()

    fileprivate let payButton = UIButton.setupButton(title: "Pay", color: UIColor.rgb(red: 190, green: 140, blue: 196), activation: true, invisibility: false, laeyerRadius: 12, alpha: 1, textcolor: UIColor.rgb(red: 255, green: 255, blue: 255).withAlphaComponent(0.9))
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10//presenter.filterPrice?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! PriceCell
        cell.tintColor = UIColor.appColor(.whiteAssistant)
        //убираем выделение
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.appColor(.blueAssistantFon)
       // cell.price = presenter.filterPrice?[indexPath.row]
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        configureViewComponents()
        configureTable()
        setupNotificationObserver()
        setupTapGesture()
        handlers()
    }
    
    fileprivate func configureViewComponents(){
        view.addSubview(fonCheck)
        fonCheck.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top:view.frame.height/9, left: 20, bottom: view.frame.height/4, right: 20), size: .init(width: 0, height: 0))
        fonCheck.layer.cornerRadius = 12
        fonCheck.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(circleL)
        circleL.anchor(top: fonCheck.topAnchor, leading: fonCheck.leadingAnchor, bottom: nil, trailing: nil,pading: .init(top: view.frame.height/8, left: -25, bottom: 0, right: 0),  size: .init(width: 50, height: 50))
        circleL.layer.cornerRadius = 50 / 2
        
        view.addSubview(circleR)
        circleR.anchor(top: fonCheck.topAnchor, leading: nil, bottom: nil, trailing: fonCheck.trailingAnchor,pading: .init(top: view.frame.height/8, left: 0, bottom: 0, right: -25),  size: .init(width: 50, height: 50))
        circleR.layer.cornerRadius = 50 / 2
        
        view.addSubview(line)
        line.anchor(top: circleL.topAnchor, leading: circleL.trailingAnchor, bottom: nil, trailing: circleR.leadingAnchor,pading: .init(top: 25, left: 0, bottom: 0, right: 0),  size: .init(width: 0, height: 2))
        
        view.addSubview(circlForAvaMaster)
        circlForAvaMaster.anchor(top: fonCheck.topAnchor, leading: nil, bottom: nil, trailing: nil,pading: .init(top: 15, left: 0, bottom: 0, right: 0),  size: .init(width: 60, height: 60))
         
        circlForAvaMaster.layer.cornerRadius = 60 / 2
        circlForAvaMaster.centerXAnchor.constraint(equalTo: fonCheck.centerXAnchor).isActive = true //выстовляет по середине экрана
        
        view.addSubview(masterImageView)
        masterImageView.anchor(top: circlForAvaMaster.topAnchor, leading: nil, bottom: nil, trailing: nil,pading: .init(top: 5, left: 0, bottom: 0, right: 0),  size: .init(width:50, height: 50))
         
        masterImageView.layer.cornerRadius = 50 / 2
        masterImageView.centerXAnchor.constraint(equalTo: fonCheck.centerXAnchor).isActive = true //выстовляет по середине экрана
        
        view.addSubview(nameMaster)
        nameMaster.anchor(top: masterImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,  pading: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 20))
        nameMaster.centerXAnchor.constraint(equalTo: fonCheck.centerXAnchor).isActive = true
        
        stackCurancy.axis = .horizontal
        stackCurancy.spacing = 0
        stackCurancy.distribution = .fillProportionally
        
        stackTotal.axis = .vertical
        stackTotal.spacing = 8
        stackTotal.distribution = .fillEqually
        
        stackClientLabel.axis = .vertical
        stackClientLabel.spacing = 8
        stackClientLabel.distribution = .fillEqually
        
      
        stackFuterBill.axis = .horizontal
      //  stackFuterBill.spacing = 20
        stackFuterBill.distribution = .equalCentering
        
        view.addSubview(stackFuterBill)
        stackFuterBill.anchor(top: line.bottomAnchor, leading: circleL.trailingAnchor, bottom: nil, trailing: circleR.leadingAnchor, pading: .init(top: 20, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 0))
        
        view.addSubview(fonTable)
        fonTable.anchor(top: stackFuterBill.bottomAnchor, leading: fonCheck.leadingAnchor, bottom: fonCheck.bottomAnchor, trailing: fonCheck.trailingAnchor, pading: .init(top: 20, left: 20, bottom: 20, right: 20), size: .init(width: 0, height: 0))
        fonTable.layer.cornerRadius = 12
        fonTable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fonTable.addSubview(tableView)
        tableView.anchor(top: fonTable.topAnchor, leading: fonTable.leadingAnchor, bottom: fonTable.bottomAnchor, trailing: fonTable.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0))
        tableView.layer.cornerRadius = 12
        
        view.addSubview(payButton)
        payButton.anchor(top: nil, leading: fonCheck.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: fonCheck.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 10, right: 0))
        
        view.addSubview(textAddComent)
        textAddComent.anchor(top: fonCheck.bottomAnchor, leading: fonCheck.leadingAnchor, bottom: nil, trailing: fonCheck.trailingAnchor, pading: .init(top: 20, left: 10, bottom: 0, right: 10))
        
        view.addSubview(commit)
        commit.anchor(top: textAddComent.bottomAnchor, leading: fonCheck.leadingAnchor, bottom: payButton.topAnchor, trailing: fonCheck.trailingAnchor, pading: .init(top: 5, left: 0, bottom: 50, right: 0))
        commit.layer.cornerRadius = 10
  
    }
    func configureTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.appColor(.blueAssistantFon)!
        tableView.register(PriceCell.self, forCellReuseIdentifier: cell)
        tableView.separatorColor = .clear
        tableView.allowsMultipleSelection = true
       // tableView.refreshControl = dataRefresher
    }
    fileprivate func handlers(){
        payButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
    }
    @objc fileprivate func pay() {
        alertForPayCashOrCard()
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
            let bottomSpace = commit.frame.height + commit.frame.height/4
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
extension PaymentController{
    func alertForPayCashOrCard(){
        let alertControler = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertControler.addAction(UIAlertAction(title: "Cash", style: .destructive, handler: { (_) in
            self.presenter.pushPay(payCard: false)
        }))
        
        alertControler.addAction(UIAlertAction(title: "Card", style: .default,  handler: { (_) in
            self.presenter.pushPay(payCard: true)
        }))
        alertControler.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        present(alertControler, animated: true, completion: nil)
    }
    func alertPaymentMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
}
extension PaymentController: PaymentProtocol {
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertPaymentMassage(title: "Error", message: error)
    }
}
