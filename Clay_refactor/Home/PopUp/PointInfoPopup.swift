//
//  PointInfoPopUp.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/16.
//

import SwiftUI

struct PointInfoPopup: View {
    
   
    var body: some View {
        VStack(alignment : .leading, spacing : 5){
            HStack(){
                Spacer()
                Image(systemName: "multiply")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.init("systemColor"))
            }
            .padding(.trailing, 23)
            
           
            HStack(spacing : 0){
                Rectangle()
                    .frame(width: 2, height: 17)
                    .foregroundColor(Color.init("systemColor"))
                    .padding(.bottom, 7)
                Text("나의 포인트란?")
                    
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .bottom], 7)
                    
            }
            .font(Font.custom(systemFont, size: 17))
            .padding([.leading, .top,.trailing])
            
            VStack(alignment : .leading, spacing : 5){
                Text("당신의 다이어트 의지를 충전하세요!")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text("매일 식사 내용을 기록한 당신에게 서비스내에서 활용할 수")
                Text("있는 포인트를 돌려드립니다.")
                HStack(spacing : 0){
                    Text("부모님도 못 바꾸는 나의 습관을 ")
                    Text("하루 1000원")
                        .frame(height: 6, alignment: .bottom)
                        .background(Color.init("systemColor").opacity(0.5))
                        .padding(.top,10)
                    Text("으로 바꿀 수")
                }
                Text("있답니다.")
                
            }
            .font(Font.custom(systemFont, size: 13))
                .padding(.leading, 26)
            HStack(spacing : 0){
                Rectangle()
                    .frame(width: 2, height: 17)
                    .foregroundColor(Color.init("systemColor"))
                    .padding(.bottom, 7)
                Text("포인트 전환율이란?")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding([.leading,.bottom], 7)
                    
            }
            .font(Font.custom(systemFont, size: 17))
            .padding([.leading, .top,.trailing])
            
            VStack(alignment : .leading, spacing : 5){
                Text("매일 식사 내용을 기록을 하면 포인트를 환급해드립니다!")
                HStack(spacing : 0){
                    Text("현재까지 ")
                    HStack(spacing : 0){
                        Text("[예상 환급 포인트]")
                            .frame(height: 6, alignment: .bottom)
                            .background(Color.init("systemColor").opacity(0.5))
                            .padding(.top,10)
                        Text("와")
                        Text(" 나의 ")
                        Text("[환급받은 포인트]")
                            .frame(height: 6, alignment: .bottom)
                            .background(Color.init("systemColor").opacity(0.5))
                            .padding(.top,10)
                    }
                   
                   
                }
                Text("를 확인해보세요.")
                    
            }
            .font(Font.custom(systemFont, size: 13))
                .padding(.leading, 26)
        }
        .padding(.bottom, 40)
        .frame(width: 350, height:350)
        .background(Color.white)
        .cornerRadius(30.0)
    }
}

struct PointInfoPopup_Previews: PreviewProvider {
    static var previews: some View {
        PointInfoPopup()
    }
}
