//
//  TodayBanner.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import SwiftUI

struct TodayBanner: View {
    
    static let dateFormat : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }()
    
    @State var today = Date(timeInterval: 60, since: Date())
    
    var body: some View{
            VStack(spacing : 0){
                HStack{
                
                    Text("\(today,formatter: TodayBanner.dateFormat)")
                        
                        .font(Font.custom(systemFont, size: 17))
                        
                        }
                
            }
            
          
            
                
                
                
            
    
}

struct TodayBanner_Previews : PreviewProvider{
    static var previews: some View{
        TodayBanner()
    }
}

}



