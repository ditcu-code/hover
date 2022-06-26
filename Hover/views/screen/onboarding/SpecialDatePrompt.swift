//
//  SpecialDatePrompt.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct SpecialDatePrompt: View {
    @Binding var onboardingStep: Int
    
    var body: some View {
        VStack {
            Text("Special Date Prompt")
            Text("\(onboardingStep)")
            NavigationLink {
                LoveLanguagePrompt(onboardingStep: .constant(onboardingStep + 1))
            } label: {
                Image(systemName: "chevron.forward")
            }
        }
    }
}

struct SpecialDatePrompt_Previews: PreviewProvider {
    static var previews: some View {
        SpecialDatePrompt(onboardingStep: .constant(2))
    }
}
