//
//  ClientsTableViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 09/05/2022.
//  Table clients(Таблийца клиентов)


import UIKit

class ClientsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    
    let clientCellId = "ClientCellId"
    
    var clients = [Client]()
    var filterClients = [Client]()
    
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
        return presenter.clients?.count ?? 0
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
        cell.client = presenter.clients?[indexPath.row]
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

   //     let vc = ClientPageViewController()
   //     let navController2 = UINavigationController(rootViewController: vc)
   //  //   vc.client = filterClientsCash[indexPath.row]
   //     idClientForOpenGlobal = filterClientsCash[indexPath.row].idClient
   //   //  clientForOpen = filterClientsCash[indexPath.row]
   //    navController2.modalPresentationStyle = .fullScreen
   //     self.present(navController2, animated: true, completion: nil)
        self.presenter.goToPageClient(indexPathRowClient: indexPath.row)

    }

   
    // MARK: - SearchResults
    func updateSearchResults(for searchController: UISearchController) {
        print("filter works")
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
        print("обновить таблицу/выгрузить данные клиентов с сервера")
    }
    // MARK: - Button
    @objc fileprivate func addNewClient(){
        print("openFormNewClient")
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
    func succes() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertRegistrationControllerMassage(title: "Error", message: error)
    }
    
   
    

}
