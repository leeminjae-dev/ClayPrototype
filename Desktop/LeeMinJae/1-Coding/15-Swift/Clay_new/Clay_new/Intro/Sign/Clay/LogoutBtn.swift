//
//  LogoutBtn.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/01.
//

import SwiftUI

struct LogoutBtn: View {
    @EnvironmentObject var viewModel : AppViewModel
    
    var body: some View {
        
        Button(action: {
            viewModel.singOut()
        }, label: {
            Text("로그아웃")
                .font(Font.custom(systemFont, size: 20))
                .foregroundColor(.black)
                .frame(width: 100, height: 50, alignment: .center)
                .background(Color.init("userPink"))
                .cornerRadius(5)
        })
        .transition(.slide)
        .shadow(radius: 0.5)
    }
}

struct LogoutBtn_Previews: PreviewProvider {
    static var previews: some View {
        LogoutBtn()
    }
}


