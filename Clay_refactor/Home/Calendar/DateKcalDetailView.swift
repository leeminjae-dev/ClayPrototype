//
//  DateKcalDetail.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/20.
//

import SwiftUI

struct DateKcalDetailView: View {
    var body: some View {
        VStack(spacing : 0){
           
            
            TabView{
               
                MealDetail()
                MealDetail()
               
            }
            
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
        }
//        .ignoresSafeArea()
         
       
    }
}

struct DateKcalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DateKcalDetailView()
    }
}
