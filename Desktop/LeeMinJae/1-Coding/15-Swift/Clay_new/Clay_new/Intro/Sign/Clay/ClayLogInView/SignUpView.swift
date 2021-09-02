

import SwiftUI
import Firebase

struct SignUpView: View {
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width : 150, height: 150)
            ClaySignUpView()
            Spacer()
            
        }
        

}
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        
        ClaySignUpView()
    }
}

struct ClaySignUpView : View{
    
    @State var email = ""
    @State var password = ""
    @State var passwordCorrect = ""
    @State var visible = false
    @State private var color = Color.init("userPink").opacity(0.7)
    
    @State var alert = false
    @State var errorMassage = ""
    @State var alertSuccess = false
    
    @EnvironmentObject var viewModel : AppViewModel
    
    var body: some View{
        ZStack{
        VStack(spacing: 20){
            
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
            
            HStack{
                
                ZStack{
                    if self.visible{
                        TextField("비밀번호 확인", text : self.$passwordCorrect)
                            .padding(10)
                            .font(Font.custom(systemFont, size: 15))
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            
                            
                    }else{
                        SecureField("비밀번호 확인", text : self.$passwordCorrect)
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
            .frame(width: 350, height: 10, alignment: .center)
            
            Button(action: {
                register()
                /*guard !email.isEmpty, !password.isEmpty else{
                    return
                    
                }
                viewModel.signIn(email: email, password: password)*/
            }, label: {
                Text("가입하기")
                    .font(Font.custom(systemFont, size: 20))
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
                    .background(Color.init("userPink"))
                    .cornerRadius(10)
                    .padding()
                    
            })
            .shadow(color: .black, radius: 0.8, x: 1 , y: 1)
            
        }
        .navigationBarTitle(Text("회원가입"))
        .edgesIgnoringSafeArea([.top, .bottom])
        
            if self.alert{
                WrongRegisterErrorView(alert: self.$alert, errorMassage: self.$errorMassage)
            }
        }
        .padding(.bottom, 50)
        
    }
    
    func register(){
        if self.email != ""{
            if self.password == self.passwordCorrect{
                Auth.auth().createUser(withEmail: self.email, password: self.password) {
                    (res, err) in
                    
                    if err != nil{
                        self.errorMassage = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    UserDefaults.standard.setValue(true, forKey: "status")
                    NotificationCenter.default.post(name:NSNotification.Name("status"),object: nil)
                }
                
            }else{
                self.errorMassage = "입력하신 비밀번호가 일치하지 않습니다"
                self.alert.toggle()
            }
        }
        else{
            self.errorMassage = "모든 칸을 입력해주세요"
            self.alert.toggle()
        }
    }
}
