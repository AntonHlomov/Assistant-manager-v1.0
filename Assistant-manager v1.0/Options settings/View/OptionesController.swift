//
//  OptionesController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 12/05/2022.
//

import UIKit

class OptionesController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    var presenter: OptionesViewPresenterProtocol!
    let cellHeader = "cellHeader"
    let cell = "cell"
    var setings = ["Clients","Price","Team","Category","Teacher","Exit","Remove"]
    
    var tableView:UITableView = {
       let tableView = UITableView()
       tableView.translatesAutoresizingMaskIntoConstraints = false
       return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.appColor(.whiteAndPinkDetailsAssistant) // меняем цвет кнопки выйти
        configureUI()
        buildingTable()
       
    }
    fileprivate func configureUI() {
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom:view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor,  pading: .init(top: view.frame.height/50, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 0))
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func buildingTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.rgb(red: 31, green: 152, blue: 233)
        tableView.register(HeaderOptinesTableViewCell.self, forCellReuseIdentifier: cellHeader)
        tableView.register(OptionesTableViewCell.self, forCellReuseIdentifier: cell)
        tableView.separatorColor = .clear //линии между ячейками цвет
    }
    
    //MARK: TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return setings.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellHeader, for: indexPath) as! HeaderOptinesTableViewCell
                cell.backgroundColor = UIColor.rgb(red: 31, green: 152, blue: 233)
                //cell.user = userApp
            return cell
        
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! OptionesTableViewCell
            cell.backgroundColor = UIColor.rgb(red: 31, green: 152, blue: 233)
            cell.textLabel?.text = setings[indexPath.row]
            cell.textLabel?.textColor = .white
            
            
            return cell
        }
    }
    
    @objc func backTapped() {
        presenter.goToBackTappedViewFromRight()
    }
}
//связывание вью с презентером что бы получать от него ответ и делать какие то действия в вью
extension OptionesController: OptionesViewProtocol {

}
