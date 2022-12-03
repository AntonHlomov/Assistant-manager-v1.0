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
    
    let greyView: UIView = {
    let view = UIView()
        view.backgroundColor = UIColor.appColor(.whiteAssistantFon)
    return view
    }()
    
    lazy var zigzagContainerViewUp = SketchBorderView()
    let cellIdTable = "cellIdTable"
    
    var tableView:UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var datePicker:UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker = UIDatePicker.init()
        datePicker.locale = Locale.autoupdatingCurrent
        datePicker.backgroundColor = .white
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .inline
        return datePicker
    }()
    lazy var zigzagContainerViewUDown = SketchBorderView()
    
    let greyDownView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.appColor(.whiteAssistantFon)
    return view
    }()
    fileprivate let addACommentButton =  UIButton.setupButton(title: "Add a comment", color: UIColor.appColor(.pinkAssistant)!, activation: true, invisibility: false, laeyerRadius: 12, alpha: 1, textcolor: UIColor.appColor(.whiteAssistant)!.withAlphaComponent(0.9))
    
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
        tableView.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        tableView.register(MastersScheduleTableViewCell.self, forCellReuseIdentifier: cellIdTable)
        tableView.separatorColor = .clear //color line(midle cell)
    }
    
    func configureUI(){
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0))
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollViewContainer.addArrangedSubview(masterCollectionView)
        masterCollectionView.anchor(top: nil, leading: scrollViewContainer.leadingAnchor, bottom: nil, trailing: scrollViewContainer.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: scrollViewContainer.frame.width, height: view.frame.height/8))
        
        scrollViewContainer.addArrangedSubview(greyView)
        greyView.anchor(top: masterCollectionView.bottomAnchor, leading: scrollViewContainer.leadingAnchor, bottom: nil, trailing: scrollViewContainer.trailingAnchor, pading: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: scrollViewContainer.frame.width, height:20))
        
        scrollViewContainer.addArrangedSubview(zigzagContainerViewUp)
        zigzagContainerViewUp.anchor(top: greyView.topAnchor, leading: view.leadingAnchor, bottom: greyView.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: -10, left: -10, bottom: 5, right: -10), size: .init(width:0, height:60))
        
        scrollViewContainer.addArrangedSubview(tableView)
        tableView.anchor(top: greyView.bottomAnchor, leading: scrollViewContainer.leadingAnchor, bottom: nil, trailing: scrollViewContainer.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: scrollViewContainer.frame.width, height: view.frame.height/3))
        
        scrollViewContainer.addArrangedSubview(greyDownView)
        greyDownView.anchor(top: tableView.bottomAnchor, leading: scrollViewContainer.leadingAnchor, bottom: nil, trailing: scrollViewContainer.trailingAnchor, pading: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: scrollViewContainer.frame.width, height:40))
        
        scrollViewContainer.addArrangedSubview(zigzagContainerViewUDown)
        zigzagContainerViewUDown.anchor(top: greyDownView.topAnchor, leading: view.leadingAnchor, bottom: greyDownView.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 5, left: -10, bottom: -10, right: -10), size: .init(width:0, height:20))
        
        scrollViewContainer.addArrangedSubview(datePicker)
        datePicker.anchor(top: greyDownView.bottomAnchor, leading: scrollViewContainer.leadingAnchor, bottom: scrollViewContainer.bottomAnchor, trailing: scrollViewContainer.trailingAnchor, pading: .init(top: 13, left: 0, bottom: 60, right: 0), size: .init(width: 0, height: view.frame.height/1.8))
        
        view.addSubview(addACommentButton)
        addACommentButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 0, left: 20, bottom: 5, right: 20), size: .init(width: 0, height: 40))
    }
    
    func handlers() {
        addACommentButton.addTarget(self, action: #selector(puchConfirm), for: .touchUpInside)
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
    }
    
    @objc fileprivate func puchConfirm(){
        presenter.puchConfirm()
    }
    
    @objc func dateChanged(_ sender: UIDatePicker?) {
        guard  let date = sender?.date else {return}
        presenter.dateChanged(senderDate: date )
    }
}
extension ChoiceVisitDateViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.customerRecordPast?.count ?? 0  //15 //filtersCustomerRecordAll.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdTable, for: indexPath) as! MastersScheduleTableViewCell
        cell.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        cell.customerRecord = presenter.customerRecordPast?[indexPath.row]
        //убираем выделение ячейки
        cell.selectionStyle = .none
        //стрелочка с права в ячейки
        cell.accessoryType = .disclosureIndicator
        var nameSev = ""
        for (service) in presenter.customerRecordPast?[indexPath.row].service ?? [[String : Any]](){
            let name: String = service["nameServise"] as! String
            
            if nameSev == "" {
                nameSev = name.capitalized
            } else {
            nameSev =  nameSev.capitalized + ("\n") + name.capitalized
            }
        }
        cell.serviesLabelClient.text = nameSev
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
    return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.presedClient(indexPath: indexPath)
    }
    // Цвет, при нажатии
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
    }
}
extension ChoiceVisitDateViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.team?.count ?? 0
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellMaster, for: indexPath) as! MasterCollectionViewCell
        cell.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        cell.layer.cornerRadius = 20
        cell.team = presenter.team?[indexPath.row]
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = UIColor.appColor(.pinkAssistant)?.cgColor
        presenter.pressedMastersChoice(indexPath: indexPath)
    }
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("отжал\(indexPath.row)")
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0
    }
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
     let customCell = cell as! MasterCollectionViewCell
         if customCell.isSelected {
             cell.layer.borderColor = UIColor.appColor(.pinkAssistant)?.cgColor
             cell.layer.borderWidth = 2
         } else {
             cell.layer.borderWidth = 0
         }
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
    func succesForTableCustomerRecordPast() {
        self.tableView.reloadData()
    }
    func attentionString(error: String) {
        alertMassage(title: "Please check", message: error)
    }
    func succesForTeamCollection() {
        self.masterCollectionView.reloadData()
    }
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertMassage(title: "Error", message: error)
    }
}
