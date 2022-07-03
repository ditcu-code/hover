//
//  Activities.swift
//  Hover
//
//  Created by Aditya Cahyo on 03/07/22.
//

import SwiftUI

struct Activities: View {
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
                            Text("Exchanging gifts then kiss the cheeks").font(.title3).bold().shadow(color: .black, radius: 2, x: 1, y: 1)
                            HStack {
                                
                                Text(LoveLanguageEnum.physicalTouch.rawValue).font(.subheadline)
                                Text(LoveLanguageEnum.wordsOfAffirmation.rawValue).font(.subheadline)
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
    }
    //    }
}

struct Activities_Previews: PreviewProvider {
    static var previews: some View {
        Activities()
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
