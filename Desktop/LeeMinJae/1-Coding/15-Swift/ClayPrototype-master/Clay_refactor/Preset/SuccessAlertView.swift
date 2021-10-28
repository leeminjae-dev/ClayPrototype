//
//  ErrorView.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/02.
//

import SwiftUI

struct SuccessAlertView: View {
    
    @State var color = Color.black.opacity(0.7)
    
    @Binding var alert : Bool
    @Binding var errorMassage : String
    
    
    var body: some View {
        if alert{
            VStack{
                
                Image(systemName: "checkmark.circle")
                    .font(Font.custom(systemFont, size: 25))
                    .foregroundColor(.white)
                    .padding(.top)
               
                Text(errorMassage)
                    .font(Font.custom(systemFont, size: 15))
                    .foregroundColor(.white)
                    .padding(.vertical)
                    
             
            }
            
            .frame(width: UIScreen.main.bounds.width - 100)
            .background(Color.black.opacity(0.6))
            .cornerRadius(15)
            .shadow(radius: 0.5)
            .padding(.bottom,50)
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))

        }
        
    }
}

