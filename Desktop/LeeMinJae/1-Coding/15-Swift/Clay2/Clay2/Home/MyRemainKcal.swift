//
//  MyPoint.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/29.
//

import Foundation
import SwiftUI

struct MyRemainKcal: View {
    @State var myKcal: Float
    var body: some View{
        VStack(spacing : 5){
            KcalLableText(text:"잔여 칼로리")
            HStack{
                if(myKcal > 0){
                    KcalNumText(text:"\(myKcal)")
                    KcalLableText(text: "Kcal")
                }
                else{
                    HStack{
                        KcalNumText(text: "0")
                        KcalLableText(text: "Kcal")
                        
                    }

                    
                    
                }
                    
                    
            }
           
                
        }
    }
}


struct MyRemainKcal_Previews : PreviewProvider{
    static var previews: some View{
        MyRemainKcal(myKcal: 0)
    }
}


private struct KcalLableText : View {
    var text : String
    var body: some View{
        Text(text)
            .font(Font.custom("Pretendard", size: 15))
            .fontWeight(.black)
        
    }
}/// 칼로리 글자 텍스트 함수


private struct KcalNumText : View{
    var text : String
    var body: some View{
        Text(text)
            .foregroundColor(Color.blue)
            .font(Font.custom("Pretendard", size: 20))
            .fontWeight(.black)
            
    }
}/// 칼로리 숫자 텍스트 함수

