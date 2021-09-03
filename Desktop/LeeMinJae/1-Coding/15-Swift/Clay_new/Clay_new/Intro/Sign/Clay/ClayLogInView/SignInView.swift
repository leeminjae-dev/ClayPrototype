

import SwiftUI
import Firebase

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @State var visible = false
    @State private var color = Color.init("userPink").opacity(0.7)
    
    @State var alert = false
    @State var alertSuccess = false
    
    @State var isLoading = false
    @State var isSuccess = false
    @State var animate = false
    
    @EnvironmentObject var viewModel : AppViewModel
    
    var body: some View{
        ZStack{
            VStack{
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width : 150, height: 150)
            TextField("이메일", text : self.$email)
                .padding(10)
                .font(Font.custom(systemFont, size: 15))
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .background(RoundedRectangle(cornerRadius: 5).stroke(self.email != "" ? Color(.secondarySystemBackground): self.color))
                .frame(width: 350, height: 20, alignment: .center)
                
            HStack{
                ZStack{
                    if self.visible{
                        TextField("비밀번호", text : self.$password)
                            .padding(10)
                            .font(Font.custom(systemFont, size: 15))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            
                            
                    }else{
                        SecureField("비밀번호", text : self.$password)
                            .padding(10)
                            .font(Font.custom(systemFont, size: 15))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            
                            
                    }
                    
                }
                Button(action: {
                    
                    self.visible.toggle()
                    
                }, label: {
                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.black)
                })
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 5).stroke(self.email != "" ? Color(.secondarySystemBackground): self.color))
            .frame(width: 350, height: 60, alignment: .center)
                
            ///로그인 버튼
            Button(action: {
               
                
                self.verify()
                        
                
                /*guard !email.isEmpty, !password.isEmpty else{
                    self.verify()
                    return
                    
                }
                viewModel.signIn(email: email, password: password)*/
            }, label: {
                    Text("로그인")
                        .font(Font.custom(systemFont, size: 20))
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                        .background(Color.init("userPink"))
                        .cornerRadius(10)
                        .padding()
               
                
            })
            .shadow(color: .black, radius: 0.8, x: 1 , y: 1)
            
            HStack{
                Spacer()
                NavigationLink("계정 만들기", destination: SignUpView())
                    .foregroundColor(.black)
                Text("|")
                NavigationLink("비밀번호 재설정", destination: ResetPassword())
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            Spacer()
            
        }
            .padding(.top,100)
            .navigationBarTitle(Text("로그인"))
            .edgesIgnoringSafeArea(.all)
            
            if self.alert{
                WrongIDErrorView(alert: self.$alert)
                
            }
            if self.isLoading{
                Loader()
                    .onAppear(perform: {
                        delayText()
                    })
                
                }
        }
        
    }
    func delayText() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.isLoading.toggle()
        }
    }

    func verify(){
        self.isLoading = true
        if self.email != "" && self.password != ""{
           
            Auth.auth().signIn(withEmail: self.email, password: self.password){ (res, err) in
                self.isLoading = false

                if err != nil{
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.alert.toggle()
                    }
 
                }else{
                    self.isSuccess = true
                }
                
                viewModel.signIn(email: email, password: password)
            }
            
            
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.alert.toggle()
            }
        }
        
    }
    
    
   
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}


