//
//  ClientsTableViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 09/05/2022.
//  Table clients(Таблийца клиентов)


import UIKit

class ClientsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    
    let clientCellId = "ClientCellId"
    var presenter: ClientsTabViewPresenterProtocol!
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewClient))
       // tableView.refreshControl = dataRefresher
        tableView.register(TableClientCell.self, forCellReuseIdentifier: clientCellId)
        tableView.separatorColor = .clear //линии между ячейками цвет
        tableView.refreshControl = dataRefresher
        
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

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.filterClients?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      85
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: clientCellId, for: indexPath) as! TableClientCell
        cell.backgroundColor =  UIColor.appColor(.blueAssistantFon)
       // cell.textLabel?.text = "Khlomov Anton"
       // cell.detailTextLabel?.text = "Тестовый клиент. Пришел через instagram"
        //передаем массив в ячейку таблицы  [indexPath.row]- распределяем по ячейкам
        cell.client = presenter.filterClients?[indexPath.row]
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.goToPageClient(indexPathRowClient: indexPath.row)
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        // Создать константу для работы с кнопкой
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, completionHandler) in
            print("Delete")
            self?.presenter.deleteClient(indexPath: indexPath)
            self!.tableView.deleteRows(at: [indexPath], with: .top)
        }
        let editAction = UIContextualAction(style: .destructive, title: "Редактировать") { [weak self] (contextualAction, view, boolValue) in
            print("Redact")
            self?.presenter.redactClient(indexPath: indexPath)
            //tableView.reloadRows(at: [indexPath], with: .fade)
        }
        deleteAction.image = UIImage(systemName: "trash")
        editAction.image = UIImage(#imageLiteral(resourceName: "icons8-пользователь-без-половых-признаков-96"))
        deleteAction.backgroundColor = UIColor.appColor(.whiteAssistantwithAlpha)?.withAlphaComponent(0.3)
        editAction.backgroundColor = UIColor.appColor(.whiteAssistantwithAlpha)?.withAlphaComponent(0.4)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        return configuration
    }

   
    // MARK: - SearchResults
    func updateSearchResults(for searchController: UISearchController) {
        print("filter works")
        presenter.filter(text: searchController.searchBar.text!)
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
        presenter.getClients()
        // EndRefreshing
        dataRefresher.endRefreshing()
    }
    // MARK: - Button
    @objc fileprivate func addNewClient(){
        presenter.goToAddClient()
    }

    
}
extension ClientsTableViewController{
    func alertRegistrationControllerMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
}

//связывание вью с презентером что бы получать от него ответ и делать какие то действия в вью
extension ClientsTableViewController: ClientsTabViewProtocol {
    func succesReload() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertRegistrationControllerMassage(title: "Error", message: error)
    }
    
   
    

}
