//
//  ErrorView.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/02.
//

import SwiftUI

struct SuccessView: View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alertSuccess : Bool
   
    var body: some View {
        ZStack{
            VStack{
                
                HStack{
                    
                    Text("로그인 성공")
                        .font(Font.custom(systemFont, size: 15))
                        .foregroundColor(.black)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top)
                    Spacer()
                    
                }
                .padding(.horizontal,25)
                
                Text("로그인에 성공했습니다")
                    .foregroundColor(.black)
                    .padding(.vertical)
                
                
            }
            .frame(width: UIScreen.main.bounds.width - 100)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            
            
        
        }
        
        
    }
}

