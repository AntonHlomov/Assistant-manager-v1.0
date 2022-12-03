//
//  StartWorckViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 18/01/2022.
//
import UIKit

private let sliderTeamStartWorckCellIdentifier = "SliderTeamStartWorckCellIdentifier"
private let customerCardPaymentCellIndetifire = "CustomerCardPaymentCellIndetifire"
private let emptyCustomerCardPaymentCell = "EmptyCustomerCardPaymentCell"
private let searchCustomerCardPaymentCellIndetifire = "SearchCustomerCardPaymentCellIndetifire"

class StartWorckViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    var presenter: StartWorckViewPresenterProtocol!
    var searchBar : UISearchBar = {
      let search = UISearchBar()
      return search
    }()
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        //presenter.getDataForTeam()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        collectionView.backgroundColor = UIColor.appColor(.blueAssistantFon)
        self.collectionView.register(SliderTeamStartWorckCell.self, forCellWithReuseIdentifier: sliderTeamStartWorckCellIdentifier)
        self.collectionView.register(SearchCustomerCardPaymentCell.self, forCellWithReuseIdentifier: searchCustomerCardPaymentCellIndetifire)
        self.collectionView.register(CustomerCardPaymentCell.self, forCellWithReuseIdentifier: customerCardPaymentCellIndetifire)
        self.collectionView.register(EmptyCustomerCardPaymentCell.self, forCellWithReuseIdentifier: emptyCustomerCardPaymentCell)
        searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.tintColor = UIColor.appColor(.blueAssistantFon)
        searchBar.barTintColor = UIColor.appColor(.whiteAssistantFon)
        searchBar.barStyle = .black
        searchBar.sizeToFit()
        searchBar.searchTextField.backgroundColor = UIColor.appColor(.whiteAssistantFon)
        let textField = searchBar.value(forKey: "searchField") as! UITextField
        let glassIconView = textField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        glassIconView.tintColor = UIColor.appColor(.blueAssistantFon)
        //кнопка готово в клавеатуре
        addDoneButtonOnKeyboard()
    }
    //update on change of view orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        presenter.statusCheckUser()
    }
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return presenter.team?.count ?? 0
        case 1: return 1
        case 2 where presenter.filterCustomersCardsPayment?.isEmpty == true:
               return 1
        case 2 where presenter.filterCustomersCardsPayment?.isEmpty == false:
               return presenter.filterCustomersCardsPayment?.count ?? 0
        default: return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0: return  CGSize(width: view.frame.width, height: 100)
        case 1:  return CGSize(width: view.frame.width, height: 60)
        case 2 : return  CGSize (width: view.frame.width - 30, height: view.frame.width/1.5 + 100)
        default: return CGSize(width: 0, height: 0)
        }
    }
    // убераем разрыв между вью по горизонтали
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 { return 10 }
        return 30
    }
    // убераем разрыв между вью по вертикали
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 { return 0 }
        return 15
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0 where presenter.team?.isEmpty == false:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sliderTeamStartWorckCellIdentifier, for: indexPath) as! SliderTeamStartWorckCell
            cell.team = presenter.team?.first
            cell.checkMaster  = { [weak self] cell in
                self?.presenter.checkMaster = cell.master
                self?.presenter.getCustomerRecord()
            }
            return cell
        case 0 where presenter.team?.isEmpty == true:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sliderTeamStartWorckCellIdentifier, for: indexPath) as! SliderTeamStartWorckCell
            cell.textEmpty.text = "You don't have active reminders yet"
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCustomerCardPaymentCellIndetifire, for: indexPath) as! SearchCustomerCardPaymentCell
            cell.backgroundColor = UIColor.appColor(.blueAssistantFon)
            cell.addSubview(searchBar)
            searchBar.anchor(top: cell.topAnchor, leading: cell.leadingAnchor, bottom: cell.bottomAnchor, trailing: cell.trailingAnchor,pading: .init(top: 5, left: 0, bottom: 15, right: 0))
            return cell
        case 2 where presenter.filterCustomersCardsPayment?.isEmpty == false:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customerCardPaymentCellIndetifire, for: indexPath) as! CustomerCardPaymentCell
            cell.customerRecord = presenter.filterCustomersCardsPayment?[indexPath.row]
            self.presenter.completeArrayServicesPrices(indexPath: indexPath) { [](services,prices,total) in
                cell.serviesArey.text = services
                cell.priceLabel.text = prices
                cell.priceCos.text = total
            }
            cell.closeXButton.tag = indexPath.row
            cell.closeXButton.addTarget(self, action: #selector(del), for: .touchUpInside)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCustomerCardPaymentCell, for: indexPath) as! EmptyCustomerCardPaymentCell
            switch presenter.checkMaster?.id{
            case nil  :
                cell.textLebel.text = "Select a master to view his upcoming payments for today."
            default:
                cell.textLebel.text = "To date, there are no expected payments from customers yet."
            }
            return cell
        }
    
    }
    // нажатие на ячейки
   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("нажал\(indexPath)")
       presenter.pushPayClient(indexPath: indexPath)
   }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
         presenter.filter(text: searchText)
    }    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Ready", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        searchBar.inputAccessoryView = doneToolbar
    }
    @objc func doneButtonAction(){
        searchBar.resignFirstResponder()
    }
    // MARK: - delite visit
    @objc fileprivate func del(sender:UIButton){
       print("удалить запись")
        let index = sender.tag
        let id = presenter.filterCustomersCardsPayment?[index].idRecord ?? ""
        //выплывающее окно с подтверждением о выходе для кнопки удалить запись
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Delete visit", style: .destructive, handler: { (_) in
            self.presenter.deletCustomerRecorder(idCustomerRecorder: id)
            print("удалил")
           }))
        //кнопка отмена выплывающего окна с подтверждением о выходе для кнопки выйти
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
 }
}
extension StartWorckViewController{
    func alertRegistrationControllerMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
}
extension StartWorckViewController: StartWorckViewProtocol {

    func updateDataCustomerRecord(update: Bool, indexSetInt: Int) {
        guard update == true else {return}
        let indexSet = IndexSet(integer: indexSetInt)
        collectionView.reloadSections(indexSet)
    }
    func success() {
    }
   func failure(error: Error) {
       let error = "\(error.localizedDescription)"
       alertRegistrationControllerMassage(title: "Error", message: error)
   }
}
