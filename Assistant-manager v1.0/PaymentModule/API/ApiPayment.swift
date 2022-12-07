//
//  ApiPayment.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 15/07/2022.
//
import Foundation
import Firebase

protocol ApiPaymentServiceProtocol {
    func addNewTransactionUser(user: User?,card: Bool,cash: Bool,cashPrice: Double,cardPrice: Double,comment:String,customerRecordent: CustomerRecord?, master: Team?,completion: @escaping (Result<Bool,Error>) -> Void)
}

class ApiPayment: ApiPaymentServiceProtocol{
    func addNewTransactionUser(user: User?, card: Bool, cash: Bool, cashPrice: Double, cardPrice: Double, comment: String, customerRecordent: CustomerRecord?, master: Team?, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let status = user?.statusInGroup else {return}
        guard let db = Firestore.accessRights(AccessStatus(rawValue: status)!,user: user) else {return}
        
        guard let uidMaster = master?.idTeamMember else {return}
        guard let uidClient = customerRecordent?.idClient  else {return}
        let tax = 0.0
        let sumTotal = cashPrice + cardPrice - tax
        let idCustomerRecordForDelite = customerRecordent?.idRecord ?? ""
        let idTransactionUser = NSUUID().uuidString
        let dateTransactionDDMMYYYYHHMMSS = Date().todayDMYHHMMSSFormat()
        let dateTransactionDDMMYYYY = Date().tomorrowDMYFormat()
        let dateTransactionMMYYYY = Date().todayMonthFormat()
        let dateTransactionYYYY = Date().todayYarFormat()
        
        let data = ["idTransaction": idTransactionUser,
                    "idUserAdministrator":uid,
                    "idUserMaster": uid,
                    "checkNumber": "",
                    "dateTransactionFormatDDMMYYYYHHMMSS": dateTransactionDDMMYYYYHHMMSS,
                    "dateTransactionFormatDDMMYYYY": dateTransactionDDMMYYYY,
                    "dateTransactionFormatMMYYYY": dateTransactionMMYYYY,
                    "dateTransactionFormatYYYY": dateTransactionYYYY,
                    "idClient": uidClient,
                    "genderClient":customerRecordent?.genderClient ?? "",
                    "ageClient":customerRecordent?.ageClient ?? 0,
                    "dictServies":customerRecordent?.service! as Any,
                    "commit":comment,
                    "cash":cash,
                    "card":card,
                    "tax": tax ,
                    "cashPrice": cashPrice,
                    "cardPrice": cardPrice
        ] as [String : Any]
        let dateReportNewMonts = ["iDdateMMYYYY": dateTransactionMMYYYY,
                                  "checkCount":0,
                                  "expenses":0,
                                  "proceeds":0
        ] as [String : Any]
        let dateReportMonts = ["iDdateMMYYYY": dateTransactionMMYYYY,
                               "checkCount":FieldValue.increment(Int64(1)),
                               "proceeds":FieldValue.increment(Double(sumTotal))
        ] as [String : Any]
        
        // check if the report date exists, if not, create a new report month
        db.collection("FinancialReport").document(dateTransactionMMYYYY).getDocument { (document, error) in
            if let document = document, document.exists {
                // now monts for report
                db.collection("FinancialReport").document(dateTransactionMMYYYY).updateData(dateReportMonts)
            } else {
                // new monts for report
                db.collection("FinancialReport").document(dateTransactionMMYYYY).setData(dateReportNewMonts) { (error) in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    db.collection("FinancialReport").document(dateTransactionMMYYYY).updateData(dateReportMonts)
                }
            }
        }
        db.collection("TransactionUser").document(idTransactionUser).setData(data) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            db.updateData(["checkCount": FieldValue.increment(Int64(1))])
            db.collection("Clients").document(uidClient).updateData(["countVisits": FieldValue.increment(Int64(1)),"sumTotal":FieldValue.increment(Double(sumTotal))])
            db.collection("CustomerRecord").document(idCustomerRecordForDelite).delete()
            switch user?.statusInGroup {
            case "Individual":
                Firestore.firestore().collection("users").document(uid).updateData(["proceedsUser": FieldValue.increment(Double(sumTotal))])
                completion(.success(true))
            case "Master","Administrator","Boss":
                Firestore.firestore().collection("users").document(uid).updateData(["proceedsGroup": FieldValue.increment(Double(sumTotal))])
                completion(.success(true))
                Firestore.firestore().collection("users").document(uidMaster).updateData(["proceedsUserInGroup": FieldValue.increment(Double(sumTotal)),"checkCountInGroup": FieldValue.increment(Int64(1))])
                completion(.success(true))
            default: break
            }
            completion(.success(true))
        }
        
    }
    
}
