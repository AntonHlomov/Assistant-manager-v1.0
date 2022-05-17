//
//  ClientsTableViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 09/05/2022.
//  Table clients(Таблийца клиентов)


import UIKit

class ClientsTableViewController: UITableViewController {
    let clientCellId = "ClientCellId"
    var clients = [Client]()
    var filterClients = [Client]()
    
    var presenter: ClientsTabViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
       // tableView.refreshControl = dataRefresher
        tableView.register(TableClientCell.self, forCellReuseIdentifier: clientCellId)
        tableView.separatorColor = .clear //линии между ячейками цвет
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

}

//связывание вью с презентером что бы получать от него ответ и делать какие то действия в вью
extension ClientsTableViewController: ClientsTabViewProtocol {
   
    

}
