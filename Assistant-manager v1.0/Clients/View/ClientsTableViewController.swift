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
        // #warning Incomplete implementation, return the number of rows
        return 10//clients.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      85
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: clientCellId, for: indexPath) as! TableClientCell
        cell.backgroundColor =  UIColor.appColor(.blueAssistantFon)
        cell.textLabel?.text = "Khlomov Anton"
        cell.detailTextLabel?.text = "Тестовый клиент. Пришел через instagram"
        //передаем массив в ячейку таблицы  [indexPath.row]- распределяем по ячейкам
       // cell.client = filterClients[indexPath.row]
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
        tableView.reloadData()
        // EndRefreshing
        dataRefresher.endRefreshing()
        print("обновить таблицу/выгрузить данные клиентов с сервера")
    }
    // MARK: - Button
    @objc fileprivate func addNewClient(){
        print("openFormNewClient")
    }

    
}

//связывание вью с презентером что бы получать от него ответ и делать какие то действия в вью
extension ClientsTableViewController: ClientsTabViewProtocol {
   
    

}
