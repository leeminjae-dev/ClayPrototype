//
//  HelloBanner.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import SwiftUI

struct HelloBanner: View {
    var body: some View{
        VStack{
            Text("안녕하세요 민재님,")
                .font(Font.custom("Pretendard", size: 15))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.trailing,195)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            
            Text("오늘도 목표를 위해 함께 달려요!")
                .font(.custom("Pretendard", size: 15))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.trailing,120)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                
            
        }
            .frame(width: 340, height: 80)
            .background(Color("userPink"))
            .cornerRadius(15)
            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 0.7, x: 0.2, y: 0.2)
        
    }
    
    

struct HelloBanner_Previews : PreviewProvider{
    static var previews: some View{
        HelloBanner()
    }
}
}
