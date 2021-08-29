//
//  NutritionList.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/29.
//

import Foundation
import SwiftUI

struct NutritionList: View {
    var body: some View{
        
        List{
            Section(header: Text("Food List")){
                ForEach(1...30, id: \.self){
                    Text("Food \($0)")
                }
            }
            
            
            
        }
        
    }
}



struct NutritionList_Previews : PreviewProvider{
    static var previews: some View{
        NutritionList()
    }
}

