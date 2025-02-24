//
//  StatusSwitchTableView.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 25/11/2022.
//
import UIKit
class StatusSwitchTableView: UITableViewController {
    var presenter: StatusSwitchPresenterProtocol!
    let cell = "Cell"
    var selectedIndexes = [[IndexPath.init(row: 0, section: 0)]]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        tableView.register(OptionesTableViewCell.self, forCellReuseIdentifier: cell)
        tableView.separatorColor = .clear //линии между ячейками цвет
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  presenter?.statuses?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! OptionesTableViewCell
        cell.backgroundColor = UIColor.appColor(.blueAssistantFon)
        //cell.textLabel?.text = presenter.statuses?[indexPath.row]
        cell.textLabel?.textColor = UIColor.appColor(.whiteAssistant)
        
        let selectedSectionIndexes = self.selectedIndexes[indexPath.section]
        if selectedSectionIndexes.contains(indexPath) {
            cell.accessoryType = .checkmark
            cell.optionesImageView.loadImage(with: presenter.user?.profileImage ?? "")
           // cell.detailTextLabel?.text = presenter.nameGroupCoWorking ?? ""
        }
        else {
            cell.accessoryType = .none
            cell.optionesImageView.image = nil
           // cell.detailTextLabel?.text = ""
        }
        
        if presenter.statuses?[indexPath.row] != "Individual"{
            cell.textLabel?.text = presenter.nameGroupCoWorking ?? ""
            cell.detailTextLabel?.text = presenter.statuses?[indexPath.row]
        } else {
            cell.textLabel?.text = presenter.statuses?[indexPath.row]
        }
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
            // If current cell is not present in selectedIndexes
        if !self.selectedIndexes[indexPath.section].contains(indexPath) {
            // mark it checked
            cell.accessoryType = .checkmark
            // Remove any previous selected indexpath
            self.selectedIndexes[indexPath.section].removeAll()
            // add currently selected indexpath
            self.selectedIndexes[indexPath.section].append(indexPath)
            tableView.reloadData()
        }
        guard presenter.user?.statusInGroup != cell.detailTextLabel?.text ?? "" else {return}
        alertStatus()
    }

}
extension StatusSwitchTableView {
    func alertMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
    /*
    func alertStatus(){
        let alertControler = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertControler.addAction(UIAlertAction(title: "Change status?", style: .destructive, handler: { (_) in
            self.presenter.swapStatusSwitch()
        }))
        alertControler.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:  { (_) in
            self.selectedIndexes = [[IndexPath.init(row: 0, section: 0)]]
            self.tableView.reloadData()
        }))
        present(alertControler, animated: true, completion: nil)
    }
    */
    func alertStatus() {
        let alertControler = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertControler.addAction(UIAlertAction(title: "Change status?", style: .destructive, handler: { (_) in
            self.presenter.swapStatusSwitch()
        }))
        alertControler.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            self.selectedIndexes = [[IndexPath.init(row: 0, section: 0)]]
            self.tableView.reloadData()
        }))
        
        // Для iPad нужно настроить popoverPresentationController
        if let popoverController = alertControler.popoverPresentationController {
            popoverController.sourceView = self.view  // Указание view, из которой будет выведен поповер
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 1, height: 1)  // Указание расположения поповера
            popoverController.permittedArrowDirections = []  // Отключение стрелки
        }
        
        // Проверка, если экран iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertControler.modalPresentationStyle = .popover
        }
        
        present(alertControler, animated: true, completion: nil)
    }
  
}
extension StatusSwitchTableView: StatusSwitchProtocol {
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertMassage(title: "Error", message: error)
    }
    func reloadTable (){
       tableView.reloadData()
    }
}
