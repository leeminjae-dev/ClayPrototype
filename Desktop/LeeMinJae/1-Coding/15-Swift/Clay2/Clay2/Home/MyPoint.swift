//
//  MyPoint.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/29.
//

import Foundation
import SwiftUI

struct MyPoint: View {
    @State var myPoint : Int
    var body: some View{
        VStack(spacing : 5){
            PointLableText(text:"포인트")
            HStack{
                PointNumText(text:"\(myPoint)")
                PointLableText(text: "P")
                    .padding(.top,5)
                    
            }
            .padding(.leading)
                
        }
    }
}


struct MyPoint_Previews : PreviewProvider{
    static var previews: some View{
        MyPoint(myPoint: 1000)
    }
}


private struct PointLableText : View {
    var text : String
    var body: some View{
        Text(text)
            .font(Font.custom("Pretendard", size: 15))
            .fontWeight(.black)
        
    }
}/// 포인트 글자 텍스트 함수


private struct PointNumText : View{
    var text : String
    var body: some View{
        Text(text)
            .font(Font.custom("Pretendard", size: 20))
            .fontWeight(.black)
    }
}/// 포인트 숫자 텍스트 함수
