//
//  SpecialDateList.swift
//  Hover
//
//  Created by Eddo Careera Iriyanto Putra on 24/06/22.
//

import SwiftUI

struct SpecialDatePage: View {
    @State var navActive : Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ZStack(alignment: .topLeading) {
                Rectangle().fill(.clear)
                Image("bg-home")
                    .resizable()
                    .ignoresSafeArea()
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(.white)
                        .opacity(0.3)
                        .frame(height: 120)
                    
                    HStack(alignment: .center, spacing: 40) {
                        
                        VStack(alignment: .center) {
                            Text("JUL")
                                .font(.title2)
                                .bold()
                            Text("30")
                                .font(.system(size: 36, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.captionColor)
                                .frame(width: 90, height: 90)
                        )
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Wedding Anniversary")
                                    .font(.title3)
                                    .bold()
                                
                                Text("Dinner Wagyu Steak")
                                    .font(.subheadline)
                            }
                            Spacer()
                            
                            Image(systemName: "chevron.forward")
                                .font(.title2)
                        }.padding(.trailing, 10)
                        
                    }.padding(.leading, 50)
                }.padding(.top, 15)
            }.frame(height: 150)
            
            ScrollView {
                HStack{
                    VStack {
                        Text("AUG").font(.subheadline)
                        Text("02").font(.title).bold()
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 5)
                    
                    ZStack {
                        RoundedCorner(radius: 8, corners: [.topLeft, .bottomLeft]).fill(Color.combination)
                        RoundedCorner(radius: 8, corners: [.topLeft, .bottomLeft]).fill(Color.white).offset(x: 10, y:0).scaleEffect(0.99)
                        
                        HStack {
                            LoveLanguageLogoBg(loveLanguageName: LoveLanguageEnum.combination.rawValue, size: 45, cornerRadius: 8)
                            VStack(alignment: .leading) {
                                Text("Our First Dating").font(.headline)
                                Text("Giving Surprise Dinner at The Office").lineLimit(1)
                            }
                        }
                        .padding(.leading, 20)
                        .frame(height: 80)
                        
                    }
                    
                }
                
                HStack{

                    ZStack {
                        RoundedCorner(radius: 8, corners: [.topRight, .bottomRight]).fill(Color.combination)
                        RoundedCorner(radius: 8, corners: [.topRight, .bottomRight]).fill(Color.white).offset(x: -10, y:0).scaleEffect(0.99)
                        
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text("Our First Dating").font(.headline)
                                Text("Giving Surprise Dinner at The Office").lineLimit(1)
                            }
                            
                            LoveLanguageLogoBg(loveLanguageName: LoveLanguageEnum.combination.rawValue, size: 45, cornerRadius: 8)
                        }
                        .padding(.trailing, 25)
                        .padding(.leading, 10)
                        .frame(height: 80)
                        
                    }
                    
                    VStack {
                        Text("AUG").font(.subheadline)
                        Text("02").font(.title).bold()
                    }
                    .padding(.trailing, 20)
                    .padding(.leading, 5)
                    
                }
            }
            
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {navActive.toggle()}) {
                    Label("Hello", systemImage: "plus.circle.fill")
                        .labelStyle(.iconOnly)
                        .font(.title)
                }
            }
        }
        
        .sheet(isPresented: $navActive){
            SpecialDateForm()
        }
        
        .navigationTitle("Upcoming")
        .navigationBarTitleDisplayMode(.large)
        
    }
}

struct SpecialDatePage_Previews: PreviewProvider {
    static var previews: some View {
        SpecialDatePage()
    }
}
