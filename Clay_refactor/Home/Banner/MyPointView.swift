//
//  MyPointView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/15.
//

import SwiftUI

struct MyPointView: View {
    
    @ObservedObject var datas = firebaseData
    @StateObject var homeViewModel = HomeViewModel()
    @Binding var showingPopup : Bool
    
    var body: some View {
        VStack(spacing : 3){
            
            HStack(spacing : 0){
                Rectangle()
                    .frame(width: 2, height: 17)
                    .foregroundColor(Color.init("systemColor"))
                    .padding(.bottom, 1)
                
                Text("나의 포인트")
                    .font(Font.custom(systemFont, size: 17))
                    .fontWeight(.bold)
                    .padding(.leading, 7)
               
                Text(homeViewModel.timeNow)
                    .foregroundColor(Color.white)
                    .onReceive(timer) { _ in
                        
                            homeViewModel.timeNow = dateFormatter.string(from: Date())
                    }
                Spacer()
                Button(action: {
                    
                   showingPopup.toggle()
                  
                }, label: {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(Color.init("darkGreen"))
                        .padding(.trailing, 5)
                })
                
            }.padding([.leading, .top,.trailing])
                .padding(.top,25)
                
               
           
            VStack(spacing : 0){
                
                HStack(spacing: 0){
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        ZStack{
                            Image(systemName: "lightbulb")
                                .resizable()
                                .frame(width: 8, height: 13, alignment: .center)
                                .foregroundColor(.black)
                                .zIndex(1)
                            Circle()
                                .foregroundColor(Color.init("bulbYellow"))
                                .frame(width: 15, height: 15, alignment: .center)
                        }
                    })
                   
                    Text("포인트 전환율을 올려보세요!")
                        .font(Font.custom(systemFont, size: 10))
                        .fontWeight(.light)
                        .padding(.leading, 3)
                     Spacer()
                }
                .padding(.leading, 15)
                .padding(.top, 7)
                
                
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        
                        Text("\((Int(datas.dataToDisplay["targetArchieve"] ?? "0") ?? 0) * 1000)")
                            .opacity(0)
                            .padding(.trailing)
                            .font(Font.custom(systemFont, size: 15))
                            .foregroundColor(Color.white)
                            .zIndex(2)
                            .frame(width: min(CGFloat((Float(datas.dataToDisplay["targetArchieve"] ?? "0") ?? 0) * 0.033333333333333333333)*geometry.size.width, geometry.size.width), height: geometry.size.height,alignment: .trailing)
                            .cornerRadius(45)
                            .background(Color.init("targetArchieveColor"))
                            .animation(.linear)
                            .cornerRadius(45.0)
                            .zIndex(2)
                        
                        Text("\((Int(datas.dataToDisplay["archieveRate"] ?? "0") ?? 0)*1000)")
                            .opacity(0)
                            .padding(.trailing)
                            .font(Font.custom(systemFont, size: 15))
                            .foregroundColor(Color.white)
                            .zIndex(3)
                            .frame(width: min(CGFloat((Float(datas.dataToDisplay["archieveRate"] ?? "0") ?? 0) * 0.03333333)*geometry.size.width, geometry.size.width), height: geometry.size.height,alignment: .trailing)
                            .cornerRadius(45)
                            .background(Color.init("systemColor"))
                            .animation(.linear)
                            .cornerRadius(45.0)
                            .zIndex(3)
                        
                        Capsule()
                            .frame(width: geometry.size.width , height: geometry.size.height)
                            .opacity(0.3)
                            .foregroundColor(Color("systemColor"))
                            .zIndex(1)
                        
                    }
                    .cornerRadius(45.0)
                   
                }
                .frame(width:345, height: 35)
                .padding(.top,8)
            }
            HStack(spacing : 10){
                Spacer()
                HStack{
                    Circle()
                        .fill(Color.init("systemColor"))
                        .frame(width: 8,height: 8)
                    Text("환급 받은 포인트")
                        .font(Font.custom(systemFont, size: 10))
                }
                HStack{
                    Circle()
                        .fill(Color.init("targetArchieveColor"))
                        .frame(width: 8,height: 8)
                    Text("예상 환급 포인트")
                        .font(Font.custom(systemFont, size: 10))
                }
                
            }
            .padding(.trailing, 20)
            .padding(.top, 10)
            
        }
    }
}

struct MyPointView_Previews: PreviewProvider {
    static var previews: some View {
        MyPointView(showingPopup: .constant(false))
    }
}
