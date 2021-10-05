//
//  ErrorView.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/02.
//

import SwiftUI

struct FoodSelectSuccessView: View {
    
    @State var color = Color.black.opacity(0.7)
        
    var body: some View {
            VStack{
                
                Image(systemName: "checkmark.circle")
                    .font(Font.custom(systemFont, size: 25))
                    .foregroundColor(.white)
                    .padding(.top)
               
                Text("식단이 추가되었습니다.")
                    .font(Font.custom(systemFont, size: 15))
                    .foregroundColor(.white)
                    .padding(.vertical)
             
            }
            .frame(width: UIScreen.main.bounds.width - 100)
            .background(Color.black.opacity(0.6))
            .cornerRadius(15)
            .shadow(radius: 0.5)
            .padding(.bottom,50)

    }
}

