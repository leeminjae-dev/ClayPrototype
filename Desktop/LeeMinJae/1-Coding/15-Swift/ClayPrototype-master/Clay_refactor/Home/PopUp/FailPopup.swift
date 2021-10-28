//
//  FailPopup.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/16.
//

import SwiftUI

struct FailPopup: View {
    var body: some View {
        ZStack{
            
            VStack(spacing : 5){
                Image("failImage")
                    .resizable()
                    .frame(width: 130, height: 130)
                    .padding(.top, 50)
                    
                Text("아쉬워요 🥲 ")
                    .font(Font.custom(systemFont, size: 20))
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                Text("내일은 꾸준하게 기록하고")
                    .font(Font.custom(systemFont, size: 17))
                Text("포인트를 환급받으세요!")
                    .font(Font.custom(systemFont, size: 17))
                    .padding(.bottom, 10)
               
            }
            .padding(.bottom, 40)
            .frame(width: 300, height:300)
            .background(Color.white)
            .cornerRadius(30.0)
        }
    }
}

struct FailPopup_Previews: PreviewProvider {
    static var previews: some View {
        FailPopup()
    }
}
