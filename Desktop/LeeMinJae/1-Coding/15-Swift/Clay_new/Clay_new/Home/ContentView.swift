//
//  ContentView.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData : User
    
    @State private var morningCal : Float = 0
    @State private var launchCal : Float = 0
    @State private var dinnerCal : Float = 0
    @State private var myPoint : Int = 0
    @State private var remainCal : Float = 0
    
    @State private var morningTime : Bool = isMorning()
    @State private var launchTime : Bool = isLaunch()
    ///var dinnerTime : Bool = isDinner()
    @State private var dinnerTime : Bool = true
    /// 시간에 따라 잠금장치가 걸릴지 안걸릴지 판별

   
    
    
    init(){
        UINavigationBar.appearance().backgroundColor = UIColor(Color.white)
        UINavigationBar.appearance().barTintColor = UIColor(Color.white)
        UINavigationBar.appearance().shadowImage = UIImage()
        ///UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        ///UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        ///Use this if NavigationBarTitle is with displayMode = .inline
        ///UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    var body: some View{
        
        NavigationView{
                ScrollView{
                    VStack(spacing : 13){
                        HStack{
                            VStack(spacing:0){
                                Text("오늘의 목표")
                                    .font(Font.custom(systemFont, size: 20))
                                    .fontWeight(.bold)
                                    .overlay(Rectangle().frame(height: 4).offset(y: 4), alignment: .bottom)
                                    
                                
                            }
                            Spacer()
                        }
                        HStack(spacing : 60){
                            TodayBanner()
                            VStack(spacing : 10){
                                MyPoint(myPoint: Int(userData.userPoint)!)
                                MyRemainKcal(myKcal: userData.totalKcal!)
                            }
                        }
                        .frame(width: 370, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.white)
                        .cornerRadius(10)
                        VStack(spacing : 15){
                            HStack{
                                Text("식단 기록")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Image(systemName: "chevron.right")
                                    
                                Spacer()
                            }
                           
                            MealBanner(MealCal: morningCal, MealText: "아침", isLocked: morningTime)
                            MealBanner(MealCal: morningCal, MealText: "점심", isLocked: launchTime)
                            MealBanner(MealCal: morningCal, MealText: "저녁", isLocked: dinnerTime)
                                                        
                           
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        
                    }
                    .padding(.bottom, 200)
                    .padding(40)
                    
               }
                
                .background(Color.secondary.opacity(0.2))
                .navigationBarTitle("Clay",displayMode: .inline)
                
                
            
            
            .font(Font.custom("Pretendard", size: 15))
            .navigationBarItems(leading:
                                    Button(action:{
                                        ///isLogined = false
                                        ///currentPage = 1
                                        
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
        
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
        
    }
    
}

private func isMorning() -> Bool{

               let date = Date()
               let calender = Calendar.current
               let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    
               let hour = components.hour
    
               let today_string = String(hour!)
               
    if (today_string == "8" || today_string == "9"){
        return true
           }
    else{
        return false
    }

}

private func isLaunch() -> Bool{

               let date = Date()
               let calender = Calendar.current
               let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    
               let hour = components.hour
    
               let today_string = String(hour!)
               
    if (today_string == "12" || today_string == "13"){
        return true
           }
    else{
        return false
    }

}

private func isDinner() -> Bool{

               let date = Date()
               let calender = Calendar.current
               let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    
               let hour = components.hour
    
               let today_string = String(hour!)
               
    if (today_string == "17" || today_string == "18"){
        return true
           }
    else{
        return false
    }

}
/// 세가지 함수가 각각 시간을 판별함

struct ContentView_Previews : PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}


