//
//  TabView.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import Foundation
import SwiftUI


struct MyTabView: View {

    init(){
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().barTintColor = UIColor(Color.white)
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().isOpaque = false
        ///UITabBar.appearance().backgroundImage = UIImage()
        
    }
    
   
    @State private var selection = 0
    
    var body: some View{
        
        TabView(selection : $selection){
            Text("미정")
                .tabItem {
                    Image(systemName: "questionmark")
                    Text("미정")
                }
                Text("cal")
                .tabItem {
                    Image(systemName: "archivebox")
                    Text("리포트")
                }
            ContentView()
                .tabItem{
                    
                    Image(systemName: "house")
                    Text("홈")
            }.tag(0)
                Text("Shop")
                .tabItem {
                    Image(systemName: "cart")
                    Text("클레이 샵")
            }
                LogoutBtn()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("프로필")
            }
            
                
        }
        
        
        
    }
    
}



struct MyTabView_Previews : PreviewProvider{
    static var previews: some View{
        MyTabView()
    }
}
