//
//  ClaySignUpBtn.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/02.
//

import SwiftUI

struct ClaySignUpBtn: View {
    var body: some View {
        NavigationLink(
           destination: SignUpView(),
           label: {
            Text("클레이로 회원가입하기")
                .foregroundColor(.black)
                .font(Font.custom(systemFont, size: 15))
                .fontWeight(.semibold)
                .frame(width: 300, height: 50, alignment: .center)
                .background(Color.init("userPink"))
                .cornerRadius(5)
           
           })
            .shadow(color: .black, radius: 0.8)
            .navigationBarTitle("회원가입").font(.headline)
    }
}

struct ClaySignUpBtn_Previews: PreviewProvider {
    static var previews: some View {
        ClaySignUpBtn()
    }
}
