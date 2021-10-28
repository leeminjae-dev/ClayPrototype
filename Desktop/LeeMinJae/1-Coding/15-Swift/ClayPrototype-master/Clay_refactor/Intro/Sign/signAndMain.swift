//
//  signAndMain.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/05.
//

import SwiftUI

struct signAndMain: View {
    @EnvironmentObject var viewModel : SignAppViewModel
    
    var body: some View {
        
        NavigationView{
            
            if viewModel.signedIn{
                
                VStack{
                    
                    Text("Main")
                    LogoutBtn()
                    
                }
            }else{
                
                SignUpView()
                
            }
        }
        .onAppear{
            
            viewModel.signedIn = viewModel.isSignedIn
            
        }
        
        
    }
}

struct signAndMain_Previews: PreviewProvider {
    static var previews: some View {
        signAndMain()
    }
}
