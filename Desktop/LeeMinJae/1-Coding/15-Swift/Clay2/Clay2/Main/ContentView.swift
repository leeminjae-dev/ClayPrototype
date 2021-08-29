//
//  ContentView.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import SwiftUI

struct ContentView: View {
    @State var morningCal : Float = 0
    @State var launchCal : Float = 0
    @State var dinnerCal : Float = 0
    @State var myPoint : Int = 0
    @State var remainCal : Float = 0
    
    @State var morningTime : Bool = isMorning()
    var launchTime : Bool = isLaunch()
    ///var dinnerTime : Bool = isDinner()
    var dinnerTime : Bool = true
    /// 시간에 따라 잠금장치가 걸릴지 안걸릴지 판별
    
    
    
    
    /// 시간 포맷으로 텍스트를 받아옴

    
    init(){
        UINavigationBar.appearance().backgroundColor = UIColor(Color.white)
        UINavigationBar.appearance().barTintColor = UIColor(Color.white)
        UINavigationBar.appearance().shadowImage = UIImage()
        ///UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
    var body: some View{
        
        NavigationView{
                //ScrollView{
                    
                    VStack(spacing : 40){
                        
                        HStack(spacing : 60){
                        TodayBanner()
                            VStack(spacing : 10){
                                MyPoint(myPoint: myPoint)
                                MyRemainKcal(myKcal: remainCal)
                            }
                        }
                        VStack(spacing : 15){
                           
                            MealBanner(MealCal: morningCal, MealText: "아침", isLocked: morningTime)
                            MealBanner(MealCal: morningCal, MealText: "점심", isLocked: launchTime)
                            MealBanner(MealCal: morningCal, MealText: "저녁", isLocked: dinnerTime)
                                                        
                           
                        }
                        
                    }
                    .padding(.bottom, 130)
    
               /* }
                
            .padding()
            .navigationBarTitle("홈", displayMode: .inline)
            
            .font(Font.custom("Pretendard", size: 15))*/
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



