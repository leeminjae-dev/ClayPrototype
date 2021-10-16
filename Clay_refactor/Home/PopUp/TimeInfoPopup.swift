//
//  TimeInfoPopup.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/16.
//

import SwiftUI

struct TimeInfoPopup: View {
    @ObservedObject var datas = firebaseData
    var body: some View {
        VStack{
           
            HStack(spacing: 0){
                Rectangle()
                    .frame(width: 2, height: 17)
                    .foregroundColor(Color.init("systemColor"))
                    .padding(.bottom, 1)
                
                Text("나의 식사 시간")
                    .font(Font.custom(systemFont, size: 17))
                    .fontWeight(.bold)
                    .padding(.leading, 7)
                Spacer()
               
                Image(systemName: "multiply")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.init("systemColor"))
                    
            }
            .padding([.leading, .trailing], 30)
            
            VStack(spacing: 15){
                ZStack{
                   
                    Text("아침 : \(datas.userTimeToDisPlay["userMorningTime"]!):00 - \(String(Int(datas.userTimeToDisPlay["userMorningTime"]!)!+2)):00")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                       
                }
                ZStack{
                
                    Text("점심 : \(datas.userTimeToDisPlay["userLaunchTime"]!):00 - \(String(Int(datas.userTimeToDisPlay["userLaunchTime"]!)!+2)):00")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                        
                }
                ZStack{
                  
                    Text("저녁 : \(datas.userTimeToDisPlay["userDinnerTime"]!):00 - \(String(Int(datas.userTimeToDisPlay["userDinnerTime"]!)!+2)):00")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                       
                }
            }
            .padding(.vertical, 30)
            .padding(.bottom, 5)
           
        
        }
        
        .frame(width: 350, height:250)
        .background(Color.white)
        .cornerRadius(30.0)
    }
}

struct TimeInfoPopup_Previews: PreviewProvider {
    static var previews: some View {
        TimeInfoPopup()
    }
}
