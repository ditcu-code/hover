//
//  Activities.swift
//  Hover
//
//  Created by Aditya Cahyo on 03/07/22.
//

import SwiftUI

struct Activities: View {
    var body: some View {
        NavigationView {
            ZStack(alignment:.top) {
                Rectangle().fill(.clear)
                Image("bg-home").aspectRatio(contentMode: .fit)
                
                VStack(alignment: .leading) {
                    Text("Have you done this together with Rahul?").font(.headline)
                    HStack{
                        ZStack {
                            RoundedRectangle(cornerRadius: 8).fill(Color.bgCombination).frame(width: 45, height: 45)
                            Image(systemName: "heart.fill").foregroundColor(.combination).font(.title2)
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 20).fill(.black).opacity(0.5)
//                            Text("Exchanging gifts then kiss the cheeks hello").background(.black).opacity(0.4).cornerRadius(20, corners: [.topLeft, .bottomLeft])
                        }
                    }
                }.border(.red)
                
                .navigationTitle("Activities")
            }
        }
    }
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
