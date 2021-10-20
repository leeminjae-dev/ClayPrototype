//
//  HomeMealBannerView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/15.
//

import SwiftUI


struct HomeMealBannerView: View {
    
    @AppStorage("userEmail") var userEmail = ""

    @ObservedObject var datas = firebaseData
    
    @Binding var isTabDiet : Bool
    @Binding var isTabSnackDiet : Bool
    
    @Binding var showingTimePopup : Bool
    @State var morningKcal : String = "dinnerKcal"
    
    @Binding var morningTimeRemaining : Int
    @Binding var launchTimeRemaining : Int
    @Binding var dinnerTimeRemaining : Int
    
    @Binding var isMorningTimeOver : Bool
    @Binding var isLaunchTimeOver : Bool
    @Binding var isDinnerTimeOver : Bool
    
    var body: some View {
        VStack(spacing:15){
            HStack(spacing :0){
                Rectangle()
                    .frame(width: 2, height: 17)
                    .foregroundColor(Color.init("systemColor"))
                    .padding(.bottom, 1)
                Text("오늘의 식단")
                    .font(Font.custom(systemFont, size: 17))
                    .fontWeight(.bold)
                    .padding(.leading, 7)
              
                Spacer()
                Button(action:{
                    showingTimePopup = true
                }, label:{
                    Image(systemName: "questionmark.circle")
                        .padding(.trailing, 20)
                        .foregroundColor(Color.init("darkGreen"))
                })
                   
            }
            .padding(.leading)
           
            VStack(spacing : 15){
                if morningTimeRemaining < 0{
                    if isMorningTimeOver{
                        if datas.completeList["completeMorning"] ?? false{
                            CantWriteBanner(MealText : "아침", mealKcal: "morningKcal", bannerColor: Color.init("systemColor"), centerImage: "checkmark.circle")
                            //아침 시간 지나고 성공
                        }else{
                            CantWriteBanner(MealText : "아침", mealKcal: "morningKcal", bannerColor: Color.gray.opacity(0.4), centerImage: "multiply.circle")
                            //아침 시간 지나고 실패
                        }
                    }else{
                        if datas.completeList["completeMorning"] ?? false{
                            CanWriteBanner(MealText : "아침", mealKcal: "morningKcal", bannerColor: Color.init("systemColor"), centerImage: "", fontColor: Color.white,isTabDiet: $isTabDiet)
                                .shadow(color: Color.black.opacity(0.5), radius: 3, y:3 )
                            // 아침 칼로리 기입 후
                        }else{
                            CanWriteBanner(MealText : "아침", mealKcal: "morningKcal", bannerColor: Color.init("lockedColor"), centerImage: "",isTabDiet: $isTabDiet)
                                .shadow(color: Color.init("shadowColor").opacity(0.68), radius: 3, y:3 )
                            // 아침 칼로리 기입 전
                        }
                        
                    }
                    
                }else{
                    TimerBanner(MealText : "아침", timeRemaining: $morningTimeRemaining)
                        
                    //아침 타이머
                }
                   
                if launchTimeRemaining < 0{
                    if isLaunchTimeOver{
                        if datas.completeList["completeLaunch"] ?? false{
                            CantWriteBanner(MealText : "점심", mealKcal: "launchKcal", bannerColor: Color.init("systemColor"), centerImage: "checkmark.circle")
                            //점심 시간 지나고 성공
                        }else{
                            CantWriteBanner(MealText : "점심", mealKcal: "launchKcal", bannerColor: Color.gray.opacity(0.4), centerImage: "multiply.circle")
                            //점심 시간 지나고 실패
                        }
                    }else{
                        if datas.completeList["completeLaunch"] ?? false{
                            CanWriteBanner(MealText : "점심", mealKcal: "launchKcal", bannerColor: Color.init("systemColor"), centerImage: "", fontColor: Color.white,isTabDiet: $isTabDiet)
                                .shadow(color: Color.black.opacity(0.5), radius: 3, y:3 )
                            // 점심 칼로리 기입 후
                        }else{
                            CanWriteBanner(MealText : "점심", mealKcal: "launchKcal", bannerColor: Color.init("lockedColor"), centerImage: "",isTabDiet: $isTabDiet)
                                .shadow(color: Color.init("shadowColor").opacity(0.68), radius: 3, y:3 )
                            // 점심 칼로리 기입 전
                        }
                        
                    }
                    
                }else{
                    TimerBanner(MealText : "점심", timeRemaining: $launchTimeRemaining)
                   
                        
                    //점심 타이머
                }
                   
                    
                if dinnerTimeRemaining < 0{
                    if isDinnerTimeOver{
                        if datas.completeList["completeDinner"] ?? false{
                            CantWriteBanner(MealText : "저녁", mealKcal: "dinnerKcal", bannerColor: Color.init("systemColor"), centerImage: "checkmark.circle")
                            //저녁 시간 지나고 성공
                        }else{
                            CantWriteBanner(MealText : "저녁", mealKcal: "dinnerKcal", bannerColor: Color.gray.opacity(0.4), centerImage: "multiply.circle")
                            //저녁 시간 지나고 실패
                        }
                    }else{
                        if datas.completeList["completeDinner"] ?? false{
                            CanWriteBanner(MealText : "저녁", mealKcal: "dinnerKcal", bannerColor: Color.init("systemColor"), centerImage: "", fontColor: Color.white, isTabDiet: $isTabDiet)
                                .shadow(color: Color.black.opacity(0.5), radius: 3, y:3 )
                            // 저녁 칼로리 기입 후
                        }else{
                            CanWriteBanner(MealText : "저녁", mealKcal: "dinnerKcal", bannerColor: Color.init("lockedColor"), centerImage: "",isTabDiet: $isTabDiet)
                                .shadow(color: Color.init("shadowColor").opacity(0.68), radius: 3, y:3 )
                            // 저녁 칼로리 기입 전
                        }
                        
                    }
                    
                }else{
                    TimerBanner(MealText : "저녁", timeRemaining: $dinnerTimeRemaining)
                        
                    //저녁 타이머
                }
                   
                HStack{
                    Spacer()
                    if datas.kcalToDisplay["snackKcal"] ?? 0 != 0{

                            Button(
                                action: {isTabSnackDiet = true},
                                label: {
                                    HStack{
                                      
                                        Text("간식")
                                            .font(Font.custom(systemFont, size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.black)
                                            .padding(.top, 2)
                                            .padding(.trailing, 3)
                                        ZStack{
                                            Image(systemName: "plus")
                                                .foregroundColor(Color.white)
                                                .frame(width: 20, height: 20)
                                                .zIndex(1)
                                            Circle()
                                                .frame(width: 22, height: 22)
                                                .foregroundColor(Color.init("systemColor"))
                                                .shadow(color: Color.init("shadowColor").opacity(0.68), radius: 3, y:3)
                                        }
            
                                    }
       
                                }) /// 간식 기입 후
                        
                        
                    }else{
                            Button(
                                action: {
                                    
                                    isTabSnackDiet = true

                                },
                                label: {
                                    HStack{

                                        Text("간식")
                                            .font(Font.custom(systemFont, size: 14))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.black)
                                            .padding(.top, 2)
                                        ZStack{
                                            Image(systemName: "plus")
                                                .foregroundColor(Color.black)
                                                .frame(width: 20, height: 20)
                                                .zIndex(1)
                                            Circle()
                                                .frame(width: 22, height: 22)
                                                .foregroundColor(Color.init("lockedColor"))
                                                .shadow(color: Color.init("shadowColor").opacity(0.68), radius: 2, y:2)
                                        }
                                            
                                    }
                                   
                                })        
                    }
                    
                }
                .padding(.trailing,25)
            }
            .padding(.top,1)
         
           
        }
        .onAppear{
            datas.isCompleteCall(email: userEmail, data: "completeMorning", meal: "Breakfast")
            datas.isCompleteCall(email: userEmail, data: "completeLaunch", meal: "Launch")
            datas.isCompleteCall(email: userEmail, data: "completeDinner", meal: "Dinner")
            
            datas.userTimeCall(email: userEmail, data: "userMorningTime")
            datas.userTimeCall(email: userEmail, data: "userLaunchTime")
            datas.userTimeCall(email: userEmail, data: "userDinnerTime")
            
            
        }
        
      
    }
}

struct HomeMealBannerView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMealBannerView(isTabDiet: .constant(false), isTabSnackDiet: .constant(false), showingTimePopup: .constant(false), morningTimeRemaining: .constant(0), launchTimeRemaining: .constant(0), dinnerTimeRemaining: .constant(0), isMorningTimeOver: .constant(false), isLaunchTimeOver: .constant(false), isDinnerTimeOver: .constant(false))
    }
}
