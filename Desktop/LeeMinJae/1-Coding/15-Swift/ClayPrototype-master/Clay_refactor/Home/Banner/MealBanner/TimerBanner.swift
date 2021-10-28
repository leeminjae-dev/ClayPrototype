//
//  TimerBanner.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/15.
//

import SwiftUI

struct TimerBanner: View {
    @AppStorage("userEmail") var userEmail = ""
    
    @State var MealText : String = ""
    
    @Binding var timeRemaining : Int
    @ObservedObject var datas = firebaseData
    @ObservedObject var homeViewModel = HomeViewModel()
    var body: some View {
        HStack{
                Text(MealText)
                .foregroundColor(Color.gray)
                    .fontWeight(.bold)
                    .font(Font.custom(systemFont, size: 15))
                    .padding(.leading,30)
            Spacer()
            
            Image(systemName: "alarm")
                .foregroundColor(Color.init("timeColor"))
            Text("\(homeViewModel.timeString(time: timeRemaining))")
                .fontWeight(.bold)
                .font(Font.custom(systemFont, size: 15))
                .foregroundColor(Color.init("timeColor"))
                .padding(.trailing, 15)
            Spacer()
            HStack{
               
                Text("Kcal")
                    .foregroundColor(Color.gray)
                    .fontWeight(.semibold)
                    .font(Font.custom(systemFont, size: 15))
                    
                }
            .padding(.trailing)
                
                
                }
        
                .frame(width: 345, height: 70)
                .background(Color.init("lockedColor"))
                .cornerRadius(60)
               
    }/// 타이머 배너
      
}

struct TimerBanner_Previews: PreviewProvider {
    static var previews: some View {
        TimerBanner(timeRemaining: .constant(0))
    }
}
