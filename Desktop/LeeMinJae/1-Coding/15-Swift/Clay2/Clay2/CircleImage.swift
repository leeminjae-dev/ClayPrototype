//
//  CircleImage.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import SwiftUI

struct CircleImageView : View{
    var body: some View{
        
        ///Image(systemName: "bolt.circle")
           // .font(.system(size: 200))
            //.foregroundColor(Color.red)
        Image("myImage")
            .scaledToFit()
            .foregroundColor(Color.black)
            .frame(width : 300, height: 300)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay(Circle().stroke(Color.red,lineWidth: 2))
            
            .padding()
            .overlay(Circle().stroke(Color.yellow,lineWidth: 3))
            .overlay(Text("개구리 사진"))
        
    }
}

struct CircleImageView_Previews : PreviewProvider{
    static var previews: some View{
        CircleImageView()
    }
}

