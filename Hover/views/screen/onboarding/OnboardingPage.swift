//
//  OnboardingPage.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct OnboardingPage: View {
    @State private var onboardingStep: Int = 0
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var loveLanguages : FetchedResults <LoveLanguage>
    
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
