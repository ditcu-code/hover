//
//  ProfilePage.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI
import CoreData

struct ProfilePage: View {
    @EnvironmentObject var globalObject: GlobalObject
    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            ScrollView {
                HStack{
                    Spacer()
                }.frame(height: UINavigationBar.appearance().bounds.height)
                ProfileCard(user: $globalObject.user)
                ProfileCard(user: $globalObject.partner)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ProfileDetail: View {
    @Binding var user: User
    
    var body: some View {
        HStack(alignment: .bottom) {
            ProfilePicture(user: $user)
            VStack {
                Text(user.wrappedName)
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct ProfilePicture: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var globalObject: GlobalObject
    @Binding var user: User
    
    @State private var showConfirmationDialog: Bool = false
    @State private var imagePickerMode: Int = 0
    @State private var showImagePicker: Bool = false
    @State private var imageUrl: String = ""
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ProfileImage(url: user.wrappedUrl)
            Text("EDIT")
                .font(.caption2)
                .frame(width: 76)
                .background(Color.gray)
        }
        .cornerRadius(5)
        .onTapGesture {
            showConfirmationDialog.toggle()
        }
        .sheet(isPresented: self.$showImagePicker) {
            ImagePicker(isShown: $showImagePicker, imageUrl: $imageUrl, pickerMode: self.imagePickerMode)
        }
        .onChange(of: imageUrl, perform: { _ in
            user.imageUrl = imageUrl
            try? moc.save()
            if user.isUser {
                globalObject.user = user
            } else {
                globalObject.partner = user
            }
        })
        .confirmationDialog("Update Profile Picture", isPresented: $showConfirmationDialog) {
            Button("Choose Photo") {
                self.showImagePicker = true
                self.imagePickerMode = 0
            }
            Button("Take Photo") {
                self.showImagePicker = true
                self.imagePickerMode = 1
            }
            Button("Cancel", role: .cancel) {
                
            }
        }
    }
}

struct ProfileImage: View {
    var url: String
    
    var body: some View {
        let pngURL = URL(fileURLWithPath: url)
        if url.isEmpty {
            Image(systemName: "camera")
                .frame(width: 76, height: 76)
                .foregroundColor(.black)
                .background(Color.darkGrey)
        } else {
            if let data = try? Data(contentsOf: pngURL, options: [.mappedIfSafe, .uncached]) {
                Image(uiImage: UIImage(data: data)!)
                    .resizable()
                    .frame(width: 76, height: 76)
                    .scaledToFit()
            } else {
                Image(systemName: "camera")
                    .frame(width: 76, height: 76)
                    .foregroundColor(.black)
                    .background(Color.darkGrey)
            }
        }
    }
}

struct ProfileCard: View {
    @Binding var user: User
    
    @State private var isNavigationActive: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(8)
                .offset(y: 10)
                .frame(width: 350, height: 280)
            VStack {
                ProfileDetail(user: $user)
                UserLoveLanguageList(user: $user)
                    .padding(.horizontal)
                HStack {
                    Spacer()
                    Button {
                        isNavigationActive.toggle()
                    } label: {
                        Text("Retake the test")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 190, height: 38)
                            .background(Color.activeButtonColor)
                            .cornerRadius(30)
                    }
                }.padding(.horizontal)
            }.padding(.horizontal)
        }
        .background {
            NavigationLink(isActive: $isNavigationActive) {
                QuestionLoveLanguage(user: user)
            } label: {
                
            }
        }
    }
}

struct UserLoveLanguageList: View {
    @Binding var user: User
    
    var body: some View {
        ForEach(LoveLanguageEnum.allCases.filter({ $0 != LoveLanguageEnum.combination
        }).sorted(by: { a, b in
            a.rawValue < b.rawValue
        }), id: \.self) { loveLanguage in
            HStack(alignment: .center) {
                LoveLanguageLogoBg(loveLanguageName: loveLanguage.rawValue, size: 30)
                Text(loveLanguage.rawValue)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text("\(getLoveLanguageValue(loveLanguage: loveLanguage.rawValue))%")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }.padding(.horizontal)
        }
    }
    
    func getLoveLanguageValue(loveLanguage: String) -> Int {
        switch(loveLanguage) {
        case LoveLanguageEnum.actOfService.rawValue:
            return Int(user.aos)
        case LoveLanguageEnum.physicalTouch.rawValue:
            return Int(user.pt)
        case LoveLanguageEnum.receivingGift.rawValue:
            return Int(user.rg)
        case LoveLanguageEnum.qualityTime.rawValue:
            return Int(user.qt)
        case LoveLanguageEnum.wordsOfAffirmation.rawValue:
            return Int(user.woa)
        default:
            return 0
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
            .environment(\.managedObjectContext, CoreDataPreviewHelper.preview.container.viewContext)
            .environmentObject(GlobalObject.shared)
    }
}
