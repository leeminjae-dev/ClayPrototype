

import SwiftUI
struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel : AppViewModel
    
    init(){
        UINavigationBar.appearance().backgroundColor = UIColor(Color.white)
        UINavigationBar.appearance().barTintColor = UIColor(Color.white)
        UINavigationBar.appearance().shadowImage = UIImage()
        ///UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    var body: some View {
        
            VStack{
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width : 150, height: 150)
                VStack{
                    TextField("Email Address", text : $email)
                        .font(Font.custom(systemFont, size: 25))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                        .frame(width: 350)
                        
                    SecureField("Password", text : $password)
                        .font(Font.custom(systemFont, size: 25))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                        .frame(width: 350)
                        .padding()
                        
                    Button(action: {
                        
                        guard !email.isEmpty, !password.isEmpty else{
                            return
                            
                        }
                        viewModel.signUp(email: email, password: password)
                        
                    }, label: {
                        Text("회원 가입")
                            .font(Font.custom(systemFont, size: 20))
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                    
                }
                .navigationBarTitle(Text("회원 가입"), displayMode: .inline)
                
                Spacer()
                Spacer()
            }
            
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
