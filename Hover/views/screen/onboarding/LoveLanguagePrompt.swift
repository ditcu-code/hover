//
//  LoveLanguagePrompt.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct LoveLanguagePrompt: View {
    @Binding var onboardingStep: Int
    
    var body: some View {
        VStack {
            Text("Love Language Prompt")
            Text("\(onboardingStep)")
            if onboardingStep == 3 {
                NavigationLink {
                    LoveLanguagePrompt(onboardingStep: .constant(onboardingStep + 1))
                } label: {
                    Image(systemName: "chevron.forward")
                }
            } else {
                Button {
                    withAnimation {
                        UserDefaults.standard.set(false, forKey: "isNewUser")
                    }
                } label: {
                    Image(systemName: "chevron.forward")
                }

            }
        }
    }
}

struct LoveLanguagePrompt_Previews: PreviewProvider {
    static var previews: some View {
        LoveLanguagePrompt(onboardingStep: .constant(3))
    }
}
