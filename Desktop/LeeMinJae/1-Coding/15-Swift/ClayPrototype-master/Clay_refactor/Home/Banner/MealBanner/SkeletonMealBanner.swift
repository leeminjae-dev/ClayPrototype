//
//  CanWriteBanner.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/15.
//

import SwiftUI

struct SkeletonMealBanner: View {
 
    var body: some View {
       
            HStack{
               
                Spacer()
                
                HStack{
                    Text("")
                        
                        .fontWeight(.black)
                        .font(Font.custom(systemFont, size: 20))
                    Text("")
                        
                        .font(Font.custom(systemFont, size: 15))
                        
                    }
                    .padding(.trailing)
                    
                    
                    }
            
                    .frame(width: 345, height: 70)
                    .background(Color.init("shadowWhite"))
                    .cornerRadius(60)
                       
            
            
    }
    
    /// 터치 가능한 배너
}

struct SkeletonMealBanner_Previews: PreviewProvider {
    static var previews: some View {
        SkeletonMealBanner()
    }
}
