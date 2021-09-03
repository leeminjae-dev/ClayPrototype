//
//  BodyInfoPages.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/03.
//

import SwiftUI
import Combine



struct BodyInfoPages: View {
    
    @Binding var bodyInfoCurrentPage : Int
    
    @State var age : String = ""
    @State var cmHeight: String = ""
    @State var kgWeight : String = ""
    @State var targetWeight = ""
    @State var isTabMale : Bool = true
    @State var isTabFemale : Bool = false
    @State var nickName : String = ""
    @State var BtnActivate : Bool = true
    
    var dayActive = ["대부분 앉아있는다", "조금 활동적인 편이다", "돌아다닐 일들이 많다", "매우 활동적이다."]
    @State var selectedColor = 0
    
    var body: some View{
        VStack{
            HStack{
                if bodyInfoCurrentPage == 1{
                    Text("")
                        .font(Font.custom(systemFont, size: 15))
                    }
                else{
                    Button(action: {
                        withAnimation(.easeInOut){
                            bodyInfoCurrentPage -= 1
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(Font.custom(systemFont, size: 20))
                            .padding(.leading, 20)
                            
                    })
                }
                Spacer()
                Text("\(bodyInfoCurrentPage)/8")
                    .font(Font.custom(systemFont, size: 25))
                    .fontWeight(.semibold)
                    .padding(.trailing, 200)
                    
                
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
                            }else{
                                self.BtnActivate.toggle()
                                self.bodyInfoCurrentPage += 1
                            }
                           
                        }
                               
                    }}, label: {
                        if self.BtnActivate{
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
    private var ifPages : some View{
        ZStack{
            if self.bodyInfoCurrentPage == 1{
                VStack{
                    Text("안녕하세요!")
                        .font(Font.custom(systemFont, size: 25))
                        .fontWeight(.bold)
                    Text("일일 권장 섭취 칼로리를 계산하고\n   목표달성을 도와드리기 위해서\n         몇가지 질문을 드릴게요.")
                        .padding()
                        .font(Font.custom(systemFont, size: 20))
                }

                .transition(.slide)
               
            }
            
            if self.bodyInfoCurrentPage == 2{
                GetBodyTextFieldPages(text: "만 나이로 몇살이신가요?", filedText: "만 나이", variable: self.$age, BtnActivate: $BtnActivate)
                
            }
            
            if self.bodyInfoCurrentPage == 3{
                GetBodyTextFieldPages(text: "키는 몇 cm인가요?", filedText: "키", variable: self.$cmHeight, BtnActivate: $BtnActivate)
            }
            
            if self.bodyInfoCurrentPage == 4{
                GetBodyTextFieldPages(text: "현재 체중은 몇 kg인가요?", filedText: "현재 체중", variable: self.$kgWeight, BtnActivate: $BtnActivate)
            }
            
            if self.bodyInfoCurrentPage == 5{
                VStack(spacing:30){
                  
                    Text("성별을 알려주세요.")
                        .font(Font.custom(systemFont, size: 20))
                        .fontWeight(.bold)
                        
                    GenderSelectBtn(istabMale: $isTabMale, istabFemale: $isTabFemale)
                    
                }
                .transition(.slide)
            }
            
            if self.bodyInfoCurrentPage == 6{
                GetBodyTextFieldPages(text: "목표 체중을 입력 해주세요.", filedText: "목표 체중", variable: self.$targetWeight, BtnActivate: $BtnActivate)
            }
            
            if self.bodyInfoCurrentPage == 7{
                VStack{
                Text("평소 내 활동량은?")
                    .font(Font.custom(systemFont, size: 20))
                    .fontWeight(.bold)
                Picker(selection: $selectedColor, label: Text("하루에 얼마나 움직이시나요?")) {
                                ForEach(0 ..< dayActive.count) {
                                    Text(self.dayActive[$0])
                                }
                            }
                }
            }
            
            if self.bodyInfoCurrentPage == 8{
                GetBodyTextFieldPages(text: "원하시는 닉네임을 입력 해주세요.", filedText: "닉네임", variable: self.$nickName, BtnActivate: $BtnActivate)
            }
        }
    }
}


var getBodyInfoTotalPage = 8


