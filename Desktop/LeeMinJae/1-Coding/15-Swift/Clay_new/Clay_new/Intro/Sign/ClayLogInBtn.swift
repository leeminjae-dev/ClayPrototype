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
            Text("클레이계정으로 로그인")
                .foregroundColor(.black)
                .font(Font.custom(systemFont, size: 15))
                .frame(width: 185, height: 45, alignment: .center)
                .background(Color.init("userPink"))
                .cornerRadius(5)
        })
        
    }
}

struct ClayLogInBtn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
