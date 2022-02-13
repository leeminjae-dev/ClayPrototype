//
//  CanWriteBanner.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/15.
//

import SwiftUI

struct SkeletonMealBanner: View {
 
    @State var show : Bool = false
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
//                    .background(show ? Color.init("level0"): Color.init("shadowWhite"))
//
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.init("skeletonColor"),  Color.init("shadowWhite")]), startPoint: .leading, endPoint: .trailing)
                        )
                    .opacity( show ?  1 : 0)
                    .animation(.easeInOut.delay(0.5))
                    .cornerRadius(60)
        
                    .onAppear{
                        show = true
                    }
            
            
    }
    
    /// 터치 가능한 배너
}

struct SkeletonMealBanner_Previews: PreviewProvider {
    static var previews: some View {
        SkeletonMealBanner()
    }
}
