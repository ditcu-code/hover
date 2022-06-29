//
//  SpecialDatePrompt.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct SpecialDatePrompt: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var onboardingStep: Int
    @State var specialDateName: String = ""
    @State var date: Date = Date()
    @State var isNavigateActive: Bool = false
    
    var disabledForm: Bool {
        specialDateName.isEmpty
    }
    
    var progress: Int {
        onboardingStep + 1
    }
    
    var body: some View {
        VStack {
            VStack {
                ProgressView(value: (Float(progress) / Float(onboardingTotalStep)))
                    .animation(.easeInOut(duration: 1), value: onboardingTotalStep)
                    .padding(.bottom, 160)
                HStack {
                    Text("Tell me about\nyour special date\nwith your partner")
                        .font(.title)
                        .bold()
                    Spacer()
                }
            }.padding(.bottom, 50)
            TextField("Special Date", text: $specialDateName)
                .modifier(ClearButton(text: $specialDateName))
                .padding()
                .frame(height: 44)
                .background(.white)
                .cornerRadius(5)
                .shadow(color: .black, radius: 1)
            DatePicker(
                selection: $date,
                in: ...Date.now,
                displayedComponents: [.date]
            ) {
                Text("Date")
            }
            .padding()
            .frame(height: 44)
            .background(.white)
            .cornerRadius(5)
            .shadow(color: .black, radius: 1)
            Text("Insert special date, such as wedding anniversary, partner’s birthday, valentine’s day, etc")
                .font(.subheadline)
                .foregroundColor(Color("CaptionColor"))
            Spacer()
            Button {
                saveSpecialDate()
                self.isNavigateActive.toggle()
            } label: {
                OnboardingNextButton()
                    .padding(.bottom, 115)
            }.disabled(disabledForm)
            NavigationLink(isActive: self.$isNavigateActive) {
                IntroLoveLanguagePrompt(onboardingStep: .constant(onboardingStep + 1))
            } label: {
            }
        }
        .padding()
        .background(Color.backgroundColor)
        .navigationBarHidden(true)
    }
    
    func saveSpecialDate() {
        let specialDate = SpecialDay(context: moc)
        specialDate.id = UUID()
        specialDate.name = specialDateName
        specialDate.date = date
        
        try? moc.save()
    }
}

struct SpecialDatePrompt_Previews: PreviewProvider {
    static var previews: some View {
        SpecialDatePrompt(onboardingStep: .constant(3))
    }
}
