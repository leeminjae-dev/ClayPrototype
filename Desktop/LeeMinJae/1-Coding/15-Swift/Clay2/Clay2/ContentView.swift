//
//  ContentView.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View{
        NavigationView{
            VStack(spacing : 0){
                TodayBanner()
                ScrollView{
                    VStack(spacing : 20){
                        HelloBanner()
                        RemainNutrition(protein: 98.2)
                    }
                    .padding(20)
                }
                
            }
            .padding()
            .navigationBarTitle("홈", displayMode: .inline)
            .font(.none)
            .navigationBarItems(leading:
                                    Button(action:{
                                        
                                    }){
                                        Image(systemName: "line.horizontal.3")
                                            .foregroundColor(Color.black)
                                    }
            , trailing: NavigationLink(
                destination: Text("알림창"),
                label: {
                    Image(systemName: "bell")
                        .foregroundColor(Color.black)
                }
            )
            )

        }
        
        
    }
}
    

struct ContentView_Previews : PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}

