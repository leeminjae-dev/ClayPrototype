//
//  CanWriteBanner.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/15.
//

import SwiftUI

struct CantWriteBanner: View {
    @AppStorage("userEmail") var userEmail = ""
    @ObservedObject var datas = firebaseData
    
    @State var MealText : String = ""
    @State var mealKcal : String = ""
    @State var bannerColor : Color = Color.init("systemColor")
    @State var centerImage : String = ""
    
    var body: some View {
        ZStack{
            Image(systemName: centerImage)
                .resizable()
                .foregroundColor(Color.white)
                .frame(width: 20, height: 20)
                .zIndex(1)
            HStack{
                Text(MealText)
                    .foregroundColor(Color.white)
                    .font(Font.custom(systemFont, size: 15))
                    .padding(.leading,30)
                Spacer()
                
                ///Text("\(today,formatter: MealBanner.dateFormat)")
                
           
                Spacer()
                
                HStack{
                    Text("\(datas.kcalToDisplay[mealKcal]!,specifier: "%.0f")")
                        .foregroundColor(Color.white)
                        .fontWeight(.black)
                        .font(Font.custom(systemFont, size: 20))
                    Text("Kcal")
                        .foregroundColor(Color.white)
                        .font(Font.custom(systemFont, size: 15))
                        
                    }
                    .padding(.trailing)
                    
                    
                    }
            
                    .frame(width: 345, height: 70)
                    .background(bannerColor)
                    .cornerRadius(60)
                    
        }
     
        /// 터치 불가능한 배너
    }
}

struct CantWriteBanner_Previews: PreviewProvider {
    static var previews: some View {
        CantWriteBanner()
    }
}
