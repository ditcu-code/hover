//
//  LoveLanguageUser.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 30/06/22.
//

import Foundation

struct LoveLanguageRatio {
    var llName: String
    var point: Int = 0
}

struct LoveLanguageUser {
    var user: User
    var lls: [LoveLanguageRatio] = []
    
    init(user: User) {
        self.user = user
        
        do {
            self.lls = try transformLLPointToRation()
        } catch {
            self.lls = [
                LoveLanguageRatio(llName: LoveLanguageEnum.actOfService.rawValue),
                LoveLanguageRatio(llName: LoveLanguageEnum.physicalTouch.rawValue),
                LoveLanguageRatio(llName: LoveLanguageEnum.qualityTime.rawValue),
                LoveLanguageRatio(llName: LoveLanguageEnum.wordsOfAffirmation.rawValue),
                LoveLanguageRatio(llName: LoveLanguageEnum.receivingGift.rawValue)
            ]
        }
    }
}

extension LoveLanguageUser {
    func getPrimaryLoveLanguage() -> String {
        let sortedLLs = lls.sorted { a, b in
            a.point > b.point
        }
        return sortedLLs.first?.llName ?? ""
    }
    
    func transformLLPointToRation() throws -> [LoveLanguageRatio] {
        let llAoS = LoveLanguageRatio(llName: LoveLanguageEnum.actOfService.rawValue, point: Int(user.aos))
        let llPT = LoveLanguageRatio(llName: LoveLanguageEnum.physicalTouch.rawValue, point: Int(user.pt))
        let llQT = LoveLanguageRatio(llName: LoveLanguageEnum.qualityTime.rawValue, point: Int(user.qt))
        let llWoA = LoveLanguageRatio(llName: LoveLanguageEnum.wordsOfAffirmation.rawValue, point: Int(user.woa))
        let llRG = LoveLanguageRatio(llName: LoveLanguageEnum.receivingGift.rawValue, point: Int(user.rg))
        
        return [llAoS, llPT, llQT, llWoA, llRG]
    }
}
