//
//  TeamTableViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 22/10/2022.
//
import UIKit

class TeamTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    var presenter: TeamPresenterProtocol!
    let cell = "cell"
    let cellEmpty = "cellEmpty"
    let myPicker: UIPickerView = UIPickerView()
    let statusInGroup = ["Boss","Administrator","Master"]
    var selectedValue = ""
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statusInGroup.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = statusInGroup[row] as String
        self.view.endEditing(true)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statusInGroup[row]
    }
    
    fileprivate let removeTeam: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Remove the whole ", attributes: [.font:UIFont.systemFont (ofSize: 18), .foregroundColor: UIColor.appColor(.whiteAssistantwithAlpha)! ])
        attributedTitle.append(NSAttributedString(string: "team", attributes: [.font:UIFont.systemFont (ofSize: 18), .foregroundColor: UIColor.appColor(.pinkAssistant)! ]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        tableView.register(TeamTableViewCell.self, forCellReuseIdentifier: cell)
        tableView.register(EmptyTeamTableViewCell.self, forCellReuseIdentifier: cellEmpty)
        tableView.separatorColor = .clear //линии между ячейками цвет
        self.navigationController?.navigationBar.tintColor = UIColor.appColor(.whiteAssistant)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTeamUser))
        removeTeam.addTarget(self, action: #selector(removeTeamAll), for: .touchUpInside)
        configureUI()
        myPicker.dataSource = self
        myPicker.delegate = self
    }
    fileprivate func configureUI() {
        view.addSubview(removeTeam)
        removeTeam.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 0, left: 40, bottom: 0, right: 40))
        removeTeam.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true  
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch presenter.team?.count {
        case 0, nil : return 1
        default: return presenter.team?.count ?? 0
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {        
        switch presenter.team?.count {
        case 0, nil : return view.frame.height/1.5
        default:  return 85.0
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.team?.count {
        case 0, nil :
            let cell = tableView.dequeueReusableCell(withIdentifier: cellEmpty, for: indexPath) as! EmptyTeamTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! TeamTableViewCell
            cell.backgroundColor =  UIColor.appColor(.blueAssistantFon)
            cell.team = presenter.team?[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            cell.addCustomDisclosureIndicator(with: UIColor.appColor(.whiteAssistant)!)
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("нажал на команду\(indexPath)")
        switch presenter.team?.count {
        case 0, nil :   self.alertConfirm(title: "Create a team?", mode: "createTaem")
        default: self.presenter.goToPageTeamUser(indexPathRowClient: indexPath.row)
        }
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        switch presenter.team?.count {
        case 0, nil :
            return nil
        default:
            // Создать константу для работы с кнопкой
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, completionHandler) in
                print("Delete")
                self?.presenter.deleteTeamUser(indexPathRow: indexPath.row)
            }
            let editAction = UIContextualAction(style: .destructive, title: "Редактировать") { [weak self] (contextualAction, view, boolValue) in
                print("Redact")
                self?.presenter.redactTeamUser(indexPath: indexPath)
            }
            deleteAction.image = UIImage(systemName: "trash")
            editAction.image = UIImage(#imageLiteral(resourceName: "icons8-пользователь-без-половых-признаков-96"))
            deleteAction.backgroundColor = UIColor.appColor(.whiteAssistantwithAlpha)?.withAlphaComponent(0.3)
            editAction.backgroundColor = UIColor.appColor(.whiteAssistantwithAlpha)?.withAlphaComponent(0.4)
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
            return configuration
        }
    }
    @objc fileprivate func addNewTeamUser(){
        switch presenter.team?.count {
        case 0, nil : alertMassage(title: "The team does not exist.", message: "Before adding members, create a team.")
        default:  alertAddIdNewTeamUser()
        }
    }
    @objc fileprivate func removeTeamAll(){
        self.alertConfirm(title: "Remove the whole team ?", mode: "removeTeamAll")
    }
}
extension TeamTableViewController{
    func alertConfirm(title: String,mode: String){
        let alertControler = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertControler.addAction(UIAlertAction(title: title, style: .destructive, handler: { (_) in
            switch mode {
            case "removeTeamAll":
                self.presenter.removeTeamAll()
            case "createTaem":
                self.presenter.createTaemForBossUser()
            default: break
            }
        }))
        alertControler.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertControler, animated: true, completion: nil)
    }
    func alertMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
    func alertAddIdNewTeamUser(){
        let alertControler = UIAlertController(title: "Enter the user id to add to the team", message: nil, preferredStyle: .alert)
        let selectDate = UIAlertAction(title: "Select", style: .default, handler: { action in
            if let idTeam = alertControler.textFields?.first?.text {
                if idTeam != ""{
                    self.alertCategoryTeamPicker(idNewTeamUser: idTeam)
                   
                }
            }
        })
        selectDate.isEnabled = false
        alertControler.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertControler.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter id..."
            // Observe the UITextFieldTextDidChange notification to be notified in the below block when text is changed
               NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main, using:
                   {_ in
                       // Being in this block means that something fired the UITextFieldTextDidChange notification.
                       // Access the textField object from alertController.addTextField(configurationHandler:) above and get the character count of its non whitespace characters
                       let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                       let textIsNotEmpty = textCount > 0
                       selectDate.isEnabled = textIsNotEmpty
               })
        })
        alertControler.addAction(selectDate)
        self.present(alertControler, animated: true)
    }
    
    func alertCategoryTeamPicker(idNewTeamUser:String){
           let alertController = UIAlertController(title: "Select status \n\n\n\n\n\n", message: nil, preferredStyle: .alert)
           self.myPicker.frame = CGRect(x: 10, y: 10, width: 250, height: 180)
           self.selectedValue = statusInGroup[0]
           alertController.view.addSubview(myPicker)
           let backAction = UIAlertAction(title: "Back", style: .default, handler: { _ in
               self.alertAddIdNewTeamUser()
           })
           let selectAction = UIAlertAction(title: "Confirm", style: .default, handler: { _ in
               self.presenter.confirmAddIdNewTeamUser(idNewTeamUser: idNewTeamUser, status: self.selectedValue)       
           })
           alertController.addAction(backAction)
           alertController.addAction(selectAction)
           present(alertController, animated: true)
    }
}

extension TeamTableViewController: TeamProtocol {
    func reloadTable (){
        self.tableView.reloadData()
    }
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertMassage(title: "Error", message: error)
    }
    func massage(title:String, message: String){
        alertMassage(title: title, message: message)
    }  
}
