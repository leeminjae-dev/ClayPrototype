//
//  TabView.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import Foundation
import SwiftUI

struct MyTabView: View {
    var body: some View{
        TabView{
            ContentView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                .foregroundColor(Color.black)
                }
            Text("Shop")
                .tabItem {
                    Image(systemName: "cart")
                    Text("클레이 샵")
                }
                
        }
    }
}



struct MyTabView_Previews : PreviewProvider{
    static var previews: some View{
        MyTabView()
    }
}
