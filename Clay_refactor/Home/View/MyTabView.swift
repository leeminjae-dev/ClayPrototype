////
////  TabView.swift
////  Clay2
////
////  Created by 이민재 on 2021/08/28.
////
//
//import Foundation
//import SwiftUI
//
//
//struct MyTabView: View {
//
//    init(){
//        UITabBar.appearance().isTranslucent = true
//        UITabBar.appearance().barTintColor = UIColor(Color.white)
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().isOpaque = false
//        ///UITabBar.appearance().backgroundImage = UIImage()
//       
//    }
//    
//   
//    @State private var selection = 0
//    @State var isTabDiet : Bool = false
//    @State var isSnackTabDiet : Bool = false
//    @State var userImageURL : String = ""
//    var body: some View{
//        if isTabDiet{
//            
//            DiaryView(isTabDiet: $isTabDiet)
//            
//        }else{
//            TabView(selection : $selection){
//                Friend()
//                    .tabItem {
//                        Image(systemName: "questionmark")
//                        Text("친구")
//                    }
//                Text("리포트")
//                    .tabItem {
//                        Image(systemName: "archivebox")
//                        Text("리포트")
//                    }
//                HomeView(isTabDiet: $isTabDiet, isTabSnackDiet: $isSnackTabDiet, userImageURL: $userImageURL)
//                    .tabItem{
//                        
//                        Image(systemName: "house")
//                        Text("홈")
//                }.tag(0)
//                    Text("Shop")
//                    .tabItem {
//                        Image(systemName: "cart")
//                        Text("클레이 샵")
//                }
//                    LogoutBtn()
//                    .tabItem {
//                        Image(systemName: "person.circle")
//                        Text("프로필")
//                }
//                
//                    
//            }
//            .accentColor(Color.init("systemColor"))
//            
//        }
//      
//        
//        
//    }
//}
//
//
//
//struct MyTabView_Previews : PreviewProvider{
//    static var previews: some View{
//        MyTabView()
//    }
//}
