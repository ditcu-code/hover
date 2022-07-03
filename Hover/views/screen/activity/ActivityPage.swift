//
//  ActivityPage.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct ActivityPage: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var globalObject: GlobalObject
    @FetchRequest(sortDescriptors: []) var activities : FetchedResults <ActivityList>
    @FetchRequest(sortDescriptors: []) var loveLanguages : FetchedResults <LoveLanguages>
    @State private var selectedActivity: [(ActivityList,LoveLanguages)] = []
    @State private var listActivities : [[(ActivityList,LoveLanguages)]] = [[]]
//    [
//      [(ActivityList, LoveLanguages)],
//      [(ActivityList, LoveLanguages)]
//    ]
//    [(ActivityList, LoveLanguages)]
    
    var loveLanguageUser: LoveLanguageUser {
        LoveLanguageUser(user: globalObject.user)
    }
    var loveLanguagePartner: LoveLanguageUser {
        LoveLanguageUser(user: globalObject.partner)
    }
    var body: some View {
//        NavigationView {
            ZStack(alignment:.topLeading) {
                Rectangle().fill(.clear)
                Image("bg-home").resizable().aspectRatio(contentMode: .fit).ignoresSafeArea()
                
               
                VStack(alignment: .leading) {
                    Text("Have you done this together 👩‍❤️‍👨 \nwith Rahul?").font(.headline).padding(.horizontal)
                    
                    HStack {
                    IconLL()
                        ZStack(alignment: .topLeading) {
                            RoundedCorner(radius: 8, corners: [.topLeft, .bottomLeft]).fill(.black).opacity(0.5)
                            VStack(alignment: .leading) {
                                if !selectedActivity.isEmpty {
                                    Text(selectedActivity[0].0.wrappedActivity).font(.title3).bold().shadow(color: .black, radius: 2, x: 1, y: 1)
                                        Spacer()
                                    HStack {
                                        Spacer()
                                        ForEach(selectedActivity[0].0.llArray) { ll in
                                            Text(ll.wrappedLLName).font(.subheadline)
                                        }
                                    }
                                }
                            }.padding()
                        }
                        .frame(height: 120)
                        .foregroundColor(.white)
                    }.padding(.leading)
                    Text("Have you tried these activities to Rahul? \nHe definitely will happy 🤩").font(.headline).padding()
                    HStack {
                        IconLL()
                        ZStack {
                            Image("bg-act-wordsofaffirmation").resizable().aspectRatio(contentMode: .fit)
                            
                            VStack(alignment: .leading) {
                                Text("Netflix and Chills at home sweet home").font(.title3).bold().padding(.leading, 15)
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text(LoveLanguageEnum.physicalTouch.rawValue).font(.subheadline)
                                }
                            }.padding(10)
                        }
                    }.padding(.leading).frame(height: 120)
                    
                }.border(.red)
                
                .navigationTitle("Activities")
            }
            .onAppear{
                getActivity()
//                print(listActivities)
//                print("=========================")
                self.selectedActivity = self.listActivities.randomElement()!
//                print(selectedActivity[0].0)
//                print(selectedActivity[0].0.llArray[0].)
            }
//        }
    }
    func getActivity(){
        print(globalObject.user)
        print(globalObject.partner)
        let userPrimaryLL = getPrimaryLoveLanguageUser()
        let partnerPrimaryLL = getPrimaryLoveLanguagePartner()
        let partnerSecondaryLL = getSecondaryLoveLanguagePartner()
        let selectedLL = loveLanguages.filter { ll in
            ll.wrappedLLName == userPrimaryLL || ll.wrappedLLName == partnerPrimaryLL || ll.wrappedLLName == partnerSecondaryLL
        }
        
        for activity in activities {
            for loveLanguage in selectedLL {
//                if loveLanguage.wrappedLLName == userPrimaryLL || loveLanguage.wrappedLLName == partnerPrimaryLL || loveLanguage.wrappedLLName == partnerSecondaryLL{
                    if !loveLanguage.wrappedLLName.isEmpty && !activity.wrappedActivity.isEmpty{
                        listActivities.append([(activity,loveLanguage)])
                    }
//                }
            }
        }
    }
    func getPrimaryLoveLanguageUser() -> String {
        return loveLanguageUser.getPrimaryLoveLanguage()
    }
    func getPrimaryLoveLanguagePartner() -> String {
        return loveLanguagePartner.getPrimaryLoveLanguage()
    }
    func getSecondaryLoveLanguagePartner() -> String {
        return loveLanguagePartner.getSecondaryLoveLanguage()
    }
}

struct ActivityPage_Previews: PreviewProvider {
    static var previews: some View {
        ActivityPage()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct IconLL: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8).fill(Color.bgCombination).frame(width: 45, height: 45)
            Image(systemName: "heart.fill").foregroundColor(.combination).font(.title2)
        }
    }
}
