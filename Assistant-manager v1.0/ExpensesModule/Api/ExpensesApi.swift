//
//  ExpensesApi.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 28/11/2022.
//
import Foundation
import Firebase
import UIKit

protocol ExpensesApiProtocol {
    func geteExpensesAPI(user: User?,completion: @escaping(Result<[Expense]?,Error>) -> Void)
    func setExpense(user: User?,name: String, place: String, category: String, total: Double, imageСheck:UIImage,completion: @escaping(Result<Bool,Error>) -> Void)
}

class ExpensesApi: ExpensesApiProtocol {
    func setExpense(user: User?, name: String, place: String, category: String, total: Double, imageСheck: UIImage, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        
        guard let nameUser = user?.name else {return}
        guard let fullNameUser = user?.fullName else {return}
        guard let profileImageUser = user?.profileImage else {return}
        let idExpense = NSUUID().uuidString
        let now = Date()
        let dateExpenseFormatDDMMYYYYHHMMSS = now.todayDMYHHMMSSFormat()
        let dateExpenseFormatDDMMYYYY = now.todayDMYFormat()
        let dateExpenseFormatMMYYYY = now.todayMonthFormat()
        let dateExpenseFormatYYYY = now.todayYarFormat()
        let dateReportNewMonts = ["iDdateMMYYYY": dateExpenseFormatMMYYYY,
                                  "checkCount":0,
                                  "expenses":total,
                                  "proceeds":0
        ] as [String : Any]
        guard let uploadData = imageСheck.jpegData(compressionQuality: 0.3) else {return}
        let storageRef = Storage.storage().reference().child("Expense_image").child(idExpense)
        storageRef.putData(uploadData, metadata: nil) { (_, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            // print("Загрузка фотографии клиента прошла успешно!")
            //получаем обратно адрес картинки
            storageRef.downloadURL { (downLoardUrl, error) in
                guard let profileImageClientUrl = downLoardUrl?.absoluteString else {return}
                if let error = error {
                    completion(.failure(error))
                    return
                }
                let dataExpense = ["idExpense": idExpense,
                                   "idUser":uid,
                                   "nameUser":nameUser,
                                   "fullNameUser":fullNameUser,
                                   "profileImageUser":profileImageUser,
                                   "nameExpense":name,
                                   "priceExpense":total,
                                   "placeExpense": place,
                                   "adresURLPhotoCheckExpense":profileImageClientUrl,
                                   "categoryExpense":category,
                                   "dateExpenseFormatDDMMYYYYHHMMSS":dateExpenseFormatDDMMYYYYHHMMSS,
                                   "dateExpenseFormatDDMMYYYY":dateExpenseFormatDDMMYYYY,
                                   "dateExpenseFormatMMYYYY":dateExpenseFormatMMYYYY,
                                   "dateExpenseFormatYYYY":dateExpenseFormatYYYY] as [String : Any]
                
                db.collection("Expense").document(idExpense).setData(dataExpense) { (error) in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    // check if the report date exists, if not, create a new report month
                    db.collection("FinancialReport").document(dateExpenseFormatMMYYYY).getDocument { (document, error) in
                        if let document = document, document.exists {
                            // now monts for report
                            db.collection("FinancialReport").document(dateExpenseFormatMMYYYY).updateData(["expenses":FieldValue.increment(Double(total))])
                        } else {
                            // new monts for report
                            db.collection("FinancialReport").document(dateExpenseFormatMMYYYY).setData(dateReportNewMonts) { (error) in
                                if let error = error {
                                    completion(.failure(error))
                                    return
                                }
                            }
                        }
                    }
                    
                    switch user?.statusInGroup {
                    case "Individual":
                        db.updateData(["expensesGroup": FieldValue.increment(Double(total))])
                        completion(.success(true))
                    case "Boss","Master","Administrator":
                        db.updateData(["expensesGroup": FieldValue.increment(Double(total))])
                        Firestore.firestore().collection("users").document(uid).updateData(["expensesUserInGroup": FieldValue.increment(Double(total))])
                        completion(.success(true))
                    default:
                        completion(.failure("Data write error <expensesGroup>" as! Error))
                        break
                    }
                }
            }
        }
   
    }
    
    func geteExpensesAPI(user: User?, completion: @escaping (Result<[Expense]?, Error>) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        
        db.collection("Expense").addSnapshotListener{ (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            var expenses = [Expense]()
            expenses.removeAll()
            snapshot?.documents.forEach({ (documentSnapshot) in
                let expenseDictionary = documentSnapshot.data()
                let expense = Expense(dictionary: expenseDictionary)
                expenses.append(expense)
            })
            completion(.success(expenses))
        }
    }
}
