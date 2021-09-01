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
            if viewModel.signedIn{
                if currentPage > totalPage{
                    MyTabView()
                }
                else{
                    WalkThroughScreen()
                }
            }else{
                SignView()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
          
        }
        .navigationBarHidden(true)
        .navigationBarTitle(Text("Home"))
        .edgesIgnoringSafeArea([.top, .bottom])
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


