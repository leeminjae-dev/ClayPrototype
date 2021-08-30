//
//  TodayBanner.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import SwiftUI

struct TodayBanner: View {
    static let dateFormat : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }()
    
    @State var today = Date()
    var body: some View{
        HStack(spacing: 20){
            VStack(spacing : 0){
                TodayBannerText(text: "Today")
                    
                    
                HStack{
                    Text("\(today,formatter: TodayBanner.dateFormat)")
                        .fontWeight(.bold)
                        .font(Font.custom(systemFont, size: 20))
                        .padding(.leading,5)
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

private struct TodayBannerText : View {
    var text : String
    var body: some View{
        Text(text)
            .fontWeight(.bold)
            .font(Font.custom(systemFont, size: 30))
            
            
    }
}

private struct TodayMealText : View{
    var text : String
    var body: some View{
        Text(text)
            .fontWeight(.bold)
            .foregroundColor(Color.gray)
            .font(.system(size: 15))
        
    }
}
