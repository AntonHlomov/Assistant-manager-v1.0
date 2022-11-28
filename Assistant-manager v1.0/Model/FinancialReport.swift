//
//  FinancialReport.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 27/11/2022.
//

import Foundation

class FinancialReport{
    
    var iDdateMMYYYY: String! // <-- id
    var checkCount: Int?
    var expenses: Double?
    var proceeds: Double?

    init (dictionary:[String:Any]){
        self.iDdateMMYYYY = dictionary["iDdateMMYYYY"] as? String ?? ""
        self.checkCount = dictionary["checkCount"] as? Int ?? 0
        self.expenses = dictionary["expenses"] as? Double ?? 0
        self.proceeds = dictionary["proceeds"] as? Double ?? 0
        
    }
}

