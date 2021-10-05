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
  
        VStack(spacing : 0){
                ZStack{
                    Image("logo")
                        .resizable()
                        .frame(width: 230, height: 230)
                    VStack{
                        Text("나를 빚는 시간")
                            .font(Font.custom(systemFont, size: 15))
                           
                        Text("CLAY")
                            .font(Font.custom(systemFont, size: 40))
                            .fontWeight(.bold)
                    }
                    .foregroundColor(Color.init("logoColor"))
                    .offset(y : 130)
                    
                    

                }
                .padding(.bottom, 60)
                NavigationLink(
                   destination: GetBodyInfoView(),
                   label: {
                    
                       Text("처음이신가요?")
                           .foregroundColor(.white)
                           .font(Font.custom(systemFont, size: 15))
                           .fontWeight(.semibold)
                           .frame(width: 300, height: 47, alignment: .center)
                           .background(Color.init("systemColor"))
                           .cornerRadius(5)
                           .padding()
                    
                   })
                   .navigationBarTitle("")
                   .navigationBarHidden(true)
                   .shadow(color: Color.black.opacity(0.3), radius: 6, y:3 )
                
                HStack{
                    
                    Text("이미 회원이신가요?")
                        .font(Font.custom(systemFont, size: 13))
                    
                    Text("|")
                        .fontWeight(.light)
                        .padding(.bottom, 4)
                        
                    NavigationLink("로그인", destination: SignInView())
                    
                        .font(Font.custom(systemFont, size: 15))
                        .foregroundColor(Color.blue)

                }
               
            }
            .padding(.bottom,170)
            
        
       
        
      
    }
}

struct AreYouFirstView_Previews: PreviewProvider {
    static var previews: some View {
        AreYouFirstView()
    }
}
