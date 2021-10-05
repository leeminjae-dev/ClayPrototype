//
//  ProductView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/03.
//

import SwiftUI

struct ProductView: View {
   
    @State var productImage : String = ""
    @State var productName : String = ""
    @State var productPrice : Int = 0
    
    @Binding var show : Bool
    @State var delay : Double = 1
    
   
    
    @Binding var showBuy : Bool
    @Binding var buyProductName : String
    @Binding var buyProductPrice : Int
  

    
    var body: some View {
        VStack(spacing : 1){
            ZStack{
                Image(productImage)
                    .resizable()
                    .frame(width: 170, height: 170)
                    .cornerRadius(15)
                    .padding(.bottom, 10)
                Button(action: {
                    
                    showBuy = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        buyProductName = productName
                        buyProductPrice = productPrice
                    }
                   
                }, label: {
                    ZStack{
                        Image(systemName: "cart")
                            .frame(width: 35, height: 35)
                            .zIndex(1)
                        Circle()
                            .frame(width: 35, height: 35)
                            .foregroundColor(Color.white)
                }})
                    .zIndex(1)
                    .offset(x: 57, y: 50)
            }
            Text(productName)
                .font(Font.custom(systemFont, size: 15))
                .frame(width: 165, height: 15, alignment: .leading)
                
            HStack(spacing : 0){
                Text("\(productPrice)")
                    .fontWeight(.bold)
                    .font(Font.custom(systemFont, size: 17))
                Text(" 원")
                    .font(Font.custom(systemFont, size: 15))
              
            }
            .frame(width: 165, height: 35, alignment: .leading)
                        
        }
        .onAppear{
            
        }
        .opacity(show ? 1 : 0)
        .offset(y: self.show ? 0 : 20)
        .animation(.easeOut.delay(delay))
       
    }
    
   
}

