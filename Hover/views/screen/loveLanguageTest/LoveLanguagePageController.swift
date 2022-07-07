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
    var onboardingStep: Int = 0
    
    var body: some View {
        if showResult {
            TestResultPage(user: user, onboardingStep: self.onboardingStep + 1)
        } else {
            QuestionLoveLanguage(showResult: $showResult, user: user, onboardingStep: self.onboardingStep)
        }
    }
}

struct LoveLanguagePageController_Previews: PreviewProvider {
    static var previews: some View {
        LoveLanguagePageController(user: GlobalObject.shared.user)
            .environmentObject(GlobalObject.shared)
    }
}
