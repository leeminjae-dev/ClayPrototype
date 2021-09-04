//
//  SelectBtn.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/03.
//

import SwiftUI

struct GenderSelectBtn: View {
    
    @State var selectColor = Color.init("userPink")
    @State var nonSelectColor = Color.init("userPink").opacity(0.3)
    @Binding var istabMale : Bool
    @Binding var istabFemale : Bool 
    
    var body: some View {
        
            HStack(spacing: 50){
                Button(action: {
                    
                    istabMale.toggle()
                    istabFemale.toggle()

                    
                }, label: {
                    
                    if istabMale{
                        Text("남성")
                            .bold()
                            .foregroundColor(.black)
                            .frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(nonSelectColor, lineWidth: 3))
                        
                    }else{
                        
                        Text("남성")
                            .bold()
                            .foregroundColor(.black)
                            .frame(width : 150, height : 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(selectColor, lineWidth: 3))
                        
                    }
                    
                        })
                Button(action: {
                    
                    istabMale.toggle()
                    istabFemale.toggle()

                    
                }, label: {
                    
                    if istabFemale{
                        Text("여성")
                            .bold()
                            .foregroundColor(.black)
                            .frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(nonSelectColor, lineWidth: 3))
                        
                    }else{
                        
                        Text("여성")
                            .bold()
                            .foregroundColor(.black)
                            .frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(selectColor, lineWidth: 3))
                        
                    }
                    
                        })
            }
            
            
        
    }
}

