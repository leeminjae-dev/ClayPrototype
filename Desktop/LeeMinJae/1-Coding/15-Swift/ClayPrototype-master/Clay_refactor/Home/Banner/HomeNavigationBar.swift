//
//  NavigationBar.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/15.
//

import SwiftUI

struct HomeNavigationBar: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        GeometryReader{geometry in
            ZStack{
                BlurView(effect: .systemUltraThinMaterialLight)
                    .frame(width: 400, height: 100, alignment: .top)
                    .ignoresSafeArea()
                
                HStack{
                    Text("CLAY")
                        .foregroundColor(Color.init("systemColor"))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(Font.custom(systemFont, size: 25))
                       
                        .padding(.leading, 150)
                        
                    Spacer()
                   
                        HStack(spacing : 15){
                           
                            NavigationLink(
                                destination: CustomDatePicker(currentDate: $viewModel.currentDate, tasks : $viewModel.tasks),
                                label: {
                                    ZStack{
                                        Rectangle()
                                            .frame(width: 40, height: 40)
                                            .opacity(0)
                                            .zIndex(1)
                                        Image(systemName: "calendar")
                                            .resizable()
                                            .frame(width:23, height: 23, alignment: .center)
                                            .foregroundColor(Color.init("systemColor"))
                                    }
                                    
                                }
                            )
                            
                            
                          
                        }.padding(.trailing, 5)
                        

                }
                .padding(20)
                .zIndex(1)
            }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 14)
                .zIndex(1)
                .padding(.top, 5)
        }
      
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationBar()
    }
}
