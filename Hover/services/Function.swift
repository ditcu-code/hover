//
//  Func.swift
//  MC1-Group12
//
//  Created by Aditya Cahyo on 20/05/22.
//

import Foundation

func dateToString(_ date: Date, dateFormat: String = "dd MMM yyyy") -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    let someDateTime = formatter.string(from: date)
    return someDateTime
}
