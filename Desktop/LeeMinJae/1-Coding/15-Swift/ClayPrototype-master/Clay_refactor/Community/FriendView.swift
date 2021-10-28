//
//  FriendView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/10.
//

import SwiftUI

struct FriendView: View {
    var data : ThreadDataType
    
    var body: some View {
        VStack{
            
            Text(data.nickName!)
            
            HStack(spacing : 20){
                
                Text(data.userPoint!)
                Text(data.archieveRate!)
                
                
            }
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        
       
        
    }
}





