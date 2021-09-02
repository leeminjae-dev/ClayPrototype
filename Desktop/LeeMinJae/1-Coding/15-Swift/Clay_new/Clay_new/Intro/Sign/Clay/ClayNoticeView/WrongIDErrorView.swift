//
//  ErrorView.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/02.
//

import SwiftUI

struct WrongIDErrorView: View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    
    
    
    var body: some View {
            VStack{
                
                HStack{
                    
                    Text("로그인 실패")
                        .font(Font.custom(systemFont, size: 15))
                        .foregroundColor(.black)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top)
                    Spacer()
                    
                }
                .padding(.horizontal,25)
                
                Text("이메일 또는 비밀번호를 다시 확인하세요")
                    .font(Font.custom(systemFont, size: 15))
                    .foregroundColor(.black)
                    .padding(.vertical)
                
                Button(action: {
                    self.alert = false
                }, label: {
                    Text("확인")
                        
                        .foregroundColor(.black)
                        .frame(width: 150, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.init("userPink"), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10)
                        .padding(.vertical,10)
                        .frame(width: UIScreen.main.bounds.width - 120)

                })
                
            }
            .frame(width: UIScreen.main.bounds.width - 100)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding(.bottom,50)
   
        
    }
}

