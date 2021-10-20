//
//  ErrorView.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/02.
//

import SwiftUI

struct SignSuccessView: View {
    
    @State var color = Color.black.opacity(0.7)
    @ObservedObject var datas = firebaseData
    @Binding var alert : Bool
    @Binding var errorMassage : String
    @EnvironmentObject var viewModel : SignAppViewModel
    @AppStorage("userEmail") var userEmail = ""
    @Environment(\.presentationMode) var presentation
    var body: some View {
            VStack{
                
                Image(systemName: "exclamationmark.triangle")
                    .font(Font.custom(systemFont, size: 25))
                    .foregroundColor(.black)
                    .padding(.top)
               
                Text(errorMassage)
                    .font(Font.custom(systemFont, size: 15))
                    .foregroundColor(.black)
                    .padding(.vertical)
                Button(action:{
                    alert.toggle()
                    viewModel.signedIn = viewModel.isSignedIn
                    self.presentation.wrappedValue.dismiss()
                    datas.isCanGetPoint(email: userEmail, userPoint: "1")
                }
                   ,
                    label: {
                        Text("확인")
                            .padding()
                            .foregroundColor(Color.white)
                            .font(Font.custom(systemFont, size: 15))
                            
                            .frame(width: 120, height: 30, alignment: .center)
                            .background(Color.init("systemColor"))
                            .cornerRadius(20)
                            
                    })
                    .padding(.bottom)
            }
            .frame(width: UIScreen.main.bounds.width - 100)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 1)
            .padding(.bottom,50)
           

    }
}

