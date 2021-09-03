//
//  GetBodyTextFieldPages.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/03.
//

import SwiftUI

struct GetBodyTextFieldPages: View {
    
    @State var text : String
    @State var filedText : String
    @Binding var variable : String
    @Binding var BtnActivate : Bool
    
    var body: some View {
        VStack(spacing:30){
            Text(text)
                .font(Font.custom(systemFont, size: 20))
                .fontWeight(.bold)
            let TextFieldA = TextField(filedText, text: Binding<String>(
                get: { self.variable },
                set: {
                    self.variable = $0
                    self.callMe(with: $0)
                }))
            let TextFieldB = TextFieldA
                .keyboardType(.decimalPad)
            let TextFieldC = TextFieldB
                .padding(10)
            let TextFieldD = TextFieldC
                .font(Font.custom(systemFont, size: 15))
            let TextFieldE = TextFieldD
                .disableAutocorrection(true)
            let TextFieldF = TextFieldE
                .autocapitalization(.none)
            let TextFieldG = TextFieldF
                .background(RoundedRectangle(cornerRadius: 5).stroke(self.variable != "" ? Color(.secondarySystemBackground): Color.init("userPink")))
            TextFieldG
                .frame(width: 200, height: 20, alignment: .center)
          
            
        }
        .transition(.slide)
    }
    func callMe(with tx: String) {
        if self.variable.isEmpty{
            
            BtnActivate = false
            
        }else{
            
            BtnActivate = true
        }
       
    }
}

