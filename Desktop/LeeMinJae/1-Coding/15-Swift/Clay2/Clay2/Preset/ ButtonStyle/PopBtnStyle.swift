//
//  PopBtnStyle.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import SwiftUI

struct PopBtnStyle : ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 1.02 : 1.0)
    }
    
}

struct PopBtnStyle_Previews : PreviewProvider{
    static var previews: some View{
        Button(action: {
            print("button")
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        }).buttonStyle(PopBtnStyle())
    }
}
