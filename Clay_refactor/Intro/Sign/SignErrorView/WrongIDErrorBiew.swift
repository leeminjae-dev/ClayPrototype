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
            
            Image(systemName: "exclamationmark.triangle")
                .font(Font.custom(systemFont, size: 25))
                .foregroundColor(.white)
                .padding(.top)
           
            Text("이메일 또는 비밀번호를 확인해주세요")
                .font(Font.custom(systemFont, size: 15))
                .foregroundColor(.white)
                .padding(.vertical)
         
        }
        .frame(width: UIScreen.main.bounds.width - 100)
        .background(Color.black.opacity(0.6))
        .cornerRadius(15)
        .shadow(radius: 0.5)
        .padding(.bottom,50)

    }
}

