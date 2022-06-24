//
//  OnboardingPage.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct OnboardingPage: View {
    @State private var onboardingStep: Int = 0
    
    var body: some View {
        NavigationView {
            NamePrompt(onboardingStep: $onboardingStep)
        }
    }
}

struct OnboardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage()
    }
}
