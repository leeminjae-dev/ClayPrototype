//
//  BodyInfoPages.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/03.
//

import SwiftUI
import Combine

class User: ObservableObject {
    
    @Published var age : String = ""
    @Published var cmHeight: String = ""
    @Published var kgWeight : String = ""
    @Published var targetWeight :String = ""
    @Published var isTabMale : Bool = false
    @Published var isTabFemale : Bool = true
    @Published var nickName : String = ""
    @Published var selectActive : Int = 0
    @Published var totalKcal : String? = ""
    @Published var userPoint : String = "0"
}


struct BodyInfoPages: View {

    @EnvironmentObject var userData  : User

    @State var selectColor = Color.init("userPink")
    @State var nonSelectColor = Color.init("userPink").opacity(0.3)
    @Binding var bodyInfoCurrentPage : Int

    @State var BtnActivate : Bool = true
    
    
    var dayActive = ["대부분 앉아있는다", "조금 활동적인 편이다", "돌아다닐 일들이 많다", "매우 활동적이다"]
    
    
    
    //네비게이션 바 버튼
    var body: some View{
        ZStack{
            if bodyInfoCurrentPage == 0{
                AreYouFirstView()
            }else{
                VStack{
                    HStack{
                        Button(action: {
                            withAnimation(.easeInOut){
                                bodyInfoCurrentPage -= 1
                                if bodyInfoCurrentPage == 2{
                                    BtnActivate = true
                                }
                                
                            }
                        }, label: {
                            if bodyInfoCurrentPage < 0{
                                Text("")
                            }else{
                                Image(systemName: "chevron.left")
                                    .font(Font.custom(systemFont, size: 20))
                                    .padding(.leading, 20)
                            }
                           
                                
                        })
                    
                        Spacer()
                        Text("\(bodyInfoCurrentPage)/8")
                            .font(Font.custom(systemFont, size: 25))
                            .fontWeight(.semibold)
                            .padding(.trailing,43)
                        Spacer()
                            
                        
                    }
                    
                    Spacer()
                    
                    ifPages
                    
                    
                    Spacer()
                    Spacer()
                    
                        .overlay(
                            // 다음페이지 넘기기 버튼
                            Button(action: {
                                    
                                    withAnimation(.easeInOut){
                                    if self.bodyInfoCurrentPage <= getBodyInfoTotalPage && self.BtnActivate{
                                        if self.bodyInfoCurrentPage == 4 || self.bodyInfoCurrentPage == 6{
                                            self.bodyInfoCurrentPage += 1
                                        }
                                    
                                        else{
                                            ///self.BtnActivate.toggle()
                                            self.bodyInfoCurrentPage += 1
                                    }
                                   
                                }
                                       
                            }}, label: {
                                if self.BtnActivate{
                                    VStack{
                                        let chevronBtn = Image(systemName: "chevron.right")
                                        let chevronBtnA = chevronBtn
                                            .foregroundColor(Color.black)
                                        let chevronBtnB = chevronBtnA
                                            .font(Font.custom(systemFont, size: 20))
                                        let chevronBtnC = chevronBtnB
                                            .frame(width: 60, height: 60, alignment: .center)
                                        let chevronBtnD = chevronBtnC
                                            .background(Color.init("userPink"))
                                        chevronBtnD
                                            .clipShape(Circle())
                                            .overlay(
                                                ZStack{
                                                    Circle()
                                                        .stroke(Color.black.opacity(0.04), lineWidth: 4)
                                                    Circle()
                                                        .trim(from: 0, to: CGFloat(bodyInfoCurrentPage)/CGFloat(getBodyInfoTotalPage))
                                                        .stroke(Color.init("userPink"), lineWidth: 4)
                                                        .rotationEffect(.init(degrees: -90))
                                                    
                                                }
                                                .padding(-15)
                                            )
                                        
                                    }
                                    
                                }else{
                                    let chevronBtnF = Image(systemName: "chevron.right")
                                    let chevronBtnG = chevronBtnF
                                        .foregroundColor(Color.black)
                                    let chevronBtnH = chevronBtnG
                                        .font(Font.custom(systemFont, size: 20))
                                    let chevronBtnI = chevronBtnH
                                        .frame(width: 60, height: 60, alignment: .center)
                                    let chevronBtnJ = chevronBtnI
                                        .background(Color.init("userPink")).opacity(0.3)
                                    chevronBtnJ
                                        .clipShape(Circle())
                                    
                                        .overlay(
                                            ZStack{
                                                Circle()
                                                    .stroke(Color.black.opacity(0.04), lineWidth: 4)
                                                Circle()
                                                    .trim(from: 0, to: CGFloat(bodyInfoCurrentPage)/CGFloat(getBodyInfoTotalPage))
                                                    .stroke(Color.init("userPink"), lineWidth: 4)
                                                    .rotationEffect(.init(degrees: -90))
                                            }
                                            .padding(-15)
                                        )
                                }
                                
                            })
                                
                            
                            
                           
                            
                        )
                }
            }
           
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
        
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
                    Text("만 나이로 몇살이신가요?")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                    TextField("나이", text:$userData.age)
                        .keyboardType(.decimalPad)
                        .padding(10)
                        .font(Font.custom(systemFont, size: 15))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(userData.age != "" ? Color(.secondarySystemBackground): Color.init("userPink")))
                        .frame(width: 200, height: 20, alignment: .center)
                        Text("숫자로만 입력해주세요")
                            .font(Font.custom(systemFont, size: 15))
                            .foregroundColor(.black).opacity(0.5)
                    
                }
                .transition(.moveAndFade)
            }
            
            if self.bodyInfoCurrentPage == 3{
                VStack(spacing:30){
                    Text("키는 몇 cm인가요?")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                    TextField("키", text:$userData.cmHeight)
                        .keyboardType(.decimalPad)
                        .padding(10)
                        .font(Font.custom(systemFont, size: 15))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(userData.cmHeight != "" ? Color(.secondarySystemBackground): Color.init("userPink")))
                        .frame(width: 200, height: 20, alignment: .center)
                        Text("숫자로만 입력해주세요")
                            .font(Font.custom(systemFont, size: 15))
                            .foregroundColor(.black).opacity(0.5)
                    
                }
                .transition(.moveAndFade)
            }
            
            if self.bodyInfoCurrentPage == 4{
                VStack(spacing:30){
                    Text("현재 체중은 몇 kg인가요?")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                    TextField("체중", text:$userData.kgWeight)
                        .keyboardType(.decimalPad)
                        .padding(10)
                        .font(Font.custom(systemFont, size: 15))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(userData.kgWeight != "" ? Color(.secondarySystemBackground): Color.init("userPink")))
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
                    Text("목표 체중을 입력해주세요")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                    TextField("목표 체중", text:$userData.targetWeight)
                        .keyboardType(.decimalPad)
                        .padding(10)
                        .font(Font.custom(systemFont, size: 15))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(userData.targetWeight != "" ? Color(.secondarySystemBackground): Color.init("userPink")))
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
                    Text("원하시는 닉네임을 설정해주세요")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                    TextField("닉네임", text:$userData.nickName)
                       
                        .padding(10)
                        .font(Font.custom(systemFont, size: 15))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(RoundedRectangle(cornerRadius: 5).stroke(userData.nickName != "" ? Color(.secondarySystemBackground): Color.init("userPink")))
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
    
        func callMeAge(with tx: String) {
            if userData.age.isEmpty{
                
                BtnActivate = false
                
            }else{
                
                BtnActivate = true
            }
           
        }

    func callMeHeight(with tx: String) {
        if userData.cmHeight.isEmpty{
            
            BtnActivate = false
            
        }else{
            
            BtnActivate = true
        }
       
    }
    func callMeWeight(with tx: String) {
        if userData.kgWeight.isEmpty{
            
            BtnActivate = false
            
        }else{
            
            BtnActivate = true
        }
       
    }
    func callMeTarget(with tx: String) {
        if userData.targetWeight.isEmpty{
            
            BtnActivate = false
            
        }else{
            
            BtnActivate = true
        }
       
    }
    func callMeNickName(with tx: String) {
        if userData.nickName.isEmpty{
            
            BtnActivate = false
            
        }else{
            
            BtnActivate = true
        }
       
    }
   
   
}


var getBodyInfoTotalPage = 8


