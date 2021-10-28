//
//  GetBodyInfoView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/05.
//

import SwiftUI
import PopupView

struct GetBodyInfoView: View {
    
    @EnvironmentObject var userData : UserData
    
    @State var selectColor = Color.init("systemColor")
    @State var nonSelectColor = Color.init("systemColor").opacity(0.3)
    
    @State var bodyInfoCurrentPage : Int = 1
    @State var bodyInfoTotalPage : Int = 8
    
    @State var btnActivate : Bool = true
    
    @State var selection: Int? = 0
    
    @State var activate : Bool = false
    
    @State private var showAlert = false
    
    var dayActive = ["대부분 앉아있는다", "조금 활동적인 편이다", "돌아다닐 일들이 많다", "매우 활동적이다"]
    
    @State var showPopup = false
    @State var showToast = false
    @State var show : Bool = false
    
    @State var currentTime =  Date()
    
    let selectMorningTime = ["00", "01","02","03","04", "05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21", "22"]
    let selectLaunchTime = ["00", "01","02","03","04", "05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21", "22"]
    let selectDinnerTime = ["00", "01","02","03","04", "05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21", "22"]
    
    
    
    init(){
        
        UINavigationBar.appearance().backgroundColor = UIColor(Color.white)
        UINavigationBar.appearance().barTintColor = UIColor(Color.white)
        UINavigationBar.appearance().shadowImage = UIImage()
        
    }
    
    var body: some View{
        ZStack{
            
            if activate{
                SignUpView()
            }else{
                ZStack{
                    
                    LinearGradient(gradient: Gradient(colors: [Color.white, Color.white]),
                                    startPoint: .top, endPoint: .bottom)

                        .frame(width: 390, height: 700, alignment: .bottom)
                        .blur(radius: 20)
                        .padding(.top, 120)
                       
 
                    VStack{
                        Spacer()
                        
                        ifPages
                            .padding(.top, 120)
                        
                        Spacer()
                        Spacer()
             
                        
                    ChevronButton(bodyInfoCurrentPage: $bodyInfoCurrentPage, showPopup: $showPopup, activate: $activate)
                        .padding(40)
                        .padding(.bottom, 80)
                        /// 페이지 넘기기 버튼
         
                    }
                    
                }
                .ignoresSafeArea()
               
            }
            
            
           
        }
        .onTapGesture {
            hideKeyboard()
        }
       
        .navigationBarTitle("\(bodyInfoCurrentPage)/5",displayMode: .inline)
        
        
        
    }
    private var ifPages : some View{
        ZStack{
            if self.bodyInfoCurrentPage == 1{
                VStack{
                    Text("안녕하세요!")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    VStack(spacing : 10){
                        HStack(spacing : 0){
                            Text("일일 권장 섭취 칼로리")
                                .fontWeight(.bold)
                                .font(Font.custom(systemFont, size: 17))
                                .frame(height: 6, alignment: .bottom)
                                .background(Color.init("systemColor").opacity(0.5))
                                .padding(.top,10)
                            Text("를 계산하고")
                                .font(Font.custom(systemFont, size: 17))
                        }
                        HStack(spacing : 0){
                            Text("당신의")
                            Text(" 목표 달성")
                                .fontWeight(.bold)
                                .frame(height: 6, alignment: .bottom)
                                .background(Color.init("systemColor").opacity(0.5))
                                .padding(.top,10)
                            Text("을 도와드리기 위해")
                        }
                        .font(Font.custom(systemFont, size: 17))
                        Text("몇가지 질문 드리겠습니다.")
                            .font(Font.custom(systemFont, size: 17))
                    }
                    
                   
                    
                }
                .padding(.top, 50)
                .transition(.moveAndFade)
                
                
               
            }
            if self.bodyInfoCurrentPage == 2{
                VStack(spacing:35){
                    InfoTextFiled(data: $userData.nickName, btnActivate: $btnActivate, text: "닉네임", field : "닉네임")
                    
                    RadioButton(optionVariable: $userData.isTabMale, selectColor: $selectColor, nonSelectColor: $nonSelectColor, optionOne: "남성", optionTwo: "여성")
                   
                    InfoTextFiled(data: $userData.age, btnActivate: $btnActivate, text: "만 나이", field : "나이")
                   
                    InfoTextFiled(data: $userData.cmHeight, btnActivate: $btnActivate, text: "키", field : "cm")
                   
                }
                .transition(.moveAndFade)
            }
            
            if self.bodyInfoCurrentPage == 3{
                VStack(spacing:40){
                    InfoTextFiled(data: $userData.kgWeight, btnActivate: $btnActivate, text: "체중", field : "kg")
                   
                    VStack(spacing:20){
                        
                    InfoTextFiled(data: $userData.targetWeight, btnActivate: $btnActivate, text: "목표 체중", field : "kg")
                        
                        VStack(spacing : 20){
                            Text("평소 내 활동량은?")
                                .font(Font.custom(systemFont, size: 15))
                                .fontWeight(.bold)
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                               .frame(width: UIScreen.main.bounds.size.width-130, height: 32)
                                               .foregroundColor(Color.init("lightSystemColor"))
                                Picker(selection: $userData.selectActive, label: Text("")) {
                                            ForEach(0 ..< dayActive.count) {
                                                Text(self.dayActive[$0])
                                                    .font(Font.custom(systemFont, size: 17))
                                            }
                                }
                                .frame(width : 250, height: 80)
                                .clipped()
                                .pickerStyle(InlinePickerStyle())
                            }
                           
                            
                        } .padding(.top, 30)
                        
                        
                        
                    }
  
                    
                }
                .padding(.top, 30)
                .transition(.moveAndFade)
                .frame(maxWidth : .infinity, maxHeight : .infinity)
               
            }
            
            if self.bodyInfoCurrentPage == 4{
                VStack(spacing : 5){
                    VStack(spacing : 20){
                        VStack(spacing : 5){
                            Text("\(userData.nickName)님이 알려주신 식사시간을 토대로")
                            HStack(spacing : 0){
                                Text("클레이의 ")
                                Text("식사기록 시간")
                                    .fontWeight(.bold)
                                    .frame(height: 6, alignment: .bottom)
                                    .background(Color.init("systemColor").opacity(0.5))
                                    .padding(.top, 11)
                                Text("이 정해져요.")
                            }
                            .font(Font.custom(systemFont, size: 16))
                        }
                        VStack(spacing : 15){
                            VStack(spacing : 5){
                                HStack(spacing : 0){
                                    Text("설정하신 ")
                                    Text("식사시간 이후 2시간")
                                        .fontWeight(.bold)
                                        .frame(height: 6, alignment: .bottom)
                                        .background(Color.init("systemColor").opacity(0.5))
                                        .padding(.top, 11)
                                    Text("동안만")
                                }
                                .font(Font.custom(systemFont, size: 16))
                                Text("식단 기입이 가능합니다.")
                            }
                           
                            HStack(spacing : 0){
                                Text("충분히 본인의 ")
                                Text("식사 루틴")
                                    .fontWeight(.bold)
                                    .frame(height: 6, alignment: .bottom)
                                    .background(Color.init("systemColor").opacity(0.5))
                                    .padding(.top, 11)
                                Text("을 고민하시고 기입해주세요!")
                            }
                            .font(Font.custom(systemFont, size: 16))
                        }
                    }.padding(.bottom, 40)
                  
                        
                        
                    VStack(spacing : 45){
                        VStack(spacing : 10){
                            Text("아침 식사 시간")
                                .font(Font.custom(systemFont, size: 17))
                                .fontWeight(.bold)
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                               .frame(width: 220 ,height: 32)
                                               .foregroundColor(Color.init("lightSystemColor"))
                                Picker("selected student", selection: $userData.userMorningTime) {
                                            ForEach(0 ..< selectMorningTime.count) {
                                                Text(self.selectMorningTime[$0])
                                                    .font(Font.custom(systemFont, size: 17))
                                                   
                                            }
                                            
                                }
                                .pickerStyle(WheelPickerStyle())
                                
                                .frame(width : 220, height: 75)
                                .clipped()
                            }
                            
                        }
                        
                        VStack(spacing : 10){
                            Text("점심 식사 시간")
                                .font(Font.custom(systemFont, size: 17))
                                .fontWeight(.bold)
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                               .frame(width: 220, height: 32)
                                               .foregroundColor(Color.init("lightSystemColor"))
                                Picker("selected student", selection: $userData.userLaunchTime) {
                                            ForEach(0 ..< selectLaunchTime.count) {
                                                Text(self.selectLaunchTime[$0])
                                                    .font(Font.custom(systemFont, size: 17))
                                                   
                                            }
                                            
                                }
                                .pickerStyle(WheelPickerStyle())
                                
                                .frame(width : 220, height: 75)
                                .clipped()
                            }
                            
                        
                        }
                        VStack(spacing : 10){
                            Text("저녁 식사 시간")
                                .font(Font.custom(systemFont, size: 17))
                                .fontWeight(.bold)
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                               .frame(width:220, height: 32)
                                               .foregroundColor(Color.init("lightSystemColor"))
                                Picker("selected student", selection: $userData.userDinnerTime) {
                                            ForEach(0 ..< selectDinnerTime.count) {
                                                Text(self.selectDinnerTime[$0])
                                                    .font(Font.custom(systemFont, size: 17))
                                                   
                                            }
                                            
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width : 220, height: 75)
                                .clipped()
                            }
                           
                                        
                            
                        }
                    }
                    
                    
                }
                .overlay(
                    ZStack{
                        if showPopup{
                            Color.primary.opacity(0.2)
                                .frame(width: 400, height: 1000, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                                
                            DribbleAnimated(showPopup: $showPopup)
                                .offset(y : showPopup ? 0 : UIScreen.main.bounds.height)
                                .navigationBarHidden(true)
                        }
                        
                       
                    }
                    .zIndex(5)
                    .ignoresSafeArea()
                
                )
                
               
            
                    
                  
                }
               
                
            
            if self.bodyInfoCurrentPage == 5{
                
                VStack(spacing : 10){
                    VStack(spacing :10){
                        HStack(spacing : 0){
                            
                            Text("이번 달 ")
                                .font(Font.custom(systemFont, size: 17))
                            
                            Text("\(userData.nickName)")
                                .font(Font.custom(systemFont, size: 20))
                                .fontWeight(.bold)
                                .frame(height: 6, alignment: .bottom)
                                .background(Color.init("systemColor").opacity(0.5))
                                .padding(.top,10)
                            
                            Text("님은 매일 ")
                                .font(Font.custom(systemFont, size: 17))
                            Text("\(userData.totalKcal)kcal")
                                .font(Font.custom(systemFont, size: 20))
                                .fontWeight(.bold)
                                
                                .frame(height: 6, alignment: .bottom)
                                .background(Color.init("systemColor").opacity(0.5))
                                .padding(.top,10)
                            Text("를 ")
                                .font(Font.custom(systemFont, size: 17))
                        }
                        
                        
                        VStack(spacing : 40){
                            Text("섭취하는 것을 권장합니다!")
                                .font(Font.custom(systemFont, size: 17))
                            Text("클레이와 함께해요!")
                                .font(Font.custom(systemFont, size: 20))
                        }
                    }.padding(.bottom , 80)
                 
                   
                    VStack(spacing : 30){
                        Button(action: {
                            
                            activate.toggle()
                            
                        }, label: {
                            Text("시작하기")
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.init("systemColor"))
                                .cornerRadius(20)
                                .shadow(color: .gray, radius: 1)
                                .overlay(
                                        Capsule()
                                            .stroke(nonSelectColor, lineWidth: 3))
                                
                        })
                        .opacity(show ? 1 : 0)
                        .offset(y : show ? -20 : 0)
                        .animation(Animation.spring().delay(0.1))
                        
                        Button(action: {
                            bodyInfoCurrentPage = 2
                        }, label: {
                            Text("다시 설문 하기")
                                .bold()
                                .foregroundColor(Color.init("systemColor"))
                                .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: .gray, radius: 1)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 18)
                                            .stroke(nonSelectColor, lineWidth: 3))
                                
                        })
                        .opacity(show ? 1 : 0)
                        .offset(y : show ? -20 : 0)
                        .animation(Animation.spring().delay(0.2))
                    }
                    
                    
                    
                }
                .padding(.top, 70)
                .onAppear{
                    show = true
                }
                    
                
                }
            
            if self.bodyInfoCurrentPage == 6{
                
                VStack(spacing : 10){
                    VStack(spacing :10){
                        
                
                        Text("너무 극단적인 목표설정이에요😭")
                        Text("클레이는 건강한 당신을 위해 적정 수준의")
                        Text("다이어트 가이드라인을 제시해드립니다.")
                        Text("목표를 다시 설정해주세요!")
                    }.padding(.bottom , 80)
                 
                   
                    VStack(spacing : 30){
                        
                        Button(action: {
                            bodyInfoCurrentPage = 2
                        }, label: {
                            Text("다시 설문 하기")
                                .bold()
                                .foregroundColor(Color.white)
                                .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.init("systemColor"))
                                .cornerRadius(20)
                                .shadow(color: .gray, radius: 1)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 18)
                                            .stroke(nonSelectColor, lineWidth: 3))
                                
                        })
                        .opacity(show ? 1 : 0)
                        .offset(y : show ? -20 : 0)
                        .animation(Animation.spring().delay(0.2))
                    }
                    
                    
                    
                }
                .navigationBarTitle("")
                .padding(.top, 70)
                .onAppear{
                    show = true
                }
                    
                
                }
            
        }
        
        
    }
  
}

struct DribbleAnimated : View{
    @EnvironmentObject var userData : UserData
    @Environment(\.colorScheme) var scheme
    @Binding var showPopup : Bool
    
    @State var animateBall = false
    @State var animateRotation  = false
    
    var body: some View{
        VStack{
            ZStack{
                (scheme == .dark ? Color.black  : Color.white)
                    .frame(width : 390 , height: 1000)
                    .cornerRadius(15)
//                    .shadow(color: Color.primary.opacity(0.07), radius: 5, x: 5, y: 5)
//                    .shadow(color: Color.primary.opacity(0.07), radius: 5, x: -5, y: -5)
                
                Ellipse()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 100, height: 40)
                    .cornerRadius(200)
    //                .rotation3DEffect(
    //                    .init(degrees: 60),
    //                    axis: (x:1, y: 0, z: 0),
    //                    anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
    //                    anchorZ: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
    //                    perspective: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/
    //                )
                    .navigationBarHidden(true)
                    .offset(y:60)
                    .opacity(animateBall ? 0.5 : 0)
               
                    Image("clayLoading")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        //                .rotationEffect(.init(degrees: animateRotation ? 360 : 0))
                        .offset(y : animateBall ? 10 : -25)
                        .padding(.bottom, 60)
                Text("클레이가 \(userData.nickName)님의 다이어트 계획을 짜고 있어요...")
                        .font(.system(size: 15))
                        .offset(y:120)
                        
                
               
            }
            
             
        }
        .offset(y: -20)
        .navigationBarHidden(true)
        .onAppear(perform: {
            doAnimation()
        })
    }
    func doAnimation(){
        withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true)){
            animateBall.toggle()
        }
        withAnimation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: false)){
            animateRotation.toggle()
        }
    }
}


