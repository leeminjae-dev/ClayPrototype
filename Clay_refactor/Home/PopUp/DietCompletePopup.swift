//
//  DietCompletePopup.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/18.
//

import SwiftUI

struct DietCompletePopup: View {
    var body: some View {
        ZStack{
            
            VStack{
                Image("point")
                    .resizable()
                    .frame(width: 130, height: 130)
                    
                    .padding(.top, 40)
                Text("1000 포인트")
                    .fontWeight(.bold)
                    .font(Font.custom(systemFont, size: 20))
                    .padding(.bottom, 20)
                Text("오늘 하루 식단 기록을 완료하였어요!")
                    .padding(.bottom, 10)
               
            }
        }
        .padding(.bottom, 50)
        .frame(width: 300, height:300)
        .background(Color.white)
        .cornerRadius(30.0)
    }
}

struct DietCompletePopup_Previews: PreviewProvider {
    static var previews: some View {
        DietCompletePopup()
    }
}
