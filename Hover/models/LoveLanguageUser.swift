//
//  LoveLanguageUser.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 30/06/22.
//

import Foundation

struct LoveLanguageRatio {
    var llName: String
    var point: Int
}

struct LoveLanguageUser {
    var user: User
    var lls: [LoveLanguageRatio]
}

extension LoveLanguageUser {
    func getPrimaryLoveLanguage() -> String {
        let sortedLLs = lls.sorted { a, b in
            a.point > b.point
        }
        return sortedLLs.first?.llName ?? ""
    }
}
