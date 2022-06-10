//
//  PriceViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 08/06/2022.
//

import UIKit

class PriceViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating {
   
    
    var presenter: PricePresenterProtocol!
    let searchController = UISearchController(searchResultsController: nil)
    let cell = "Cell"
    var tableView:UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
   
    fileprivate let newService =    UIButton.setupButton(title: "New service", color: UIColor.appColor(.pinkAssistant)!, activation: true, invisibility: false, laeyerRadius: 12, alpha: 1, textcolor: UIColor.appColor(.whiteAssistant)!.withAlphaComponent(0.9))
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
      //  self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Price: "+"0.0"+"$"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.appColor(.whiteAssistant)!]
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        configureUI()
        configureTable()
        handlers()
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = UIColor.appColor(.blueAssistantFon)
 
        searchController.obscuresBackgroundDuringPresentation = false//  делает затемнение при вводе запроса а поиск
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.searchTextField.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        //цвет кнопки отмена
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.appColor(.whiteAndBlueAssistantFon)! ], for: .normal)
             //меняем цвет лупы в поиске
         let textField = searchController.searchBar.value(forKey: "searchField") as! UITextField
         let glassIconView = textField.leftView as! UIImageView
         glassIconView.image = glassIconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
         glassIconView.tintColor = UIColor.appColor(.blueAssistantFon)
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
        tableView.allowsMultipleSelection = true
        tableView.refreshControl = dataRefresher
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.filterPrice?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! PriceCell
        //убираем выделение
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.appColor(.blueAssistantFon)
        cell.price = presenter.filterPrice?[indexPath.row]
        
        return cell
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        
        cell.accessoryType = .checkmark
        presenter.onCheckmarkSaveServise(indexPath: indexPath)
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)!
        presenter.offCheckmarkSaveServise(indexPath: indexPath)
        cell.accessoryType = .none
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = (cell.isSelected) ? .checkmark : .none
      // if presenter.checkmarkServises.filter({$0.idPrice.contains(presenter.filterPrice?[indexPath.row].idPrice ?? "0" )}).isEmpty == false{
      //    cell.accessoryType = .checkmark
      // }
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
        editAction.image = UIImage(#imageLiteral(resourceName: "icons8-школа-48"))
        deleteAction.backgroundColor = UIColor.appColor(.whiteAssistantwithAlpha)?.withAlphaComponent(0.3)
        editAction.backgroundColor = UIColor.appColor(.whiteAssistantwithAlpha)?.withAlphaComponent(0.4)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        return configuration
   
    }
    
    // MARK: - Refresher
    lazy var dataRefresher : UIRefreshControl = {
        let myRefreshControl = UIRefreshControl()
        myRefreshControl.tintColor =  .white
        myRefreshControl.backgroundColor = UIColor.appColor(.blueAssistantFon)
        myRefreshControl.addTarget(self, action: #selector(updateMyCategory), for: .valueChanged)
    return myRefreshControl
    }()
    
    @objc func updateMyCategory() {
        presenter.getPrice()
        presenter.checkTotalServices()
        // EndRefreshing
        dataRefresher.endRefreshing()
    }
    func updateSearchResults(for searchController: UISearchController) {
        presenter.filter(text: searchController.searchBar.text!)
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
    func succesTotalListPrice(totalList: String) {
        navigationItem.title = "Price: "+totalList+"$"
    }
    
    func succesReloadTable() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertMassage(title: "Error", message: error)
    }
    
   
    

}
