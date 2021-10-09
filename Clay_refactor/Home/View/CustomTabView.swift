//
//  CustomTabView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/16.
//

import SwiftUI

struct CustomTabView: View {
    @State var selectedTab = "house"
    @State var isTabDiet = false
    @State var isTabSnackDiet = false
    var body: some View {
        if isTabDiet{
            
            DiaryView(isTabDiet: $isTabDiet)
                
               
        }
        else if isTabSnackDiet{
            SnackDiaryView(isTabSnackDiet : $isTabSnackDiet)
        }
        else{
            ZStack(alignment: .bottom){
           
                if selectedTab == "house"{
                    
                    HomeView(isTabDiet: $isTabDiet, isTabSnackDiet: $isTabSnackDiet)
                }
//                if selectedTab == "heart"{
//                    DonateView()
//                        
//                }
                if selectedTab == "cart"{
                    CommerceVIew()
                }
                if selectedTab == "person.circle"{
                    VStack{
                       MyPageView()
                            Spacer()
                    }
                   
                    
                }
                    
                
                
                CustomTabBar(selectedTab: $selectedTab)
                    
                   
            } .ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
        }
        
        
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
