//
//  reamainNutrition.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//


import SwiftUI

struct RemainNutrition: View {
    @State var protein : Float
    var body: some View{
        
        Button(action: {print("d")}, label: {
            VStack(spacing : 10){
                HStack{
                    Text("오늘 섭취할 단백질이 ")
                        .fontWeight(.bold)
                        .font(Font.custom(systemFont, size: 15)) +
                    Text("\(protein,specifier: "%.1f")g")
                        .fontWeight(.black)
                        .foregroundColor(Color.blue)
                        .font(Font.custom(systemFont, size: 20)) +
                    Text(" 남았어요!")
                        .fontWeight(.bold)
                        .font(Font.custom(systemFont, size: 15))
                    }


                HStack(spacing : 0){
                    Text("총합 111g ")
                        .font(Font.custom(systemFont, size: 13))
                        .foregroundColor(Color.gray)
                    Text(">")
                        .font(Font.custom(systemFont, size: 13))
                        .fontWeight(.black)
                }
                .padding(.trailing, 100.0)
                
            }
            .padding(.trailing, 70.0)
            .frame(width: 340, height: 80)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: .black, radius: 0.7, x: 0.2, y: 0.2)
            
                
        }).buttonStyle(PopBtnStyle())
       
        
    
        }
    }




struct RemainNutrition_Previews : PreviewProvider{
    static var previews: some View{
        RemainNutrition(protein : 98.3)
    }
}
