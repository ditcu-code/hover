//
//  SpecialDayDetail.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 05/07/22.
//

import SwiftUI

struct SpecialDayDetail: View {
    var body: some View {
        ZStack {
            Image("bgSpecialDayDetail")
                .resizable()
                .ignoresSafeArea()
            VStack {
                VStack {
                    VStack {
                        Text("AUG")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        Text("02")
                            .font(Font.system(size: 90))
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(width: 200, height: 200)
                    .background(Color("CaptionColor"))
                    .cornerRadius(12)
                    Text("Our First Dating")
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
                                    HStack {
                                        LoveLanguageLogoBg(loveLanguageName: LoveLanguageEnum.qualityTime.rawValue, size: 40, cornerRadius: 8)
                                        Text("Spend Time Together All Day")
                                            .lineLimit(nil)
                                    }
                                    HStack {
                                        LoveLanguageLogoBg(loveLanguageName: LoveLanguageEnum.combination.rawValue, size: 40, cornerRadius: 8)
                                        Text("Giving Surprise Dinner at The Most Famous Restaurant in The Town and Giving a Warm Hug")
                                            .lineLimit(nil)
                                    }
                                }
                                HStack {
                                    Image(systemName: "repeat.circle.fill")
                                        .resizable()
                                        .frame(width: 17, height: 17)
                                    Text("Repeat: Every year")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                }
                                HStack {
                                    Image(systemName: "alarm.fill")
                                        .resizable()
                                        .frame(width: 17, height: 17)
                                    Text("Remainder: 1 day before")
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
        }
    }
}

struct SpecialDayDetail_Previews: PreviewProvider {
    static var previews: some View {
        SpecialDayDetail()
    }
}
