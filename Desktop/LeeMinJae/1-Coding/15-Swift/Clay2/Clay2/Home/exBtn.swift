//
//  TotalCalBtn.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import Foundation
import SwiftUI

struct exBtn: PrimitiveButtonStyle {
    var color: Color

    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration, color: color)
    }
   
    struct MyButton: View {
        @GestureState private var pressed = false

        let configuration: PrimitiveButtonStyle.Configuration
        let color: Color

        var body: some View {
            let longPress = LongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity)
                .updating($pressed) { value, state, _ in state = value }
                .onEnded { _ in
                   self.configuration.trigger()
                 }

            return configuration.label
                .foregroundColor(.white)
                .padding(15)
                .background(RoundedRectangle(cornerRadius: 5).fill(color))
                .compositingGroup()
                .shadow(color: .black, radius: 3)
                .opacity(pressed ? 0.5 : 1.0)
                .scaleEffect(pressed ? 0.8 : 1.0)
                .gesture(longPress)
        }
    }
}





struct exBtn_Previews : PreviewProvider{
    static var previews: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Text("버튼")
        }).buttonStyle(exBtn(color: Color.blue))
    }
}
