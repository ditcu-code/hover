//
//  NotificationModel.swift
//  Hover
//
//  Created by Muhammad Aleandro on 03/07/22.
//

import Foundation
//enum Repeat: String, CaseIterable, Identifiable {
//    case none, monthly, yearly
//    var id: Self { self }
//}

enum Repeat: String, CaseIterable, Identifiable {
    case monthly = "every month", yearly = "every year"
    var id: Self { self }
}
//enum Alert: String, CaseIterable, Identifiable {
//    case none, oneDay, twoDay, threeDay, oneWeek, oneMinute
//    var id: Self { self }
//}

enum Alert: String, CaseIterable, Identifiable {
    case oneDay = "one day", twoDay = "two days", threeDay = "three days", oneWeek = "one week"
    var id: Self { self }
}
