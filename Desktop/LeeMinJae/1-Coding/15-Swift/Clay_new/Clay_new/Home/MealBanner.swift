//
//  MealBanner.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/29.
//

import Foundation
import SwiftUI

struct MealBanner: View {
    @State var MealCal : Float
    @State var MealText : String
    @State var isLocked : Bool
    
    
    var body: some View{
        if(isLocked == true){
            NavigationLink(
                destination: NutritionList(),
                label: {
                    HStack{
                            Text(MealText)
                                .fontWeight(.bold)
                                .font(Font.custom(systemFont, size: 15))
                                .padding(.leading,30)
                        Spacer()
                        
                        HStack{
                            Text("\(MealCal,specifier: "%.1f")")
                                .foregroundColor(Color.black)
                                .fontWeight(.black)
                                .font(Font.custom(systemFont, size: 20))
                            Text("Kcal")
                                .fontWeight(.semibold)
                                .font(Font.custom(systemFont, size: 15))
                                
                            }
                        .padding(.trailing)
                            
                            
                            }
                    
                            .frame(width: 340, height: 80)
                    .background(Color.white)
                            .cornerRadius(15)
                    .shadow(color: .black, radius: 0.8)
                })
                .foregroundColor(Color.black)
        }
            else{
                HStack{
                        Text(MealText)
                            .fontWeight(.bold)
                            .font(Font.custom(systemFont, size: 15))
                            .padding(.leading,30)
                    Spacer()
                    Image(systemName: "lock")
                        .foregroundColor(Color.white)
                        .font(.system(size: 45))
                        .padding(.leading,20)
                Spacer()
                    HStack{
                        Text("\(MealCal,specifier: "%.1f")")
                            .foregroundColor(Color.white)
                            .fontWeight(.black)
                            .font(Font.custom(systemFont, size: 20))
                        Text("Kcal")
                            .fontWeight(.semibold)
                            .font(Font.custom(systemFont, size: 15))
                            
                        }
                    .padding(.trailing)
                        
                        
                        }
                
                        .frame(width: 340, height: 80)
                        .background(Color.gray)
                        .cornerRadius(15)
                .shadow(color: .black, radius: 0.8)
            }
        }
      
               
        }
        




struct MealBanner_Previews : PreviewProvider{
   
    static var previews: some View{
        MealBanner(MealCal: 2000, MealText: "아침", isLocked: true)
    }
}
