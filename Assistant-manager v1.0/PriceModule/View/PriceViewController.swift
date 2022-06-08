//
//  PriceViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 08/06/2022.
//

import UIKit

class PriceViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var presenter: PricePresenterProtocol!
    let cell = "Cell"
    var tableView:UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
   
    fileprivate let newService =    UIButton.setupButton(title: "New service", color: UIColor.appColor(.pinkAssistant)!, activation: true, invisibility: false, laeyerRadius: 12, alpha: 1, textcolor: UIColor.appColor(.whiteAssistant)!.withAlphaComponent(0.9))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
      
       // self.navigationController?.navigationBar.prefersLargeTitles = true
       // navigationItem.title = "Price"
       // navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.appColor(.whiteAssistant)!]
        configureUI()
        configureTable()
        handlers()
    }
    fileprivate func handlers(){
        newService.addTarget(self, action: #selector(addService), for: .touchUpInside)
    }
    
    fileprivate func  configureUI() {
        
        view.addSubview(newService)
        newService.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 0, left: 20, bottom: 5, right: 20), size: .init(width: 0, height: 40))
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom:  newService.topAnchor, trailing: view.trailingAnchor,  pading: .init(top: 3, left: 10, bottom: 20, right: 10), size: .init(width: 0, height: view.frame.height))
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    func configureTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.appColor(.blueAssistantFon)!
        tableView.register(PriceCell.self, forCellReuseIdentifier: cell)
        tableView.separatorColor = .clear
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.price?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! PriceCell
        //убираем выделение
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.appColor(.blueAssistantFon)
        cell.price = presenter.price?[indexPath.row]
        return cell
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        // Создать константу для работы с кнопкой
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, completionHandler) in
            print("Delete")
            self?.presenter.deleteServise(indexPath: indexPath)
            self!.tableView.deleteRows(at: [indexPath], with: .top)
        }
        let editAction = UIContextualAction(style: .destructive, title: "Редактировать") { [weak self] (contextualAction, view, boolValue) in
            print("Redact")
            self?.presenter.redactServise(indexPath: indexPath)
            //tableView.reloadRows(at: [indexPath], with: .fade)
        }
        deleteAction.image = UIImage(systemName: "trash")
        editAction.image = UIImage(#imageLiteral(resourceName: "icons8-пользователь-без-половых-признаков-96"))
        deleteAction.backgroundColor = UIColor.appColor(.whiteAssistantwithAlpha)?.withAlphaComponent(0.3)
        editAction.backgroundColor = UIColor.appColor(.whiteAssistantwithAlpha)?.withAlphaComponent(0.4)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        return configuration
        
     
        
    }
    
    
    
    
    
    @objc fileprivate func addService(){
        presenter.addNewService()
    }
    


}
extension PriceViewController{
    func alertMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
}

extension PriceViewController: PriceProtocol {
    func succesReloadTable() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertMassage(title: "Error", message: error)
    }
    
   
    

}
