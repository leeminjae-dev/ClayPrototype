//
//  DietAddSuccess.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/18.
//

import SwiftUI

struct DietAddSuccessAlert: View {
    
    @Binding var isAdd : Bool
    @State var foodName : String = "foodName"
    @State var foodKcal : Float = 0
    
    var body: some View {
        
            ZStack{
                
                VStack(spacing : 5){
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color.init("darkGreen"))
                        .padding(.top, 50)
                        .padding(.bottom, 20)
                        
                    Text("\(foodName)")
                        .font(Font.custom(systemFont, size: 20))
                        .foregroundColor(Color.init("darkGreen"))
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    
                    Text("입력되었습니다.")
                        .font(Font.custom(systemFont, size: 20))
                        .padding(.bottom, 20)
                    Text("칼로리                       \(foodKcal, specifier: "%.0f")kcal")
                        .font(Font.custom(systemFont, size: 17))
                        .padding(.bottom, 10)
                   
                }
              
                .padding(.bottom, 40)
                .frame(width: 300, height:300)
                .background(Color.white)
                .cornerRadius(30.0)
                .overlay(
                        RoundedRectangle(cornerRadius:30)
                            .stroke(Color.init("darkGreen"), lineWidth: 2)
                    )
  
            }
          
            
        
           
        
    }
}

struct DietAddSuccessAlert_Previews: PreviewProvider {
    static var previews: some View {
        DietAddSuccessAlert(isAdd: .constant(false))
    }
}
