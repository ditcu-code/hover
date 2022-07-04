//
//  AddActivityForm.swift
//  Hover
//
//  Created by Aditya Cahyo on 04/07/22.
//

import SwiftUI

struct AddActivityForm: View {
    @Environment(\.dismiss) var dismiss
    @State var activityName: String = ""
    @State var loveLanguageSelected: LoveLanguageEnum = .combination
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Rohul will happy if I do this")
                    
                    TextField("", text: $activityName)
                        .textFieldStyle(.roundedBorder)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.accentColor))
                    Text("and this activity belongs to")
                    
                    Menu(loveLanguageSelected.rawValue.lowercased()) {
                        ForEach(LoveLanguageEnum.allCases, id: \.self) { item in
                            Button(item.rawValue.lowercased()) {
                                loveLanguageSelected = item
                            }
                        }
                    }.menuStyle(GrayButtonStyle(width: 220))
                    
                    Text("love language.")
                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                Spacer()
            }
            .padding()
            .font(.title2)
            .background(Color.backgroundColor)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        dismiss()
                    }
                }
            }
            .navigationTitle("New Plan")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddActivityForm_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityForm()
    }
}
