//
//  ExpensesViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 18/01/2022.
//

import UIKit

private let reuseIdentifier = "Cell"
private let searchBarCalendarIdentifier = "searchBarCalendarIdentifier"

class ExpensesViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    var presenter: ExpensesViewPresenterProtocol!
    var searchBar: UISearchBar = {
        let search = UISearchBar()
        return search }()
    
    fileprivate let addButton = UIButton.setupButtonImage( color: UIColor.appColor(.blueAndPink)!,activation: true,invisibility: false, laeyerRadius: 40/2, alpha: 0.6,resourseNa: "icons8-add-100")
    
    let fon: UIImageView = {
        let fon = UIImageView()
        fon.backgroundColor = UIColor.appColor(.blueAssistantFon)
        return fon
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.appColor(.blueAssistantFon)

        self.collectionView!.register(ExpensesCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(SearchBarCalendarModuleCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: searchBarCalendarIdentifier)
        self.collectionView.backgroundColor = UIColor.appColor(.blueAssistantFon)
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
        addDoneButtonOnKeyboard()
        
        addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        configureComponents()
    }
    //update on change of view orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    fileprivate func configureComponents(){
        view.addSubview(searchBar)
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,pading: .init(top: 16, left: 0, bottom: 0, right: 0))
        searchBar.layer.zPosition = 1
        
        view.addSubview(fon)
        fon.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: searchBar.bottomAnchor, trailing: view.trailingAnchor,pading: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        view.addSubview(addButton)
        addButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, pading: .init(top: 0, left: 0, bottom: view.frame.height/6, right: -10), size: .init(width: 70, height: 50))
        addButton.layer.cornerRadius = 12
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return presenter.filterExpenses?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return    CGSize (width: view.frame.width, height: 140)
    }
    // убераем разрыв между вью по вертикали
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: searchBarCalendarIdentifier, for: indexPath) as! SearchBarCalendarModuleCell
      //  header.backgroundColor = UIColor.appColor(.blueAssistantFon)
      //  header.addSubview(searchBar)
      //  searchBar.anchor(top: header.topAnchor, leading: header.leadingAnchor, bottom: header.bottomAnchor, trailing: //header.trailingAnchor,pading: .init(top: 5, left: 0, bottom: 15, right: 0))
            return header
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ExpensesCell
         cell.backgroundColor =  UIColor.appColor(.blueAssistantFon)
         cell.expenses = presenter.filterExpenses?[indexPath.row]
         return cell
    }
    
    // нажатие на ячейки календаря
     override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       presenter.openExpenses(indexPath: indexPath)
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
    @objc fileprivate func add(){
        presenter.addNewExpenses()
    }

}
extension ExpensesViewController{
    func alertRegistrationControllerMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
}

//связывание вью с презентером что бы получать от него ответ и делать какие то действия в вью
extension ExpensesViewController: ExpensesViewProtocol {
    func updateCollectionView(){
     collectionView.reloadData()
    }
    func success(){
    }
    func failure(error: Error) {
       let error = "\(error.localizedDescription)"
       alertRegistrationControllerMassage(title: "Error", message: error)
    }
}
