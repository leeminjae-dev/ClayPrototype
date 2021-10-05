import SwiftUI
import Firebase

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        
        SignUpView()
    }
}

struct SignUpView : View{
   
    @AppStorage("userEmail") var userEmail = ""
    
    @EnvironmentObject var userData : UserData
    @EnvironmentObject var viewModel : SignAppViewModel
    
    @State var password = ""
    @State var passwordCorrect = ""
    @State var visible = false
    @State private var color = Color.init("systemColor").opacity(0.7)
    
    @State var alert = false
    @State var errorMassage = ""
    @State var alertSuccess = false
    @State var localizationMassage = ""
    @State var isLoading = false
    
    @State var selection : Int? = nil
    
    @State var vari : Int = 1
    
    let selectMorningTime = ["05","06","07","08","09"]
    let selectLaunchTime = ["10","11","12","13","14","15"]
    let selectDinnerTime = ["16","17","18","19","20","21"]
    
    var body: some View{
        ZStack{
            ZStack{
                VStack(spacing: 20){
                    let binding = Binding<String>(
                        get: {
                        userData.email
                           },
                        set: {
                            userData.email = $0
                            
                           })
                    VStack{
                        ZStack{
                            Image("logo")
                                .resizable()
                                .frame(width: 150, height: 150)
                            VStack{
                                Text("나를 빚는 시간")
                                    .font(Font.custom(systemFont, size: 10))
                                   
                                Text("CLAY")
                                    .font(Font.custom(systemFont, size: 35))
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(Color.init("logoColor"))
                            .offset(y : 90)
                        }
                    }.padding(.bottom, 60)
                    
                    TextField("이메일", text : binding)
                        .padding(10)
                        .font(Font.custom(systemFont, size: 15))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(userData.email != "" ? Color(.secondarySystemBackground): self.color))
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
                    .background(RoundedRectangle(cornerRadius: 5).stroke(userData.email != "" ? Color(.secondarySystemBackground): self.color))
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
                    .background(RoundedRectangle(cornerRadius: 5).stroke(userData.email != "" ? Color(.secondarySystemBackground): self.color))
                    .frame(width: 350, height: 10, alignment: .center)
                    
                    //가입하기
                    
                    Button(action: {
                        
                        self.register()
                        userEmail = userData.email
                        
                        /*guard !email.isEmpty, !password.isEmpty else{
                            return
                            
                        }
                        viewModel.signIn(email: email, password: password)*/
                    }, label: {
                        Text("가입하기")
                            .font(Font.custom(systemFont, size: 20))
                            .foregroundColor(.white)
                            .frame(width: 350, height: 50)
                            .background(Color.init("systemColor"))
                            .cornerRadius(10)
                            .padding()
                            .shadow(color: .gray, radius: 6,y: 3)
                    })
                    
                    
                }
                .navigationBarTitle(Text("계정 만들기"),displayMode: .inline)
                
                
                ZStack{
                    if self.alert{
                        
                        WrongRegisterErrorView(alert: self.$alert, errorMassage: self.$errorMassage)

                    }
                    if self.alertSuccess{
                        SignSuccessView(alert: $alertSuccess, errorMassage: $errorMassage)
                    }
                    if self.isLoading{
                        
                        Loader()
                            .onAppear(perform: {
                                delayText()
                            })
                        
                        }
                }
            }
            .padding(.bottom, 120)
        }
        .transition(.moveAndFade)
       

              
            
        
    }
    
    func delayText() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.isLoading.toggle()
        }
    }

    func verify(){
        self.isLoading = true
        if userData.email != "" && self.password != ""{
           
            Auth.auth().signIn(withEmail: userData.email, password: self.password){ (res, err) in
                self.isLoading = false

                if err != nil{
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.alert.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.alert.toggle()
                        }
                    }
 
                }else{
                    
                }
                
                viewModel.signIn(email: userData.email, password: password)
            }
            
            
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.alert.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.alert.toggle()
                }
            }
        }
        
    }
    
    func register(){
        
        self.isLoading = true
        if userData.email != ""{
            if self.password == self.passwordCorrect{
                Auth.auth().createUser(withEmail: userData.email, password: self.password) {
                    (result, err) in
                    
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.alert.toggle()
                            }
                        }
                    }else{
                        pushData()
                        self.errorMassage = "회원가입이 완료되었습니다."
                        alertSuccess.toggle()
                        viewModel.signIn(email: userData.email, password: password)
                        
                    }
                        
                      
                }
                
            }else{
                self.errorMassage = "입력하신 비밀번호가 일치하지 않습니다"
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.alert.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.alert.toggle()
                    }
                }
            }
        }else{
            self.errorMassage = "모든 칸을 입력해주세요"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.alert.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.alert.toggle()
                }
            }
        }
    }
    func pushData() {
        userData.totalKcal = cal(weight: Double(userData.kgWeight)!, height: Double(userData.cmHeight)!, age: Double(userData.age)!, gender: userData.isTabMale, selectAtivate: userData.selectActive, targetWeight: Double(userData.targetWeight)!)
        
        firebaseData.createData(email: userData.email, age: userData.age, cmHeight: userData.cmHeight, kgWeight: userData.kgWeight, targetWeight: userData.targetWeight, isTabMale: userData.isTabMale ? "Female" : "Male", nickName: userData.nickName, totalKcal: userData.totalKcal, userPoint: userData.userPoint, archieveRate: userData.archieveRate, targetArchieve: userData.targetArchieve,homeCount: 1, userMorningTime: selectMorningTime[userData.userMorningTime], userLaunchTime: selectLaunchTime[userData.userLaunchTime], userDinnerTime: selectDinnerTime[userData.userDinnerTime], archievePoint: "0")
    }
}


func cal(weight : Double, height : Double, age : Double, gender : Bool, selectAtivate : Int, targetWeight : Double)->String{
    if gender{
       
        let averageWeight = height / 100 * height / 100 * 21
        let bmi = weight / averageWeight * 100
        let minusWeight = weight - targetWeight
        let dayKcal = minusWeight * 7200 / 90
        if selectAtivate == 0{
           
            if bmi >= 110{
                let TEF = averageWeight * 25 - dayKcal
                
                return String(format: "%.0f",  TEF)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 30 - dayKcal
                return String(format: "%.0f",  TEF)
            }else{
                let TEF = averageWeight * 35 - dayKcal
                return String(format: "%.0f",  TEF)
            }
            
        }
        if selectAtivate == 1{
            
            if bmi >= 110{
                let TEF = averageWeight * 30 - dayKcal
                return String(format: "%.0f",  TEF)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 35 - dayKcal
                return String(format: "%.0f",  TEF)
            }else{
                let TEF = averageWeight * 40 - dayKcal
                return String(format: "%.0f",  TEF)
            }
            
        }
        if selectAtivate == 2{
            
            if bmi >= 110{
                let TEF = averageWeight * 35 - dayKcal
                return String(format: "%.0f",  TEF)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 40 - dayKcal
                return String(format: "%.0f",  TEF)
            }else{
                let TEF = averageWeight * 45 - dayKcal
                return String(format: "%.0f",  TEF)
            }
        }else{
            
            if bmi >= 110{
                let TEF = averageWeight * 40 - dayKcal
                return String(format: "%.0f",  TEF)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 45 - dayKcal
                return String(format: "%.0f",  TEF)
            }else{
                let TEF = averageWeight * 50 - dayKcal
                return String(format: "%.0f",  TEF)
            }
        }
        
        
    }else{
      
        let averageWeight = height / 100 * height / 100 * 22
        let bmi = weight / averageWeight * 100
        let minusWeight = weight - targetWeight
        let dayKcal = minusWeight * 7200 / 90
        
        if selectAtivate == 0{
            
            
            if bmi >= 110{
                let TEF = averageWeight * 25 - dayKcal
                return String(format: "%.0f",  TEF)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 30 - dayKcal
                return String(format: "%.0f",  TEF)
            }else{
                let TEF = averageWeight * 35 - dayKcal
                return String(format: "%.0f",  TEF)
            }
            
        }
        if selectAtivate == 1{
            
            if bmi >= 110{
                let TEF = averageWeight * 30 - dayKcal
                return String(format: "%.0f",  TEF)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 35 - dayKcal
                return String(format: "%.0f",  TEF)
            }else{
                let TEF = averageWeight * 40 - dayKcal
                return String(format: "%.0f",  TEF)
            }
            
        }
        if selectAtivate == 2{
            
            if bmi >= 110{
                let TEF = averageWeight * 35 - dayKcal
                return String(format: "%.0f",  TEF)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 40 - dayKcal
                return String(format: "%.0f",  TEF)
            }else{
                let TEF = averageWeight * 45 - dayKcal
                return String(format: "%.0f",  TEF)
            }
        }else{
            
            if bmi >= 110{
                let TEF = averageWeight * 40 - dayKcal
                return String(format: "%.0f",  TEF)
            }
            if bmi < 110 && bmi >= 90 {
                let TEF = averageWeight * 45 - dayKcal
                return String(format: "%.0f",  TEF)
            }else{
                let TEF = averageWeight * 50 - dayKcal
                return String(format: "%.0f",  TEF)
            }
        }
    }
    
    
    
}
