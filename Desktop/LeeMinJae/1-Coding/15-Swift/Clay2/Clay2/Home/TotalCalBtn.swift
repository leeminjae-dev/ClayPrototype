//
//  TotalCalBtn.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import Foundation
import SwiftUI

struct TotalCalBtn: View {
    @State var Cal : Float
    var body: some View{
        Button(action: {print("d")}, label: {
            VStack{
                VStack(spacing : 0){
                    Text("오늘 총 칼로리")
                        .font(Font.custom("Pretendard", size: 15))
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                    HStack{
                        Text("\(Cal,specifier: "%.1f")")
                            .font(Font.custom("Pretendard", size: 20))
                            .fontWeight(.black)
                            .foregroundColor(Color.blue)
                        Text("Kcal")
                            .fontWeight(.semibold)
                    }
                    .padding(.leading,12)
       
                    }
                .padding(.trailing, 210)
                HStack(spacing : 180){
                    Text("오늘의 칼로리 확인하기")
                        .font(Font.custom("Pretendard", size: 10))
                        .foregroundColor(.gray)
                       
                    Image(systemName: "chevron.down")
            }
                .padding(.top,1)
            
              
                
            }

            .frame(width: 340, height: 120, alignment: .center)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: .black, radius: 0.7, x: 0.2, y: 0.2)
            
                
        }).buttonStyle(PopBtnStyle())
}

struct TotalCalBtn_Previews : PreviewProvider{
    static var previews: some View{
        TotalCalBtn(Cal : 335)
    }
}
}
