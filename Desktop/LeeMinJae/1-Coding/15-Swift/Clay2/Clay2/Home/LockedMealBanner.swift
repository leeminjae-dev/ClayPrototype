//
//  MealBanner.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/29.
//

import Foundation
import SwiftUI

struct LockedMealBanner: View {
    @State var MealCal : Float
    var MealText : String
    
    var body: some View{
       
                HStack{
                        Text(MealText)
                            .fontWeight(.bold)
                            .font(Font.custom("Pretendard", size: 15))
                            .padding(.leading,30)
                    Spacer()
                    Image(systemName: "lock")
                        .foregroundColor(Color.white)
                        .font(.system(size: 45))
                        .padding(.leading,40)
                Spacer()
                    HStack{
                        Text("\(MealCal,specifier: "%.1f")")
                            .foregroundColor(Color.blue)
                            .fontWeight(.black)
                            .font(Font.custom("Pretendard", size: 20))
                        Text("Kcal")
                            .fontWeight(.semibold)
                            .font(Font.custom("Pretendard", size: 15))
                            
                        }
                    .padding(.trailing)
                        
                        
                        }
                
                        .frame(width: 340, height: 80)
                        .background(Color.gray)
                        .cornerRadius(15)
                        .shadow(color: .black, radius: 0.7, x: 0.2, y: 0.2)
            }
           
               
        }
        




struct LockedMealBanner_Previews : PreviewProvider{
    static var previews: some View{
        LockedMealBanner(MealCal: 335,MealText: "아침")
    }
}
