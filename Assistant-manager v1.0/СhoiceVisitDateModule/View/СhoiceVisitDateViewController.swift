//
//  СhoiceVisitDateViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 11/06/2022.
//

import UIKit

class ChoiceVisitDateViewController: UIViewController {

    
    var presenter: СhoiceVisitDatePresenterProtocol!
    
    let cellMaster = "cellMaster"
    let cellIdTable = "cellIdTable"
    
    let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
    }()
  
    let scrollViewContainer: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.spacing = 10
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
    }()
    let masterCollectionView: UICollectionView = {
        
    let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 90)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    return collectionView
    }()
    
    var tableView:UITableView = {
       let tableView = UITableView()
       tableView.translatesAutoresizingMaskIntoConstraints = false
       return tableView
    }()

    let greenView: UIView = {
    let view = UIView()
   // view.heightAnchor.constraint(equalToConstant: 1200).isActive = true
    view.backgroundColor = .green
    return view
    }()
    
    fileprivate let confirm =  UIButton.setupButton(title: "Confirm", color: UIColor.appColor(.pinkAssistant)!, activation: true, invisibility: false, laeyerRadius: 12, alpha: 1, textcolor: UIColor.appColor(.whiteAssistant)!.withAlphaComponent(0.9))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        configureUI()
        handlers()
        
        masterCollectionView.delegate = self
        masterCollectionView.dataSource = self
        masterCollectionView.register(MasterCollectionViewCell.self, forCellWithReuseIdentifier: cellMaster)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.rgb(red: 31, green: 152, blue: 233)
        tableView.register(MastersScheduleTableViewCell.self, forCellReuseIdentifier: cellIdTable)
        tableView.separatorColor = .clear //линии между ячейками цвет
    }
    
    func configureUI(){
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0))
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollViewContainer.addArrangedSubview(masterCollectionView)
        masterCollectionView.anchor(top: nil, leading: scrollViewContainer.leadingAnchor, bottom: nil, trailing: scrollViewContainer.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: scrollViewContainer.frame.width, height: view.frame.height/8))
        
        scrollViewContainer.addArrangedSubview(tableView)
        tableView.anchor(top: masterCollectionView.bottomAnchor, leading: scrollViewContainer.leadingAnchor, bottom: nil, trailing: scrollViewContainer.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: scrollViewContainer.frame.width, height: view.frame.height/3))
        
        scrollViewContainer.addArrangedSubview(greenView)
        greenView.anchor(top: tableView.bottomAnchor, leading: scrollViewContainer.leadingAnchor, bottom: scrollViewContainer.safeAreaLayoutGuide.bottomAnchor, trailing: scrollViewContainer.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: scrollViewContainer.frame.width, height:view.frame.height/1.7))
        
        
        view.addSubview(confirm)
        confirm.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 0, left: 20, bottom: 5, right: 20), size: .init(width: 0, height: 40))
    }
    func handlers() {
        confirm.addTarget(self, action: #selector(puchConfirm), for: .touchUpInside)
    }
    @objc fileprivate func puchConfirm(){
        presenter.puchConfirm()
    }

}
extension ChoiceVisitDateViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
     return 15 //filtersCustomerRecordAll.count
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdTable, for: indexPath) as! MastersScheduleTableViewCell
        cell.backgroundColor = UIColor.appColor(.blueAssistantFon)
       // cell.customerRecord = filtersCustomerRecordAll[indexPath.row]
        //убираем выделение ячейки
        cell.selectionStyle = .none
        //стрелочка с права в ячейки
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
    return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     print("нажал на записсаного клиента")
    }
    // Цвет, при нажатии
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
    }
    
}
extension ChoiceVisitDateViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
   
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellMaster, for: indexPath) as! MasterCollectionViewCell
        cell.backgroundColor = UIColor.rgb(red: 81, green: 107, blue: 103).withAlphaComponent(0.5)
        cell.layer.cornerRadius = 20
        return cell
    }
  
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("нажал\(indexPath)")
     /*   let vc = PresentRoute()
        vc.starLabel.text = String(indexPath.row)
        let navControler = UINavigationController(rootViewController: vc)
        navControler.modalPresentationStyle = .fullScreen //окно появиться на весь экран
        self.present(navControler, animated: true, completion: nil)
       */
    }
}

extension ChoiceVisitDateViewController{
    func alertMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
}

extension ChoiceVisitDateViewController: СhoiceVisitDateProtocol {
    func succes() {
       print("succes ->ChoiceVisitDateViewController")
    }
    
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertMassage(title: "Error", message: error)
    }

}
