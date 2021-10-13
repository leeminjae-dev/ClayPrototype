//
//  DonateView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/02.
//

import SwiftUI

struct DonateView: View {
    var body: some View {
        
            VStack{
                Spacer()
                Image(systemName: "exclamationmark.circle")
                    .resizable()
                    .frame(width: 170, height: 170, alignment: .center)
                    .foregroundColor(Color.init("systemColor"))
                    .padding(.bottom, 25)
                Text("서비스 준비중입니다.")
                    .font(Font.custom(systemFont, size: 25))
                    .foregroundColor(Color.init("darkGreen"))
                    .fontWeight(.bold)
                    .padding(.bottom, 14)
                Text("더 나은 클레이가 되도록 노력하겠습니다.")
                    .font(Font.custom(systemFont, size: 20))
                Spacer()
                Spacer()
                Spacer()
            }
           
       
    }
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}
