//
//  TodayBanner.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import SwiftUI

struct TodayBanner: View {
    var body: some View{
        HStack(spacing: 20){
            VStack{
                TodayBannerText(text: "Today")
                    .padding(.trailing,240)
            
                HStack(spacing:30){
            TodayBannerText(text:"00월 00일")
            TodayMealText(text:"아침")
            TodayMealText(text:"점심")
            TodayMealText(text:"저녁")
            TodayMealText(text:"간식")
            }
            
                
            }
    }
}

struct TodayBanner_Previews : PreviewProvider{
    static var previews: some View{
        TodayBanner()
    }
}

}

struct TodayBannerText : View {
    var text : String
    var body: some View{
        Text(text)
            .fontWeight(.semibold)
            .font(Font.custom("Pretendard", size: 15))
            
            
    }
}

struct TodayMealText : View{
    var text : String
    var body: some View{
        Text(text)
            .fontWeight(.bold)
            .foregroundColor(Color.gray)
            .font(.system(size: 15))
        
    }
}
