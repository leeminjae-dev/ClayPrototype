//
//  ContentView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/05.
//

import SwiftUI

struct Main: View {
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("userEmail") var userEmail = ""
    @EnvironmentObject var viewModel : SignAppViewModel
    
    @State var bodyInfoTotalPage = 8
    @State var bodyInfoCurrentPage = 1
    
    var body: some View {
        NavigationView{
        
            if currentPage > 3{
                
                    AreYouFirstView()
                
        
            }else{
                
                FirstLaunchView()
                
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
          
        
        }
    }
    
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
