//
//  UsernamePrompt.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct NamePrompt: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var onboardingStep: Int
    @State var username: String = ""
    @State var isNavigateActive: Bool = false
    
    var disabledForm: Bool {
        username.isEmpty
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    if self.onboardingStep == 0 {
                        Text("Hello,\nWhat is\nyour name?")
                            .font(.title)
                            .bold()
                    } else {
                        Text("\nWhat is\nyour partner name?")
                            .font(.title)
                            .bold()
                    }
                }
                Spacer()
            }
            Spacer(minLength: 3)
            TextField(self.onboardingStep == 0 ? "Your Name" : "Partner Name", text: $username)
                .padding()
                .frame(height: 44)
                .background(.white)
                .cornerRadius(5)
                .shadow(color: .black, radius: 1)
            Spacer()
            Button {
                saveName()
                self.isNavigateActive.toggle()
            } label: {
                OnboardingNextButton()
            }.disabled(disabledForm)
            NavigationLink(isActive: self.$isNavigateActive) {
                if self.onboardingStep == 0 {
                    NamePrompt(onboardingStep: .constant(onboardingStep + 1))
                } else if self.onboardingStep == 1 {
                    SpecialDatePrompt(onboardingStep: .constant(onboardingStep + 1))
                }
            } label: {
                // Image(systemName: "chevron.forward")
            }
            Spacer()
        }
        .padding()
        .background(Color("BackgroundColor")).ignoresSafeArea()
    }
    
    func saveName() {
        let user = User(context: moc)
        user.id = UUID()
        user.name = username
        user.type = onboardingStep == 1 ? 0 : 1
        try? moc.save()
    }
}

struct NamePrompt_Previews: PreviewProvider {
    static var previews: some View {
        NamePrompt(onboardingStep: .constant(0))
    }
}
