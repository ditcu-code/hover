//
//  Func.swift
//  MC1-Group12
//
//  Created by Aditya Cahyo on 20/05/22.
//

import Foundation
import SwiftUI

let screenSize = UIScreen.main.bounds.width

func dateToString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy"
    let someDateTime = formatter.string(from: date)
    return someDateTime
}

func getLoveLanguageByCode(code: String) -> String {
    switch code {
    case "A":
        return "Words of Affirmation"
    case "B":
        return "Quality Time"
    case "C":
        return "Receiving Gifts"
    case "D":
        return "Acts of Service"
    case "E":
        return "Physical Touch"
    default:
        return ""
    }
}

func getLoveLanguageSymbolName(code: String) -> String {
    switch code {
    case "A":
        return "character.bubble.fill"
    case "B":
        return "clock.fill"
    case "C":
        return "gift.fill"
    case "D":
        return "fork.knife"
    case "E":
        return "hand.point.up.fill"
    default:
        return ""
    }
}

func getLoveLanguageColorName(code: String) -> String {
    switch code {
    case "A":
        return "WordOfAffirmationColor"
    case "B":
        return "QualityTimeColor"
    case "C":
        return "ReceivingGiftColor"
    case "D":
        return "ActOfServiceColor"
    case "E":
        return "PhysicalTouchColor"
    default:
        return ""
    }
}
