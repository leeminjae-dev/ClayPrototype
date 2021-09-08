//
//  ErrorView.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/02.
//

import SwiftUI

struct SignSuccessView: View {
    
    @State var color = Color.black.opacity(0.7)
    
    @Binding var alert : Bool
    @Binding var errorMassage : String
    
    
    var body: some View {
            VStack{
                
                Image(systemName: "exclamationmark.triangle")
                    .font(Font.custom(systemFont, size: 25))
                    .foregroundColor(.white)
                    .padding(.top)
               
                Text(errorMassage)
                    .font(Font.custom(systemFont, size: 15))
                    .foregroundColor(.white)
                    .padding(.vertical)
                NavigationLink(
                    destination: SignInView(),
                    label: {
                        Text("로그인 하러 가기")
                            .foregroundColor(.black)
                            .font(Font.custom(systemFont, size: 15))
                            
                            .frame(width: 120, height: 50, alignment: .center)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            
                    })
                    .padding(.bottom)
            }
            .frame(width: UIScreen.main.bounds.width - 100)
            .background(Color.black.opacity(0.6))
            .cornerRadius(15)
            .shadow(radius: 0.5)
            .padding(.bottom,50)
       

    }
}

