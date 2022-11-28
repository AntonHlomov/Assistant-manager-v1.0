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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
   
      //  navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewExpenses))
       // self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewExpenses))
        self.collectionView!.register(ExpensesCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(SearchBarCalendarModuleCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: searchBarCalendarIdentifier)
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
    }
    //update on change of view orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
   


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return    CGSize (width: view.frame.width, height: 120)
    }
    // убераем разрыв между вью по вертикали
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: searchBarCalendarIdentifier, for: indexPath) as! SearchBarCalendarModuleCell
        
        header.backgroundColor = UIColor.appColor(.blueAssistantFon)
        header.addSubview(searchBar)
        searchBar.anchor(top: header.topAnchor, leading: header.leadingAnchor, bottom: header.bottomAnchor, trailing: header.trailingAnchor,pading: .init(top: 5, left: 0, bottom: 15, right: 0))
            return header
        
    }
   
  

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ExpensesCell
       // cell.backgroundColor = UIColor.appColor(.redAssistant)
        // Configure the cell
    
        return cell
    }
    
    // нажатие на ячейки календаря
   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("нажал\(indexPath)")
      // presenter.pushRecorderClient(indexPath: indexPath)
   }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
       // presenter.filter(text: searchText)
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
    @objc fileprivate func addNewExpenses(){
        print("addNewExpenses")
        //presenter.goToAddClient()
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
    func success() {
        
    }

   func failure(error: Error) {
       let error = "\(error.localizedDescription)"
       alertRegistrationControllerMassage(title: "Error", message: error)
  
   }
}
