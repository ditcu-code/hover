//
//  NotificationFunction.swift
//  Hover
//
//  Created by Muhammad Aleandro on 03/07/22.
//

import Foundation

extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
    
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var monthh: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.monthh != monthh
    }
}

func alertDate(_ date: Date, _ type: Alert) -> Date {
    switch type {
    case .oneDay:
        return Calendar.current.date(byAdding: .day, value: -1, to: date) ?? date
    case .twoDay:
        return Calendar.current.date(byAdding: .day, value: -2, to: date) ?? date
    case .threeDay:
        return Calendar.current.date(byAdding: .day, value: -3, to: date) ?? date
    case .oneWeek:
        return Calendar.current.date(byAdding: .weekOfMonth, value: -1, to: date) ?? date
//    case .oneMinute:
//        return Calendar.current.date(byAdding: .minute, value: -1, to: date) ?? date
        
        
//    default:
//        return date
    }
}

func dateCaller(_ date: Date) -> String {
    let calendar = Calendar.current
    let time: String = "\(date.formatted(date: .omitted, time: .shortened))"
    let fullDate: String = "\(date.formatted(date: .long, time: .shortened))"
    
    if calendar.isDateInYesterday(date) {
        return "Yesterday, \(time)"
    } else if calendar.isDateInToday(date) {
        return "Today, \(time)"
    } else if calendar.isDateInTomorrow(date) {
        return "Tomorrow, \(time)"
    } else {
        return fullDate
    }
}

  
