//
//  LoveLanguagePageController.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 05/07/22.
//

import SwiftUI

struct LoveLanguagePageController: View {
    @EnvironmentObject var globalObject: GlobalObject
//    @Binding var onboardingStep: Int
    @State private var showResult: Bool = false
    var user: User
    
    var body: some View {
        if showResult {
            TestResultPage(user: user)
        } else {
            QuestionLoveLanguage(showResult: $showResult, user: user)
        }
    }
}

struct LoveLanguagePageController_Previews: PreviewProvider {
    static var previews: some View {
        LoveLanguagePageController(user: GlobalObject.shared.user)
            .environmentObject(GlobalObject.shared)
    }
}
