//
//  Main.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/31.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
struct Main: View {
    
   
    @AppStorage("currentPage") var currentPage = 1
    @EnvironmentObject var viewModel : AppViewModel
    
    var body: some View {
        
        NavigationView{
            if currentPage > totalPage{
                if viewModel.signedIn{
                    MyTabView()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .transition(.slide)
                }else{
                AreYouFirstView()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .transition(.slide)
                }
            }else{
                WalkThroughScreen()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .transition(.slide)
                    
            }
          
        }
        .accentColor(Color.pink)
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        
        }
    }
    
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
            .previewDevice("iPhone 12 mini")
    }
}


