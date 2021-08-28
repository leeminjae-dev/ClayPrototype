//
//  reamainNutrition.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//


import SwiftUI

struct RemainNutrition: View {
    var protein : Double
    var body: some View{
    
        VStack(spacing : 10){
        HStack{
            Text("오늘 섭취할 단백질이 ")
                .fontWeight(.bold)
                .font(Font.custom("Pretendard", size: 15)) +
            Text("\(protein,specifier: "%.1f")g")
                .fontWeight(.black)
                .font(Font.custom("Pretendard", size: 20)) +
            Text(" 남았어요!")
                .fontWeight(.bold)
                .font(Font.custom("Pretendard", size: 15))
        }
            HStack(spacing : 0){
                Text("총합 111g ")
                    .font(Font.custom("Pretendard", size: 13))
                    .foregroundColor(Color.gray)
                Text(">")
                    .font(Font.custom("Pretendard", size: 13))
                    .fontWeight(.black)
            }
            .padding(.trailing, 100.0)
            
        }
        .padding(.trailing, 23.0)
        .frame(width: 340, height: 80)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 0.7, x: 0.2, y: 0.2)
        
        
    
        }
    }




struct RemainNutrition_Previews : PreviewProvider{
    static var previews: some View{
        RemainNutrition(protein : 98.3)
    }
}
