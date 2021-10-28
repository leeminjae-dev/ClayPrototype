//
//  RadioButton.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/16.
//

import SwiftUI

struct RadioButton: View {
    
    @Binding var optionVariable : Bool
    @Binding var selectColor : Color
    @Binding var nonSelectColor : Color
    @State var optionOne : String = "One"
    @State var optionTwo : String = "Two"
    var body: some View {
        HStack(spacing: 50){
            Button(action: {
                
                optionVariable.toggle()

            }, label: {
                
                if optionVariable{
                    
                    Text(optionOne)
                        .bold()
                        .foregroundColor(.black)
                        .frame(width: 100, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.white)
                        .cornerRadius(20)
                        .cornerRadius(18)
                        .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(nonSelectColor, lineWidth: 3))
                    
                }else{
                    
                    Text(optionOne)
                        .bold()
                        .foregroundColor(.black)
                        .frame(width : 100, height : 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.white)
                        .cornerRadius(20)
                        .cornerRadius(18)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(selectColor, lineWidth: 3)
                        )
                    
                }
                
                    })
            Button(action: {
                
                optionVariable.toggle()
                

                
            }, label: {
                
                if !optionVariable{
                    Text(optionTwo)
                        .bold()
                        .foregroundColor(.black)
                        .frame(width: 100, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.white)
                        .cornerRadius(20)
                        .cornerRadius(18)
                        .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(nonSelectColor, lineWidth: 3))
                    
                }else{
                    
                    Text(optionTwo)
                        .bold()
                        .foregroundColor(.black)
                        .frame(width: 100, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.white)
                        .cornerRadius(20)
                        .cornerRadius(18)
                        .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(selectColor, lineWidth: 3))
                    
                }
                
                    })
        }
    }
}

struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButton(optionVariable: .constant(true), selectColor: .constant(Color.black) , nonSelectColor: .constant(Color.white) )
    }
}
