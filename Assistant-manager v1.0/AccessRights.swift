//
//  AccessRights.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 05/12/2022.
//

import Foundation
import Firebase

enum AccessStatus: String {
case Individual = "Individual"
case Master = "Master"
case Administrator = "Administrator"
case Boss = "Boss"
}

extension Firestore{
    
    static func accessRights(_ accessStatus: AccessStatus,user: User?) -> DocumentReference? {
        guard let user = user else {return nil}
        let db = Firestore.firestore()
        switch accessStatus {
        case .Individual:
            let docRef = db.collection("users").document(user.uid)
            return docRef
        case .Master:
            let docRef = db.collection("group").document(user.idGroup)
            return docRef
        case .Administrator:
            let docRef = db.collection("group").document(user.idGroup)
            return docRef
        case .Boss:
            let docRef = db.collection("group").document(user.idGroup)
            return docRef
        }
    }
}
/*
Firestore.firestore().fetchCurrentUser { (user, err) in
    if let err = err {
        print("Feild to fech User", err.localizedDescription)
        return
    }
    idUserGroup = user?.idGroup ?? ""
}
*/

