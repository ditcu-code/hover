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
    var user: User = User()
    var partner: User = User()
    
    var disabledForm: Bool {
        username.isEmpty
    }
    
    var progress: Int {
        onboardingStep + 1
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            VStack {
                VStack {
                    ProgressView(value: (Float(progress) / Float(onboardingTotalStep)))
                        .animation(.easeInOut(duration: 1), value: onboardingTotalStep)
                        .padding(.bottom, 160)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(self.onboardingStep == 0 ? "Hello,\n": "and...\n")What is\n\(self.onboardingStep == 0 ? "your": "your partner") name?")
                                .font(.title)
                                .bold()
                        }
                        Spacer()
                    }
                }.padding(.bottom, 50)
                TextField(self.onboardingStep == 0 ? "Your Name" : "Partner Name", text: $username)
                    .modifier(ClearButton(text: $username))
                    .padding()
                    .frame(height: 44)
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(color: .black, radius: 1)
                Spacer()
                NavigationLink(isActive: self.$isNavigateActive) {
                    if self.onboardingStep == 0 {
                        NamePrompt(onboardingStep: .constant(onboardingStep + 1))
                    } else if self.onboardingStep == 1 {
                        SpecialDatePrompt(onboardingStep: .constant(onboardingStep + 1))
                    }
                } label: {
                }.hidden()
                Button {
                    saveName()
                    self.isNavigateActive.toggle()
                } label: {
                    OnboardingNextButton()
                        .padding(.bottom, 115)
                }
                .disabled(disabledForm)
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
    
    func saveName() {
        let user = User(context: moc)
        user.id = UUID()
        user.name = username
        user.isUser = onboardingStep == 0 ? true : false
        try? moc.save()
        
        if user.isUser {
            GlobalObject.shared.user = user
        } else {
            GlobalObject.shared.partner = user
        }
    }
}

struct NamePrompt_Previews: PreviewProvider {
    static var previews: some View {
        NamePrompt(onboardingStep: .constant(0))
    }
}
