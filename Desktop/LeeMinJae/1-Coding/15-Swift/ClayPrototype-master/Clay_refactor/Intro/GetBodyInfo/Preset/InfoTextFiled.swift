//
//  InfoTextFiled.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/16.
//

import SwiftUI

struct InfoTextFiled: View {
    
    @Binding var data : String
    @Binding var btnActivate : Bool
    @State var text : String = "testText"
    @State var field : String = "testField"
    var body: some View {
        VStack(spacing : 20){
            let binding = Binding<String>(get: {
                data
                   }, set: {
                       data = $0
                    btnActivate = true
                   })
            
            Text(text)
                .font(Font.custom(systemFont, size: 15))
                .fontWeight(.bold)
            
            TextField(field, text:binding)
                .multilineTextAlignment(.center)
                .font(Font.custom(systemFont, size: 15))
                .padding(20)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: 150, height: 40, alignment: .center)
                .background(Color.white)
                .cornerRadius(18)
                .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.init("systemColor"), lineWidth: 3))
                
        }
    }
}

struct InfoTextFiled_Previews: PreviewProvider {
    static var previews: some View {
        InfoTextFiled(data: .constant("ㅇㅇ"), btnActivate: .constant(false))
    }
}
