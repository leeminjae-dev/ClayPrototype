//
//  ContentView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/05.
//

import SwiftUI
import FirebaseAuth
import FirebaseAnalytics
import Firebase
struct Main: View {
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("userEmail") var userEmail = ""
    @AppStorage("firstLogin") var firstLogin = "0"

    @EnvironmentObject var viewModel : SignAppViewModel
    
    
    var body: some View {
        NavigationView{
        
            if currentPage > 3{
                
                    
              if viewModel.signedIn{
                    
                        CustomTabView()
        
                }else{
                    
                    AreYouFirstView()
                }
        
            }else{
                
                FirstLaunchView()
                
            }
        }
        .onAppear{
            
            if firstLogin == "0"{
                viewModel.signedIn = false
                firstLogin = "1"
            }else{
                viewModel.signedIn = viewModel.isSignedIn
            }
            
            

          
        
        }
        
    }
    
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}


