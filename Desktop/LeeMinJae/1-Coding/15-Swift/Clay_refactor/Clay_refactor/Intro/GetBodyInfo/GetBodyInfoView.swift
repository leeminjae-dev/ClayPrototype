//
//  GetBodyInfoView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/05.
//

import SwiftUI

struct GetBodyInfoView: View {
    @EnvironmentObject var userData : UserData
    
    @State var selectColor = Color.init("systemColor")
    @State var nonSelectColor = Color.init("systemColor").opacity(0.3)
    
    @State var bodyInfoCurrentPage : Int = 1
    @State var bodyInfoTotalPage : Int = 8
    
    @State var BtnActivate : Bool = true
    
    @State var selection: Int? = 0
    
    @State var activate : Bool = false
    var dayActive = ["대부분 앉아있는다", "조금 활동적인 편이다", "돌아다닐 일들이 많다", "매우 활동적이다"]
    
    init(){
        UINavigationBar.appearance().backgroundColor = UIColor(Color.white)
        UINavigationBar.appearance().barTintColor = UIColor(Color.white)
        UINavigationBar.appearance().shadowImage = UIImage()
        ///UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        ///UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        ///Use this if NavigationBarTitle is with displayMode = .inline
        ///UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    var body: some View{
        ZStack{
            if activate{
                SignUpView()
            }else{
                VStack{
                    Spacer()
                    
                    ifPages
                    
                    Spacer()
                    Spacer()
           // 다음페이지 넘기기 버튼
                    
                        Button(action: {
                                withAnimation(.easeInOut){
                                    if self.BtnActivate{
                                        if self.bodyInfoCurrentPage == 4 || self.bodyInfoCurrentPage == 6{
                                            
                                            self.bodyInfoCurrentPage += 1
                                            
                                            
                                        }
                                        else if self.bodyInfoCurrentPage == 8{
                                        
                                            self.activate = true
                                            
                                        
                                        }else{
                                        
                                            self.BtnActivate.toggle()
                                            self.bodyInfoCurrentPage += 1
                        
                                    }
                               }
                                    
                                }
                            
                        }, label: {
                    
                            if self.BtnActivate{
                                VStack{
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.black)
                                        .font(Font.custom(systemFont, size: 20))
                                        .frame(width: 60, height: 60, alignment: .center)
                                        .background(Color.init("systemColor"))
                                        .clipShape(Circle())
                                        .overlay(
                                            
                                            ZStack{
                                                Circle()
                                                    .stroke(Color.black.opacity(0.04), lineWidth: 4)
                                                Circle()
                                                    .trim(from: 0, to: CGFloat(bodyInfoCurrentPage)/CGFloat(bodyInfoTotalPage))
                                                    .stroke(Color.init("systemColor"), lineWidth: 4)
                                                    .rotationEffect(.init(degrees: -90))
                                                
                                            }
                                            .padding(-15)
                                        )
                                }
                                
                            }
                            else{
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.black)
                                    .font(Font.custom(systemFont, size: 20))
                                    .frame(width: 60, height: 60, alignment: .center)
                                    .background(Color.init("systemColor")).opacity(0.3)
                                    .clipShape(Circle())
                                    .overlay(
                                        ZStack{
                                            Circle()
                                                .stroke(Color.black.opacity(0.04), lineWidth: 4)
                                            Circle()
                                                .trim(from: 0, to: CGFloat(bodyInfoCurrentPage)/CGFloat(bodyInfoTotalPage))
                                                .stroke(Color.init("systemColor"), lineWidth: 4)
                                                .rotationEffect(.init(degrees: -90))
                                        }
                                        .padding(-15)
                                    )
                                
                            }
                            
                        })
                    
                    Spacer()
                    
                }
            }
            
           
        }
        .navigationBarTitle("\(bodyInfoCurrentPage)/8",displayMode: .inline)
        
        
        
    }
    private var ifPages : some View{
        ZStack{
            if self.bodyInfoCurrentPage == 1{
                VStack{
                    Text("안녕하세요!")
                        .font(Font.custom(systemFont, size: 25))
                        .fontWeight(.bold)
                    
                    Text("일일 권장 섭취 칼로리를 계산하고\n   목표달성을 도와드리기 위해서\n         몇가지 질문을 드릴게요")
                        .padding()
                        .font(Font.custom(systemFont, size: 20))
                    
                }
                .transition(.moveAndFade)
                
                
               
            }
            if self.bodyInfoCurrentPage == 2{
                VStack(spacing:30){
                    
                    let binding = Binding<String>(get: {
                        userData.age
                           }, set: {
                            userData.age = $0
                            BtnActivate = true
                           })
                       
                    Text("만 나이로 몇살이신가요?")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                    
                    TextField("나이", text: binding)
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                        .padding(10)
                        .font(Font.custom(systemFont, size: 15))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(userData.age != "" ? Color(.secondarySystemBackground): Color.init("systemColor")))
                        .frame(width: 200, height: 20, alignment: .center)
                    
                        Text("숫자로만 입력해주세요")
                            .font(Font.custom(systemFont, size: 15))
                            .foregroundColor(.black).opacity(0.5)
                         
                }
                .transition(.moveAndFade)
            }
            
            if self.bodyInfoCurrentPage == 3{
                
                VStack(spacing:30){
                    
                    let binding = Binding<String>(get: {
                        userData.cmHeight
                           }, set: {
                            userData.cmHeight = $0
                            BtnActivate = true
                           })
                    
                    Text("키는 몇 cm인가요?")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                    TextField("키", text:binding)
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                        .padding(10)
                        .font(Font.custom(systemFont, size: 15))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(userData.cmHeight != "" ? Color(.secondarySystemBackground): Color.init("systemColor")))
                        .frame(width: 200, height: 20, alignment: .center)
                        Text("숫자로만 입력해주세요")
                            .font(Font.custom(systemFont, size: 15))
                            .foregroundColor(.black).opacity(0.5)
                    
                }
                .transition(.moveAndFade)
            }
            
            if self.bodyInfoCurrentPage == 4{
                VStack(spacing:30){
                    
                    let binding = Binding<String>(get: {
                        userData.kgWeight
                           }, set: {
                            userData.kgWeight = $0
                            BtnActivate = true
                           })
                    Text("현재 체중은 몇 kg인가요?")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                    TextField("체중", text:binding)
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                        .padding(10)
                        .font(Font.custom(systemFont, size: 15))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(userData.kgWeight != "" ? Color(.secondarySystemBackground): Color.init("systemColor")))
                        .frame(width: 200, height: 20, alignment: .center)
                        Text("숫자로만 입력해주세요")
                            .font(Font.custom(systemFont, size: 15))
                            .foregroundColor(.black).opacity(0.5)
                            
                    
                }
                .transition(.moveAndFade)
            }
            
            if self.bodyInfoCurrentPage == 5{
                VStack(spacing:30){
                  
                    Text("성별을 알려주세요.")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                        
                    HStack(spacing: 50){
                        Button(action: {
                            
                            userData.isTabMale.toggle()
                           

                            
                        }, label: {
                            
                            if userData.isTabMale{
                                Text("남성")
                                    .bold()
                                    .foregroundColor(.black)
                                    .frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.white)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 18)
                                                .stroke(nonSelectColor, lineWidth: 3))
                                
                            }else{
                                
                                Text("남성")
                                    .bold()
                                    .foregroundColor(.black)
                                    .frame(width : 150, height : 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.white)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 18)
                                                .stroke(selectColor, lineWidth: 3))
                                
                            }
                            
                                })
                        Button(action: {
                            
                            userData.isTabMale.toggle()
                            

                            
                        }, label: {
                            
                            if !userData.isTabMale{
                                Text("여성")
                                    .bold()
                                    .foregroundColor(.black)
                                    .frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.white)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 18)
                                                .stroke(nonSelectColor, lineWidth: 3))
                                
                            }else{
                                
                                Text("여성")
                                    .bold()
                                    .foregroundColor(.black)
                                    .frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.white)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 18)
                                                .stroke(selectColor, lineWidth: 3))
                                
                            }
                            
                                })
                    }
                }
                
                .transition(.moveAndFade)
                
            }
            
            if self.bodyInfoCurrentPage == 6{
                VStack(spacing:30){
                    
                    let binding = Binding<String>(get: {
                        userData.targetWeight
                           }, set: {
                            userData.targetWeight = $0
                            BtnActivate = true
                           })
                    Text("목표 체중을 입력해주세요")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                    TextField("목표 체중", text:binding)
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                        .padding(10)
                        .font(Font.custom(systemFont, size: 15))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(userData.targetWeight != "" ? Color(.secondarySystemBackground): Color.init("systemColor")))
                        .frame(width: 200, height: 20, alignment: .center)
                        Text("숫자로만 입력해주세요")
                            .font(Font.custom(systemFont, size: 15))
                            .foregroundColor(.black).opacity(0.5)
                    
                }
                .transition(.moveAndFade)
            }
            
            if self.bodyInfoCurrentPage == 7{
                VStack{
                Text("평소 내 활동량은?")
                    .font(Font.custom(systemFont, size: 20))
                    .fontWeight(.bold)
                    Picker(selection: $userData.selectActive, label: Text("하루에 얼마나 움직이시나요?")) {
                                ForEach(0 ..< dayActive.count) {
                                    Text(self.dayActive[$0])
                                }
                            }
                }
                .transition(.moveAndFade)
                
            }
            
            if self.bodyInfoCurrentPage == 8{
                
                VStack(spacing:30){
                    
                    let binding = Binding<String>(get: {
                        userData.nickName
                           }, set: {
                            userData.nickName = $0
                            BtnActivate = true
                           })
                    
                    Text("원하시는 닉네임을 설정해주세요")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                    
                    TextField("닉네임", text:binding)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .font(Font.custom(systemFont, size: 15))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(userData.nickName != "" ? Color(.secondarySystemBackground): Color.init("systemColor")))
                        .frame(width: 200, height: 20, alignment: .center)
                    
                        Text("숫자로만 입력해주세요")
                            .font(Font.custom(systemFont, size: 15))
                            .foregroundColor(.black).opacity(0.5)
                    
                    if BtnActivate{
                        Text("모든 준비가 완료되었어요!")
                            .font(Font.custom(systemFont, size: 15))
                            .foregroundColor(.blue)
                    }
                    
                }
                .transition(.moveAndFade)
            }
        }
    }
  
}

