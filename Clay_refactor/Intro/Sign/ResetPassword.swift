//
//  ResetPassword.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/02.
//

import SwiftUI
import Firebase

struct ResetPassword: View {
    @State var email : String = ""
    @State private var color = Color.init("userPink").opacity(0.7)
    
    @State var errorMassage : String = ""
    @State var alert : Bool = false
    @State var alertSuccess : Bool = false
    
    var body: some View {
        ZStack{
            
            VStack{
            TextField("이메일", text : self.$email)
                .padding(10)
                .font(Font.custom(systemFont, size: 15))
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .background(RoundedRectangle(cornerRadius: 5).stroke(self.email != "" ? Color(.secondarySystemBackground): self.color))
                .frame(width: 350, height: 20, alignment: .center)
            
            Button(action: {
                self.reset()
                /*guard !email.isEmpty, !password.isEmpty else{
                    self.verify()
                    return
                    
                }
                viewModel.signIn(email: email, password: password)*/
            }, label: {
                Text("비밀번호 다시 설정하기")
                    .font(Font.custom(systemFont, size: 20))
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
                    .background(Color.init("systemColor"))
                    .cornerRadius(10)
                    .padding()
                    
            })
            .shadow(radius: 0.5)
            
        }
        .padding(.bottom, 200)
            if self.alert{
                WrongResetPasswordErrorView(alert: self.$alert, errorMassage: self.$errorMassage)
                   
            }
            if self.alertSuccess{
                ResetSuccessView(alert: self.$alert, errorMassage: self.$errorMassage)
                   
                
            }
        }
        .navigationBarTitle(Text("비밀번호 재설정"))
    }
    
    func reset(){
        if self.email != ""{
            Auth.auth().sendPasswordReset(withEmail: self.email){ (err) in
                if err != nil {
                    self.errorMassage = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                self.errorMassage = "메일로 비밀번호 재설정 링크를 발송했습니다"
                self.alertSuccess.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.alertSuccess.toggle()
                }
            }
        }
        else{
            self.errorMassage = "빈칸에 이메일 주소를 기입해주세요"
            self.alert.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.alert = false
            }
        }
    }
}

struct ResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassword()
    }
}
