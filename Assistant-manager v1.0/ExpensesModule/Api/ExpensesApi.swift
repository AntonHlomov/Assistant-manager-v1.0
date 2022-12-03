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
    func setExpense(user: User?,name: String, place: String, category: String, total: Double, imageСheck:UIImage,completion: @escaping(Result <Bool,Error>) -> Void){
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
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
            switch user?.statusInGroup {
            case "Individual":
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
                        
                       
                        Firestore.firestore().collection("users").document(uid).collection("Expense").document(idExpense).setData(dataExpense) { (error) in
                            if let error = error {
                                completion(.failure(error))
                            return
                            }
                            // check if the report date exists, if not, create a new report month
                            Firestore.firestore().collection("users").document(uid).collection("FinancialReport").document(dateExpenseFormatMMYYYY).getDocument { (document, error) in
                                if let document = document, document.exists {
                                    // now monts for report
                                    Firestore.firestore().collection("users").document(uid).collection("FinancialReport").document(dateExpenseFormatMMYYYY).updateData(["expenses":FieldValue.increment(Double(total))])
                                } else {
                                    // new monts for report
                                    Firestore.firestore().collection("users").document(uid).collection("FinancialReport").document(dateExpenseFormatMMYYYY).setData(dateReportNewMonts) { (error) in
                                        if let error = error {
                                         completion(.failure(error))
                                         return
                                        }
                                    }
                                }
                            }
                            
                            Firestore.firestore().collection("users").document(uid).updateData(["expensesUser": FieldValue.increment(Double(total))])
                            completion(.success(true))
                        }
                    }
                }
           // case "Master":break
            case "Administrator":break
            case "Boss","Master":
                let nameColection = "group"
                guard let idGroup = user?.idGroup else {return}
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
                        
                        Firestore.firestore().collection(nameColection).document(idGroup).collection("Expense").document(idExpense).setData(dataExpense) { (error) in
                            if let error = error {
                                completion(.failure(error))
                            return
                            }
                            // check if the report date exists, if not, create a new report month
                            Firestore.firestore().collection(nameColection).document(idGroup).collection("FinancialReport").document(dateExpenseFormatMMYYYY).getDocument { (document, error) in
                                if let document = document, document.exists {
                                    // now monts for report
                                    Firestore.firestore().collection(nameColection).document(idGroup).collection("FinancialReport").document(dateExpenseFormatMMYYYY).updateData(["expenses":FieldValue.increment(Double(total))])
                                } else {
                                    // new monts for report
                                    Firestore.firestore().collection(nameColection).document(idGroup).collection("FinancialReport").document(dateExpenseFormatMMYYYY).setData(dateReportNewMonts) { (error) in
                                        if let error = error {
                                         completion(.failure(error))
                                         return
                                        }
                                    }
                                }
                            }
                            
                            Firestore.firestore().collection(nameColection).document(idGroup).updateData(["expensesGroup": FieldValue.increment(Double(total))])
                            Firestore.firestore().collection("users").document(uid).updateData(["expensesUserInGroup": FieldValue.increment(Double(total))])
                            completion(.success(true))
                        }
                    }
                }
            default: break
            }
      }
    func geteExpensesAPI(user: User?,completion: @escaping(Result<[Expense]?,Error>) -> Void){
            guard let uid = Auth.auth().currentUser?.uid else {return}
            switch user?.statusInGroup {
            case "Individual":
                Firestore.firestore().collection("users").document(uid).collection("Expense").addSnapshotListener{ (snapshot, error) in
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
            case "Master":
                let nameColection = "group"
                guard let idGroup = user?.idGroup else {return}
                Firestore.firestore().collection(nameColection).document(idGroup).collection("Expense").whereField("idUser", isEqualTo: uid).addSnapshotListener{ (snapshot, error) in
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
            case "Administrator":break
            case "Boss":
                let nameColection = "group"
                guard let idGroup = user?.idGroup else {return}
                Firestore.firestore().collection(nameColection).document(idGroup).collection("Expense").addSnapshotListener{ (snapshot, error) in
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
            default: break
            }
    }
}
