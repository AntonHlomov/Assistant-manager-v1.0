//
//  OptionesController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 12/05/2022.
//

import UIKit

class OptionesController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    var presenter: OptionesViewPresenterProtocol!
    let cellHeaderLine = "cellHeaderLine"
    let cellHeader = "cellHeader"
    let cell = "cell"
    let cellLine = "cellLine"
    let cellExitRemove = "cellExitRemove"
    
    var setings = ["Clients","Price","Team","Status"]
    var exitRemove = ["Exit","Remove"]
    
    var tableView:UITableView = {
       let tableView = UITableView()
       tableView.translatesAutoresizingMaskIntoConstraints = false
       return tableView
    }()
    
    fileprivate let shareIDButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Share your id, to create a  ", attributes: [.font:UIFont.systemFont (ofSize: 18), .foregroundColor: UIColor.appColor(.whiteAssistantwithAlpha)! ])
        attributedTitle.append(NSAttributedString(string: "team", attributes: [.font:UIFont.systemFont (ofSize: 18), .foregroundColor: UIColor.appColor(.pinkAssistant)! ]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.appColor(.whiteAndPinkDetailsAssistant) // меняем цвет кнопки выйти
        shareIDButton.addTarget(self, action: #selector(shareIDUser), for: .touchUpInside)
        configureUI()
        buildingTable()
       
    }
    fileprivate func configureUI() {
        
        view.addSubview(shareIDButton)
        shareIDButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 0, left: 40, bottom: 0, right: 40))
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom:shareIDButton.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor,  pading: .init(top: view.frame.height/38, left: 20, bottom: 10, right: 20), size: .init(width: 0, height: 0))
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
       
    }
    
    func buildingTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellHeaderLine)
        tableView.backgroundColor = UIColor.appColor(.blueAssistantFon)
        tableView.register(HeaderOptinesTableViewCell.self, forCellReuseIdentifier: cellHeader)
        tableView.register(OptionesTableViewCell.self, forCellReuseIdentifier: cell)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellLine)
        tableView.register(ExitRemoveTableViewCell.self, forCellReuseIdentifier: cellExitRemove)
        tableView.separatorColor = .clear //линии между ячейками цвет
    }
    
    //MARK: TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section{
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return setings.count
        case 3:
            return 1
        case 4:
            return exitRemove.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellLine) as UITableViewCell?)!
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.appColor(.blueAssistantFon)
            let lineView: UIImageView = {
                 let line = UIImageView()
                line.backgroundColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)
                 return line
              }()
            cell.addSubview(lineView)
            lineView.anchor(top: cell.topAnchor, leading: cell.leadingAnchor, bottom: cell.bottomAnchor, trailing: nil,pading: .init(top: 0, left: 35, bottom: 0, right: 0),size: .init(width: 1, height: view.frame.height/12))
            
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellHeader, for: indexPath) as! HeaderOptinesTableViewCell
            cell.backgroundColor = UIColor.appColor(.blueAssistantFon)
            cell.user = presenter.user
            return cell
        
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! OptionesTableViewCell
            cell.backgroundColor = UIColor.appColor(.blueAssistantFon)
            cell.textLabel?.text = setings[indexPath.row]
            cell.textLabel?.textColor = UIColor.appColor(.whiteAssistant)
            
            switch indexPath{
            case [2, 0]:
                cell.optionesImageView.image = #imageLiteral(resourceName: "icons8-пользователь-без-половых-признаков-96").withRenderingMode(.alwaysOriginal)
                cell.detailTextLabel?.text = "Yu have " + "??" + " clients"
                //
            case [2, 1]:
                cell.optionesImageView.image = #imageLiteral(resourceName: "icons8-сортировка-ответов-48").withRenderingMode(.alwaysOriginal)
                cell.detailTextLabel?.text = "??" + " services in yuor price"
                
            case [2, 2]:
                cell.optionesImageView.image = #imageLiteral(resourceName: "icons8-группа-пользователей,-мужчина-и-женщина-48").withRenderingMode(.alwaysOriginal)
                cell.detailTextLabel?.text = "??" + " person in yuor team"
                
            case [2, 3]:
                cell.optionesImageView.image = #imageLiteral(resourceName: "icons8-школа-48").withRenderingMode(.alwaysOriginal)
                cell.detailTextLabel?.text = "Access level: " + "??"
       
            default:
                return cell
            }
            
          
            return cell
            
        case 3:
            let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellLine) as UITableViewCell?)!
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.appColor(.blueAssistantFon)
            let lineView: UIImageView = {
                 let line = UIImageView()
                line.backgroundColor = UIColor.appColor(.whiteAndPinkDetailsAssistant)
                 return line
              }()
            cell.addSubview(lineView)
            lineView.anchor(top: cell.topAnchor, leading: cell.leadingAnchor, bottom: cell.bottomAnchor, trailing: nil,pading: .init(top: 0, left: 35, bottom: 0, right: 0),size: .init(width: 1, height: view.frame.height/14))
            
            
            return cell
            
        default:
        let cell = tableView.dequeueReusableCell(withIdentifier: cellExitRemove, for: indexPath) as! ExitRemoveTableViewCell
           
           // tableView.sectionHeaderTopPadding = 60 //view.frame.height/30
            cell.backgroundColor = UIColor.appColor(.blueAssistantFon)
            cell.textLabel?.text = exitRemove[indexPath.row]
            cell.textLabel?.textColor = UIColor.appColor(.whiteAssistant)
            
            switch indexPath{
            case [4, 0]:
                cell.optionesImageView.image = #imageLiteral(resourceName: "icons8-выход-48").withRenderingMode(.alwaysOriginal)
                
            case [4, 1]:
                cell.optionesImageView.image = #imageLiteral(resourceName: "icons8-удалить-пользователя-48").withRenderingMode(.alwaysOriginal)
       
            default:
                return cell
            }
        
        
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath{
        case [1, 0]:
            presenter.redactUserDataButton()
            
        case [2, 0]:
            presenter.schowClientsButoon()
        case [2, 1]:
            presenter.schowPriceButoon()
        case [2, 2]:
            presenter.schowTeamButoon()
        case [2, 3]:
            presenter.changeStatus()
            
        case [4, 0]:
            alertForExitOrRemove(title: "Go out", exit: true)
        case [4, 1]:
            alertForExitOrRemove(title: "Remove yor acaunt", exit: false)
        default:
            return
        }
        
    }
    @objc fileprivate func shareIDUser(){
        presenter.safeIdUserForSharing()
    }

    
    @objc func backTapped() {
        presenter.goToBackTappedViewFromRight()
    }
    
}
extension OptionesController{
    func alertRegistrationControllerMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
    
    func alertForExitOrRemove(title: String,exit: Bool){
        let alertControler = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertControler.addAction(UIAlertAction(title: title, style: .destructive, handler: { (_) in
            switch exit {
            case true:
                self.presenter.exitUser()
            case false:
                self.presenter.removeUser()
            }
        }))
        alertControler.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertControler, animated: true, completion: nil)
    }
}
//связывание вью с презентером что бы получать от него ответ и делать какие то действия в вью
extension OptionesController: OptionesViewProtocol {
    func succesForAlert(title: String, message: String) {
        alertRegistrationControllerMassage(title: title, message: message)
    }
    func succes() {
        print("Share your id, to create a team")
    }
    
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertRegistrationControllerMassage(title: "Error", message: error)
    }
    

}
