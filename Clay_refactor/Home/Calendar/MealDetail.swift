//
//  MealDetail.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/21.
//

import SwiftUI

struct MealDetail: View {
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .frame(width: 400, height: 250, alignment: .center)
                    .padding(.bottom, 250)
                    .foregroundColor(Color.init("logoColor"))
                
                Image("콤부차(4개입)")
                    .resizable()
                    .frame(width: 340, height: 270, alignment: .center)
                    .cornerRadius(20)
                    .aspectRatio(contentMode: .fill)
            }
           
            
        }
        
    }
}

struct MealDetail_Previews: PreviewProvider {
    static var previews: some View {
        MealDetail()
    }
}
