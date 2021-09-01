

import SwiftUI
struct SignInView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel : AppViewModel
    
    init(){
        UINavigationBar.appearance().backgroundColor = UIColor(Color.white)
        UINavigationBar.appearance().barTintColor = UIColor(Color.white)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
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
                        viewModel.signIn(email: email, password: password)
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(.black)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                    
                    NavigationLink("계정 만들기", destination: SignUpView())
                        .padding()
                    
                }
                .navigationBarTitle(Text("로그인"), displayMode: .inline)
                .edgesIgnoringSafeArea([.top, .bottom])
                Spacer()
                Spacer()
            }
           
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
