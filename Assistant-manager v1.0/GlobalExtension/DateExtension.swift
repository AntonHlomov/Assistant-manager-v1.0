//
//  DateExtension.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 06/03/2022.
//

import UIKit

extension Date {
    public  func todayDMYHHMMSSFormat() -> String {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .day, value: 0, to: self)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY HH:mm:ss"
        let dataEndFormatter = dateFormatter.string(from: date)
        return dataEndFormatter
    }
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
    public  func tomorrowDMYFormat() -> String {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .day, value: 1, to: self)!
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
    public func formatterDateDMY(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let dataDMYFormatter = dateFormatter.string(from: date)
        return dataDMYFormatter
    }
    public func formatterDateDMYHM(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY HH:mm"
        let dataDMYHMFormatter = dateFormatter.string(from: date)
        return dataDMYHMFormatter
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
