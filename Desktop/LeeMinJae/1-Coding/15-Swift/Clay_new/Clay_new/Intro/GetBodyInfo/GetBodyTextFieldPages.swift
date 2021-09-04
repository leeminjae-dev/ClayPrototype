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
    @Binding var BtnActivate : Bool
    @Binding var bodyInfoCurrentPage : Int
    @Binding var variable : String
    
    var body: some View {
        if bodyInfoCurrentPage == 8{
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
                if BtnActivate{
                    Text("모든 준비가 완료되었어요!")
                        .font(Font.custom(systemFont, size: 15))
                        .foregroundColor(.blue)
                }
                
            }
            .transition(.moveAndFade)
        }else{
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
                if bodyInfoCurrentPage == 4 || BtnActivate{
                    
                    Text("숫자로만 입력해주세요")
                        .font(Font.custom(systemFont, size: 15))
                        .foregroundColor(.black).opacity(0.5)
                    Text("거의 다왔어요 조금만 힘내세요!")
                        .font(Font.custom(systemFont, size: 15))
                        .foregroundColor(.black).opacity(0.5)
                    
                }else{
                    
                    Text("숫자로만 입력해주세요")
                        .font(Font.custom(systemFont, size: 15))
                        .foregroundColor(.black).opacity(0.5)
                }
                
                
            }
            .transition(.moveAndFade)
        }
        
        
               
      
      
        
    }
    func callMe(with tx: String) {
        if self.variable.isEmpty{
            
            BtnActivate = false
            
        }else{
            
            BtnActivate = true
        }
       
    }
   

}

