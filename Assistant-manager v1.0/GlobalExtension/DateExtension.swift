//
//  DateExtension.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 06/03/2022.
//

import UIKit

extension Date {
    public  func todayDMYTimeFormat() -> String {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .day, value: 0, to: self)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY HH:mm"
        let dataEndFormatter = dateFormatter.string(from: date)
        return dataEndFormatter
    }
    public  func todayDMYFormat() -> String {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .day, value: 0, to: self)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let dataEndFormatter = dateFormatter.string(from: date)
        return dataEndFormatter
    }
    public  func todayMonthFormat() -> String {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .day, value: 0, to: self)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.YYYY"
        let dataEndFormatter = dateFormatter.string(from: date)
        return dataEndFormatter
    }
    public  func todayYarFormat() -> String {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .day, value: 0, to: self)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        let dataEndFormatter = dateFormatter.string(from: date)
        return dataEndFormatter
    }
    public  func addMin(n: Int) -> String {
        let calendar = Calendar.current
        let dateEnd = calendar.date(byAdding: .minute, value: n, to: self)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY HH:mm"
        let dataEndFormatter = dateFormatter.string(from: dateEnd)
        return dataEndFormatter
    }
    public  func addDay(n: Int) -> String {
        let calendar = Calendar.current
        let dateEnd = calendar.date(byAdding: .day, value: n, to: self)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY HH:mm"
        let dataEndFormatter = dateFormatter.string(from: dateEnd)
        return dataEndFormatter
    }
    
 //   public  func today(n: Int) -> String {
 //       let calendar = Calendar.current
 //       let dateEnd = calendar.date(byAdding: .minute, value: n, to: self)!
 //       let dateFormatter = DateFormatter()
 //       dateFormatter.dateFormat = "YYYY-MM-dd HH:mm"
 //       let dataEndFormatter = dateFormatter.string(from: dateEnd)
 //       return dataEndFormatter
 //   }
    
}
