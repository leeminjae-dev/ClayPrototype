//
//  ClayLogInBtn.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/01.
//

import SwiftUI

struct ClayLogInBtn: View {
    var body: some View {
     NavigationLink(
        destination: SignInView(),
        label: {
            Text("클레이로 시작하기")
                .foregroundColor(.black)
                .font(Font.custom(systemFont, size: 15))
                .fontWeight(.semibold)
                .frame(width: 300, height: 50, alignment: .center)
                .background(Color.init("userPink"))
                .cornerRadius(5)
        })
        .shadow(color: .black, radius: 0.8)
        .navigationBarTitle("로그인").font(.headline)
        
        
    }
}

struct ClayLogInBtn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
