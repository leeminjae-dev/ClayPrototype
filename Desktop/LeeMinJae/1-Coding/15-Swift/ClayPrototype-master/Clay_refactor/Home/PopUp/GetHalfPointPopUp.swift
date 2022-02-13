//
//  GetPointPopup.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/16.
//

import SwiftUI

struct GetHalfPointPopup: View {
    @Binding var counter : Int
    
    var body: some View {
        ZStack{
            
            VStack{
                Image("point")
                    .resizable()
                    .frame(width: 130, height: 130)
                    
                    .padding(.top, 40)
                Text("500 포인트")
                    .fontWeight(.bold)
                    .font(Font.custom(systemFont, size: 20))
                    .padding(.bottom, 20)
                Text("남은 식단 기록도 꼭 완료해주세요!")
                    .padding(.bottom, 10)
               
            }
        }
        .onAppear{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                counter += 1
            }
            
        }
        .padding(.bottom, 50)
        .frame(width: 300, height:300)
        .background(Color.white)
        .cornerRadius(30.0)
    }
}

struct GetHalfPointPopup_Previews: PreviewProvider {
    static var previews: some View {
        GetHalfPointPopup(counter: .constant(0))
    }
}
