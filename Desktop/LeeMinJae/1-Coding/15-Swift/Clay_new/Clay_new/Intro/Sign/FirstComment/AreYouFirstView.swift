//
//  AreYouFirstView.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/02.
//

import SwiftUI

struct AreYouFirstView: View {

    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            FirstBtn()
            HStack{
                Text("이미 회원이신가요?")
                    .font(Font.custom(systemFont, size: 13))
                Text("|")
                
                NavigationLink("로그인", destination: MainLogIn())
                    .font(Font.custom(systemFont, size: 15))
                    .foregroundColor(Color.blue)
                   
                    
                
            }
           
        }
        .padding(.bottom,200)
        
      
    }
}

struct AreYouFirstView_Previews: PreviewProvider {
    static var previews: some View {
        AreYouFirstView()
    }
}
