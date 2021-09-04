

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
   
    @EnvironmentObject var userData : User
    @EnvironmentObject var viewModel : AppViewModel
    
    @State var email = ""
    @State var password = ""
    @State var passwordCorrect = ""
    @State var visible = false
    @State private var color = Color.init("userPink").opacity(0.7)
    
    @State var alert = false
    @State var errorMassage = ""
    @State var alertSuccess = false
    @State var localizationMassage = ""
    @State var isLoading = false
    
    
    
    var body: some View{
        ZStack{
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
                //가입하기
                Button(action: {
                    
                    self.register()
                    
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
            .navigationBarTitle(Text("계정 만들기"))
            .edgesIgnoringSafeArea([.top, .bottom])
                ZStack{
                if self.alert{
                    
                    WrongRegisterErrorView(alert: self.$alert, errorMassage: self.$errorMassage)

                }
                if self.isLoading{
                    Loader()
                        .onAppear(perform: {
                            delayText()
                        })
                    
                    }
                }
            }
            .padding(.bottom, 50)
        
        }
    }
    
    func pushData() {
        
        userData.totalKcal = cal(weight: Double(userData.kgWeight)!, height: Double(userData.cmHeight)!, age: Double(userData.age)!, gender: userData.isTabMale, selectAtivate: userData.selectActive)
        firebaseData.createData(email: self.email, age: userData.age, cmHeight: userData.cmHeight, kgWeight: userData.kgWeight, targetWeight: userData.targetWeight, isTabMale: userData.isTabMale ? "Female" : "Male", nickName: userData.nickName, totalKcal: userData.totalKcal!, userPoint: userData.userPoint)
    }
    
    func delayText() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.isLoading.toggle()
        }
    }
    
    
    func register(){
        
        self.isLoading = true
        if self.email != ""{
            if self.password == self.passwordCorrect{
                Auth.auth().createUser(withEmail: self.email, password: self.password) {
                    (res, err) in
                    
                    if err != nil{
                        localizationMassage = err!.localizedDescription
                        if localizationMassage == "The email address is badly formatted."{
                            self.errorMassage = "올바른 이메일 형식이 아닙니다."
                        }
                        
                        if localizationMassage == "The password must be 6 characters long or more."{
                            self.errorMassage = "비밀번호는 최소 6글자 이상이어야 합니다"
                        }
                        if localizationMassage == "The email address is already in use by another account."{
                            self.errorMassage = "이미 사용중인 이메일입니다."
                        }
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            self.alert.toggle()
                        }
                        
                        return
                    }
                    
                    self.pushData()
                   
                   
                    viewModel.signIn(email: email, password: password)
                
                    
                }
                
            }else{
                self.errorMassage = "입력하신 비밀번호가 일치하지 않습니다"
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.alert.toggle()
                }
            }
        }
        else{
            self.errorMassage = "모든 칸을 입력해주세요"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.alert.toggle()
            }
        }
    }
    
}


func cal(weight : Double, height : Double, age : Double, gender : Bool, selectAtivate : Int)->String{
    if gender{
        let metabolicRate = weight * 6.25 + weight * 10 - age * 5 + 5
        let averageWeight = height / 100 * height / 100 * 22
        let bmi = weight / averageWeight * 100
        
        if selectAtivate == 1{
            let activeRate = metabolicRate * 0.2
            
            if bmi >= 110{
                let TEF = averageWeight * 25 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 30 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }else{
                let TEF = averageWeight * 35 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
            
        }
        if selectAtivate == 2{
            let activeRate = metabolicRate * 0.375
            if bmi >= 110{
                let TEF = averageWeight * 25 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 30 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }else{
                let TEF = averageWeight * 35 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
            
        }
        if selectAtivate == 3{
            let activeRate = metabolicRate * 0.555
            if bmi >= 110{
                let TEF = averageWeight * 25 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 30 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }else{
                let TEF = averageWeight * 35 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
        }else{
            let activeRate = metabolicRate * 0.725
            if bmi >= 110{
                let TEF = averageWeight * 25 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 30 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }else{
                let TEF = averageWeight * 35 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
        }
        
        
    }else{
        let metabolicRate = weight * 6.25 + weight * 10 - age * 5 - 161
        let averageWeight = height / 100 * height / 100 * 21
        let bmi = weight / averageWeight * 100
        
        if selectAtivate == 1{
            let activeRate = metabolicRate * 0.2
            
            if bmi >= 110{
                let TEF = averageWeight * 25 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 30 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }else{
                let TEF = averageWeight * 35 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
            
        }
        if selectAtivate == 2{
            let activeRate = metabolicRate * 0.375
            if bmi >= 110{
                let TEF = averageWeight * 25 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 30 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }else{
                let TEF = averageWeight * 35 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
            
        }
        if selectAtivate == 3{
            let activeRate = metabolicRate * 0.555
            if bmi >= 110{
                let TEF = averageWeight * 25 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 30 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }else{
                let TEF = averageWeight * 35 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
        }else{
            let activeRate = metabolicRate * 0.725
            if bmi >= 110{
                let TEF = averageWeight * 25 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 30 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }else{
                let TEF = averageWeight * 35 * 0.1
                let totalCal = TEF + metabolicRate + activeRate
                let roundedNum = round(totalCal * 1000) / 1000
                return String(format: "%.0f",  roundedNum)
            }
        }
    }
    
    
    
}
