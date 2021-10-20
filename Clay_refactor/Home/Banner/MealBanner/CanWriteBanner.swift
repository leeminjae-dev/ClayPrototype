//
//  CanWriteBanner.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/15.
//

import SwiftUI

struct CanWriteBanner: View {
    
    @AppStorage("userEmail") var userEmail = ""
    
    @ObservedObject var datas = firebaseData
    
    @State var MealText : String = ""
    @State var mealKcal : String = ""
    @State var bannerColor : Color = Color.init("systemColor")
    @State var centerImage : String = ""
    @State var fontColor : Color = Color.black
    
    @Binding var isTabDiet : Bool
    
    var body: some View {
        Button(
            
            action: { isTabDiet = true},
            label: {
                HStack{
                    Text(MealText)
                        .foregroundColor(fontColor)
                        .font(Font.custom(systemFont, size: 15))
                        .padding(.leading,30)
                    Spacer()
                    
                    ///Text("\(today,formatter: MealBanner.dateFormat)")
                    
                    
                    Spacer()
                    
                    HStack{
                        Text("\(datas.kcalToDisplay[mealKcal] ?? 0,specifier: "%.0f")")
                            .foregroundColor(fontColor)
                            .fontWeight(.black)
                            .font(Font.custom(systemFont, size: 20))
                        Text("Kcal")
                            .foregroundColor(fontColor)
                            .font(Font.custom(systemFont, size: 15))
                            
                        }
                        .padding(.trailing)
                        
                        
                        }
                
                        .frame(width: 345, height: 70)
                        .background(bannerColor)
                        .cornerRadius(60)
                       
            })
            
    }
    
    /// 터치 가능한 배너
}

struct CanWriteBanner_Previews: PreviewProvider {
    static var previews: some View {
        CanWriteBanner(isTabDiet: .constant(false))
    }
}
