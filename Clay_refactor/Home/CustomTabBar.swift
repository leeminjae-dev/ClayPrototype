//
//  CustomeTabBar.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/16.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab : String
    
    
    var body: some View {
       
            
            HStack(spacing : 0){
                
                TabBarButton(image: "house", seletedTab: $selectedTab, title: "홈")
                
                TabBarButton(image: "cart", seletedTab: $selectedTab, title: "클레이샵")
//                TabBarButton(image: "heart", seletedTab: $selectedTab, title: "칼로리 펀딩")
                
                TabBarButton(image: "person.circle", seletedTab: $selectedTab, title: "내 정보")
                
            }
            .frame(width: 390, height: 90, alignment: .top)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 2)
        
    
        
        
    }
}

struct CustomeTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}

struct TabBarButton : View{
    var image : String
    @Binding var seletedTab: String
    var title : String
    var body: some View{
        
        GeometryReader{reader in
            Button(action: {
                withAnimation{
                    seletedTab = image
                }
            }, label: {
                VStack(spacing :10){
                    Image(systemName: "\(image)\(seletedTab == image ? ".fill":"")")
                        .font(Font.custom(systemFont, size: 25))
                        .foregroundColor(seletedTab == image ?  Color.init("systemColor"): Color.gray)
                       
                    Text(title)
                        .font(Font.custom(systemFont, size: 10))
                        .foregroundColor(seletedTab == image ?  Color.init("systemColor"): Color.gray)
                } //.offset(y : seletedTab == image ? -10 : 0)
               
            })
            .frame(maxWidth : .infinity, maxHeight: .infinity)
            .padding()
        }
        .frame(height : 55)
        
    }
    
}
