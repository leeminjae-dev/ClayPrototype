//
//  LogInBtn.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/30.
//

import Foundation
import SwiftUI

struct LogInBtn: View {
    
    var body: some View{
        
        VStack{
            Image("kakaoLogInBtn")
            Image("NaverLogInBtn")
                .resizable()
                .frame(width: 180, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text("기존 계정 로그인")
                .frame(width: 180, height: 45, alignment: .center)
                .background(Color.init("userPink"))
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .font(Font.custom(systemFont, size: 15))
            HStack(spacing:25){
                Text("회원가입")
                    .font(Font.custom(systemFont, size: 13))
                Text("|")
                    .font(Font.custom(systemFont, size: 13))
                Text("문의하기")
                    .font(Font.custom(systemFont, size: 13))
            }
            .padding(.top,3)
            
        }
        
            
    }
       
}




struct LogInBtn_Previews : PreviewProvider{
    static var previews: some View{
        LogInBtn()
    }
}

