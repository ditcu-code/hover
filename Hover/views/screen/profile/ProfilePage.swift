//
//  ProfilePage.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI
import CoreData

struct ProfilePage: View {
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LoveLanguages.llName, ascending: true)]) var loveLanguages : FetchedResults <LoveLanguages>
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            VStack {
                ProfileDetail()
//                UserLoveLanguageList()
            }
            Spacer()
        }
    }
}

struct ProfileDetail: View {
    var body: some View {
        HStack(alignment: .bottom) {
            LoveLanguageLogoBg(loveLanguageName: "Physical Touch", size: 76)
            VStack {
                Text("Lucifer")
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            Spacer()
        }
    }
}

struct UserLoveLanguageList: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LoveLanguages.llName, ascending: true)]) var loveLanguages : FetchedResults <LoveLanguages>
    
    var body: some View {
        ForEach(loveLanguages, id: \.self) { loveLanguage in
            HStack(alignment: .center) {
                LoveLanguageLogoBg(loveLanguageName: loveLanguage.llName ?? "Unknown")
                Text(loveLanguage.llName ?? "Unknown")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text("\(getLoveLanguageValue(loveLanguage: loveLanguage.llName ?? "Unknown"))")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
        }
    }
    
    func getLoveLanguageValue(loveLanguage: String) -> Int {
        switch(loveLanguage) {
        case LoveLanguageEnum.actOfService.rawValue:
            return 0
        case LoveLanguageEnum.physicalTouch.rawValue:
            return 0
        case LoveLanguageEnum.receivingGift.rawValue:
            return 0
        case LoveLanguageEnum.qualityTime.rawValue:
            return 0
        case LoveLanguageEnum.wordsOfAffirmation.rawValue:
            return 0
        default:
            return 0
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
        ProfileDetail()
//        UserLoveLanguageList()
    }
}
