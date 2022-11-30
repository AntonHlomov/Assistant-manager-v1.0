//
//  ExpensesPresenter.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 19/02/2022.
//

import Foundation

protocol ExpensesViewProtocol: AnyObject {
    func success()
    func failure(error:Error)
    func updateCollectionView()
}
protocol ExpensesViewPresenterProtocol: AnyObject {
    init(view: ExpensesViewProtocol,networkService: ExpensesApiProtocol,router: LoginRouterProtocol,user: User?)
    func addNewExpenses()
    func openExpenses(indexPath: IndexPath)
    func filter(text: String)
    var filterExpenses: [Expense]?{get set}
    func geteExpenses()
}

class ExpensesPresentor: ExpensesViewPresenterProtocol{
   
    
   
    weak var view: ExpensesViewProtocol?
    var router: LoginRouterProtocol?
    let networkService:ExpensesApiProtocol!
    var user: User?
    var expenses: [Expense]?
    var filterExpenses: [Expense]?
    
    required init(view: ExpensesViewProtocol,networkService:ExpensesApiProtocol, router: LoginRouterProtocol,user: User?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.user = user
        self.expenses = [Expense]()
        self.filterExpenses = [Expense]()
        geteExpenses()
    }
    func geteExpenses(){
        networkService.geteExpensesAPI(user: self.user){ [weak self] result in
            guard self != nil else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.expenses = data
                    self?.filterExpenses = self?.expenses
                    self?.view?.updateCollectionView()
                case .failure(let error):
                    self?.view?.failure(error: error)
                  
                }
            }
        }
        
    }
    
    func addNewExpenses(){
        print("addNewExpenses")
        self.router?.showAddNewExpenses(user: self.user)
    }
    func openExpenses(indexPath: IndexPath){
        print("нажал openExpenses\(indexPath)")
    }
    func filter(text: String) {
        let textFilter = text
        if textFilter == "" {
            filterExpenses = expenses?.sorted{ $0.dateExpenseFormatDDMMYYYYHHMMSS > $1.dateExpenseFormatDDMMYYYYHHMMSS } }
        else {
            filterExpenses = expenses?.filter( {$0.nameUser.lowercased().contains(textFilter.lowercased()) || $0.fullNameUser.lowercased().contains(textFilter.lowercased()) || $0.nameExpense.lowercased().contains(textFilter.lowercased()) || $0.placeExpense.lowercased().contains(textFilter.lowercased()) ||
                $0.dateExpenseFormatDDMMYYYY.lowercased().contains(textFilter.lowercased()) ||
                $0.categoryExpense.lowercased().contains(textFilter.lowercased()) } )
        }
        self.view?.updateCollectionView()
    }

}

