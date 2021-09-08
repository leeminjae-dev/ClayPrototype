//
//  AreYouFirstView.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/02.
//

import SwiftUI

struct AreYouFirstView: View {
    @EnvironmentObject var viewModel : SignAppViewModel
    var body: some View {
        
        ZStack{
            if viewModel.signedIn{
                VStack{
                    HomeView()
                }
               
            }else{
                VStack{
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    NavigationLink(
                       destination: GetBodyInfoView(),
                       label: {
                        
                           Text("처음이신가요?")
                               .foregroundColor(.black)
                               .font(Font.custom(systemFont, size: 15))
                               .fontWeight(.semibold)
                               .frame(width: 300, height: 47, alignment: .center)
                               .background(Color.init("systemColor"))
                               .cornerRadius(5)
                               .padding()
                        
                       })
                       .navigationBarTitle("")
                       .navigationBarHidden(true)
                       .shadow(color: .black, radius: 0.8)
                    
                    HStack{
                        
                        Text("이미 회원이신가요?")
                            .font(Font.custom(systemFont, size: 13))
                        
                        Text("|")
                        
                        NavigationLink("로그인", destination: SignInView())
                            .font(Font.custom(systemFont, size: 15))
                            .foregroundColor(Color.blue)

                    }
                   
                }
                .padding(.bottom,200)
            }
        }
       
        
      
    }
}

struct AreYouFirstView_Previews: PreviewProvider {
    static var previews: some View {
        AreYouFirstView()
    }
}
