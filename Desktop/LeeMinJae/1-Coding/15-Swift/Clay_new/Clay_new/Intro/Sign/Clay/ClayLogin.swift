//
//  ClayLogin.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/31.
//

import SwiftUI
import FirebaseAuth

class AppViewModel : ObservableObject{
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn : Bool{
        return auth.currentUser != nil
    }
    
    func signIn(email : String, password : String){
        auth.signIn(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                /// Success
                self?.signedIn = true
            }
        }
    }
    func signUp(email : String, password : String){
        auth.createUser(withEmail: email, password: password){[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            DispatchQueue.main.async {
                /// success
                self?.signedIn = true
            }
            
        }
    }
    func singOut(){
        try? auth.signOut()
        self.signedIn = false
    }
    
}


struct ClayLogin: View {
    @EnvironmentObject var viewModel : AppViewModel
    init(){
        UINavigationBar.appearance().backgroundColor = UIColor(Color.white)
        UINavigationBar.appearance().barTintColor = UIColor(Color.white)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    var body: some View {
        NavigationView{
            if viewModel.signedIn{
                Main()
                
            }else{
                
                SignInView()
                
            }
          
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
    

}


struct ClayLogin_Previews: PreviewProvider {
    @EnvironmentObject var viewModel : AppViewModel
    static var previews: some View {
        ClayLogin()
    }
}
