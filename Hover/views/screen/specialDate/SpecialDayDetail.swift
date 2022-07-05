//
//  SpecialDayDetail.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 05/07/22.
//

import SwiftUI

struct SpecialDayDetail: View {
    var selectedSpecialDay: SpecialDay
    
    var body: some View {
        ZStack {
            Image("bgSpecialDayDetail")
                .resizable()
                .ignoresSafeArea()
            VStack {
                VStack {
                    VStack {
                        Text(dateToString(selectedSpecialDay.wrappedDate, dateFormat: "MMM").uppercased())
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        Text(dateToString(selectedSpecialDay.wrappedDate, dateFormat: "dd"))
                            .font(Font.system(size: 90))
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(width: 200, height: 200)
                    .background(Color("CaptionColor"))
                    .cornerRadius(12)
                    Text(selectedSpecialDay.wrappedName)
                        .font(.largeTitle)
                        .bold()
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "list.number")
                                        .resizable()
                                        .frame(width: 17, height: 17)
                                    Text("Your Activity Plan:")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                }
                                VStack(alignment: .leading) {
                                    if selectedSpecialDay.activityInSDArray.isEmpty {
                                        Text("Have you planned activities?")
                                    } else {
                                        ForEach(selectedSpecialDay.activityInSDArray, id: \.self) {
                                            act in
                                            HStack {
                                                LoveLanguageLogoBg(loveLanguageName: getLLLogo(llData: act.llArray), size: 40, cornerRadius: 8)
                                                Text(act.wrappedActivity)
                                                    .lineLimit(nil)
                                            }
                                        }
                                    }
                                }
                                HStack {
                                    Image(systemName: "repeat.circle.fill")
                                        .resizable()
                                        .frame(width: 17, height: 17)
                                    Text("Repeat: \(selectedSpecialDay.wrappedRepeatNotif)")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                }
                                HStack {
                                    Image(systemName: "alarm.fill")
                                        .resizable()
                                        .frame(width: 17, height: 17)
                                    Text("Remainder: \(selectedSpecialDay.wrappedAlert)")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    .cornerRadius(8)
                    .background(Color.white)
                }
                .padding()
                Spacer()
                Button {
                    
                } label: {
                    Text("Update this event")
                        .bold()
                        .frame(width: 300, height: 50)
                        .foregroundColor(.white)
                        .background(Color.activeButtonColor)
                        .cornerRadius(30)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Text("Delete")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

struct SpecialDayDetail_Previews: PreviewProvider {
    static var previews: some View {
        SpecialDayDetail(selectedSpecialDay: GlobalObject.shared.specialDayWithAct)
    }
}
