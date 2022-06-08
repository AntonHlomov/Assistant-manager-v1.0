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
        configureUI()
        configureTable()
        handlers()
    }
    fileprivate func handlers(){
        newService.addTarget(self, action: #selector(addService), for: .touchUpInside)
    }
    
    fileprivate func  configureUI() {
        
        view.addSubview(newService)
        newService.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 0, left: 20, bottom: 5, right: 20), size: .init(width: 0, height: 35))
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom:  newService.topAnchor, trailing: view.trailingAnchor,  pading: .init(top: 3, left: 10, bottom: 20, right: 10), size: .init(width: 0, height: view.frame.height))
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    func configureTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.rgb(red: 31, green: 152, blue: 233)
        tableView.register(PriceCell.self, forCellReuseIdentifier: cell)
        tableView.separatorColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.price?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! PriceCell
        cell.lineView.backgroundColor = .white
        //убираем выделение
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.rgb(red: 31, green: 152, blue: 233)
        cell.textLabel?.textColor = .white
        cell.priceLabel.textColor = .white
        cell.priceNameCurrencyLabel.textColor = .white
        cell.circleView.backgroundColor = UIColor.rgb(red: 31, green: 152, blue: 233)
        cell.circleView.layer.borderColor =  UIColor.rgb(red: 255, green: 255, blue: 255) .cgColor
        cell.price = presenter.price?[indexPath.row]
        return cell
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
    
    func filure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertMassage(title: "Error", message: error)
    }
    
   
    

}
