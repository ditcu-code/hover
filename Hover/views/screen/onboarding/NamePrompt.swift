//
//  UsernamePrompt.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct NamePrompt: View {
    @Binding var onboardingStep: Int
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                Text("Name Prompt")
                Text("\(onboardingStep)")
                NavigationLink {
                    if onboardingStep == 0 {
                        NamePrompt(onboardingStep: .constant(onboardingStep + 1))
                    } else {
                        SpecialDatePrompt(onboardingStep: .constant(onboardingStep + 1))
                    }
                } label: {
                    Image(systemName: "chevron.forward")
                }
            }
        }
    }
}

struct NamePrompt_Previews: PreviewProvider {
    static var previews: some View {
        NamePrompt(onboardingStep: .constant(0))
    }
}
