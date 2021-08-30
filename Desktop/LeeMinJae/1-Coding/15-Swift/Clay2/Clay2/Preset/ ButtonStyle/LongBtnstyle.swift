//
//  LongBtnstyle.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/29.
//

import Foundation
import SwiftUI

struct LongBtnStyle : ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 2: 1)
            
    }
    
}

struct LongBtnStyle_Previews : PreviewProvider{
    static var previews: some View{
        Button(action: {
            print("button")
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        }).buttonStyle(LongBtnStyle())
    }
}
