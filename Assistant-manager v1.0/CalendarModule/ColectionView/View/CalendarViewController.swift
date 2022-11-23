//
//  CalendarViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 18/01/2022.
//
import Foundation
import UIKit

private let headerIdentifier = "HeaderIdentifierCell"
private let reminderSlaiderIdentifier = "ReminderSlaiderIdentifierCell"
private let searchBarCalendarIdentifier = "SearchBarCalendarCell"
private let calendarIdentifier = "CalendarIdentifierCell"
private let emptyCellIdentifier = "emptyCellCell"

class CalendarViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
   var presenter: CalendadrViewPresenterProtocol!
    lazy var revenue = 0.0   //выручка
    lazy var expenses = 0.0    //расходы
    var profit = 0.0     //прибыль
    var searchBar: UISearchBar = {
        let search = UISearchBar()
        return search
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        collectionView.backgroundColor = UIColor.appColor(.blueAssistantFon)
       // navigationController?.setNavigationBarHidden(true, animated: true)
        self.collectionView.register(UserProfileHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        self.collectionView.register(SliderReminderClientsCell.self, forCellWithReuseIdentifier: reminderSlaiderIdentifier)
        self.collectionView.register(SearchBarCalendarModuleCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: searchBarCalendarIdentifier)
        self.collectionView.register(EmptyCalendarCell.self, forCellWithReuseIdentifier: emptyCellIdentifier)
        self.collectionView.register(CalendarForDayCell.self, forCellWithReuseIdentifier: calendarIdentifier)
        self.collectionView.refreshControl = dataRefresher
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
        // ente and exit to background
        let notificationCenter = NotificationCenter.default
         // notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
          notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
          
     }
    @objc func appCameToForeground() {
        self.presenter.dataTodayTomorrow()
        print("notificationCenter appCameToForeground -> dataTodayTomorrow")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.statusCheckUser()
    }
    //update on change of view orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
   // override func viewWillAppear(_ animated: Bool) {
   //     super.viewWillAppear(animated) // No need for semicolon
   //
   // }
    // MARK: - свайп вниз для обновления
    lazy var dataRefresher : UIRefreshControl = {
        let myRefreshControl = UIRefreshControl()
        myRefreshControl.tintColor =  .white  // Изменить цвет ActivityIndicator
        myRefreshControl.backgroundColor = .clear
        myRefreshControl.addTarget(self, action: #selector(updateMyCollectionView), for: .valueChanged)
        return myRefreshControl
    }()
    @objc func updateMyCollectionView() {
        self.collectionView.reloadData()
        dataRefresher.endRefreshing()
        print("Refresher CalendarController")
    }
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return  1 //slaider reminder
        case 1:  return 0
        case 2 where presenter.filterCalendarToday?.isEmpty == true: return 1
        case 2 where presenter.filterCalendarToday?.isEmpty == false: return presenter.filterCalendarToday?.count ?? 0
        default: return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0: return CGSize(width: view.frame.width, height: 340)// main header
        case 1:  return CGSize(width: view.frame.width, height: 60)// search bar
        case 2 : return CGSize(width: 0, height: 0)
        default: return CGSize(width: 0, height: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0: return CGSize (width: view.frame.width, height: 180)
        case 1:  return CGSize (width: 0, height: 0)
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
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0: let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! UserProfileHeaderCell
            header.backgroundColor = UIColor.appColor(.whiteAssistantFon)
          //  self.presenter.getUserData{ []  (user) in
          //      guard let user = user else { return }
          //      header.user = user
          //  }
            header.user =  presenter.user
            header.profitCLL.text = String(format: "%.1f",presenter.profit!)
            header.revenueCell.text = String(format: "%.1f",presenter.revenueToday!)
            header.expensesCell.text = String(format: "%.1f",presenter.expensesToday!)
            //связь с кнопкой запись клиента в хидере
            header.clientButton.addTarget(self, action: #selector(goToClientTable), for: .touchUpInside)
            //связь с кнопкой настройки в хидере
            header.optionButton.addTarget(self, action: #selector(goToOptions), for: .touchUpInside)
            self.presenter.getStatistic()
   //         self.presenter.getRevenueStatistic(indicatorPeriod: "today"){ []  (revenueToday) in
   //             guard let revenueToday = revenueToday else { return }
   //             header.revenueCell.text = String(format: "%.1f",revenueToday)
   //         }
   //         self.presenter.getExpensesStatistic(indicatorPeriod: "today"){ []  (expensesToday) in
   //             guard let expensesToday = expensesToday else { return }
   //             header.expensesCell.text = String(format: "%.1f",expensesToday)
   //         }
   //         self.presenter.getProfitStatistic{ []  (profit) in
   //             header.profitCLL.text = String(format: "%.1f",profit!)
   //         }
         // header.revenueCell.text = String(format: "%.1f",self.revenue ?? 0.0 as CVarArg)
            return header
        default: let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: searchBarCalendarIdentifier, for: indexPath) as! SearchBarCalendarModuleCell
            header.backgroundColor = UIColor.appColor(.blueAssistantFon)
            header.addSubview(searchBar)
            searchBar.anchor(top: header.topAnchor, leading: header.leadingAnchor, bottom: header.bottomAnchor, trailing: header.trailingAnchor,pading: .init(top: 5, left: 0, bottom: 15, right: 0))
            return header
        }
    } 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reminderSlaiderIdentifier, for: indexPath) as! SliderReminderClientsCell
            cell.backgroundColor = UIColor.appColor(.whiteAssistantFon)
            switch self.presenter.reminders?.isEmpty{
            case false:
                cell.textEmpty.removeFromSuperview()
                cell.reminderSlaider = presenter.reminders ?? [Reminder]()
                cell.openReminderClient = { [weak self] cell in
                    self?.presenter.openClientWithReminder(reminder: cell.openClientWitchReminder)
                }
                cell.touchAddButoon = { [weak self] _ in
                    self?.presenter.touchAddButoon()
                }
            case true:
                cell.reminderS.removeAll()
                cell.textEmpty.text = "You don't have active reminders yet"
                cell.addSubview(cell.textEmpty)
                cell.textEmpty.anchor(top: cell.topAnchor, leading: cell.leadingAnchor, bottom: nil, trailing: cell.trailingAnchor, pading: .init(top: 43, left: 90, bottom: 0, right: 10))
            default: break
            }
            cell.reloadInputViews()
            return cell
        case 1 where presenter.filterCalendarToday?.isEmpty == true,
             2 where presenter.filterCalendarToday?.isEmpty == true:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellIdentifier, for: indexPath) as! EmptyCalendarCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: calendarIdentifier, for: indexPath) as! CalendarForDayCell
            cell.customerRecord = presenter.filterCalendarToday?[indexPath.row]
            self.presenter.completeArrayServicesPrices(indexPath: indexPath) { [](services,prices,total) in
                cell.serviesArey.text = services
                cell.priceLabel.text = prices
                cell.priceCos.text = total
            }
            cell.closeXButton.tag = indexPath.row
            cell.closeXButton.addTarget(self, action: #selector(del), for: .touchUpInside)
            switch presenter.filterCalendarToday?[indexPath.row].dateStartService{
            case presenter.today:
                cell.timeStartServiceCellText.text = "Today at:"
            case presenter.tomorrow:
                cell.timeStartServiceCellText.text = "Tomorrow at:"
            default: cell.timeStartServiceCellText.text = presenter.filterCalendarToday?[indexPath.row].dateStartService ?? ""
            }
            return cell
        }
    }
    // нажатие на ячейки календаря
   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("нажал\(indexPath)")
       presenter.pushRecorderClient(indexPath: indexPath)
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
    // MARK: - действие кнопки
    @objc fileprivate func goToClientTable(){
        // print("Клиенты")
        self.presenter.pushClientsButton()
    }
    // MARK: - Мой код  создаем селектор для нопка настройки
    @objc fileprivate func goToOptions(){
       // print("Настройки")
        self.presenter.pushOptionsButton()
    }
    // MARK: - delite visit
    @objc fileprivate func del(sender:UIButton){
       print("удалить запись")
        let index = sender.tag
        let id = presenter.filterCalendarToday?[index].idRecord ?? ""
        let masterId = presenter.filterCalendarToday?[index].idUserWhoWorks ?? ""
        //выплывающее окно с подтверждением о выходе для кнопки удалить запись
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Delete visit", style: .destructive, handler: { (_) in
            self.presenter.deletCustomerRecorder(idCustomerRecorder: id,masterId: masterId )
            print("удалил")
           }))
        //кнопка отмена выплывающего окна с подтверждением о выходе для кнопки выйти
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
 }
}
extension CalendarViewController{
    func alertAddInGroup(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.presenter.confirfAdInGroup()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            self.presenter.clinAddInGroup()
        })
        alertControler.addAction(okAction)
        alertControler.addAction(cancelAction)
        present(alertControler, animated: true, completion: nil)
    }
    func alertRegistrationControllerMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
    func alertOk(message: String){
        let alertControler = UIAlertController(title: "Ok", message: "\n\(message)", preferredStyle: .alert)
        present(alertControler, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alertControler.dismiss(animated: true, completion: nil)
           }
    }
}
//связывание вью с презентером что бы получать от него ответ и делать какие то действия в вью
extension CalendarViewController: CalendadrViewProtocol {
    func updateDataCalendar(update: Bool, indexSetInt: Int) {
        guard update == true else {return}
        let indexSet = IndexSet(integer: indexSetInt)
        collectionView.reloadSections(indexSet)
    }
    func reloadData() {
        print("reloadData")
        collectionView.reloadData()
    }
    func failure(error: Error) {
        let error = "\(error.localizedDescription)"
        alertRegistrationControllerMassage(title: "Error", message: error)
    }
    func alert(message: String) {
        alertOk(message: message)
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func openAlertAddInGroup(title: String, message: String){
        alertAddInGroup(title: title, message: message)
    }
   
}
