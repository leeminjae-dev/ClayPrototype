//
//  Main.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/07.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import ConfettiSwiftUI
import UserNotifications
import SwiftUIRefresh
import Kingfisher
struct HomeView: View {
   
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @EnvironmentObject var userData : UserData
    @EnvironmentObject var viewModel : SignAppViewModel
    
    @ObservedObject var datas = firebaseData
    @StateObject var homeViewModel = HomeViewModel()
    
    @AppStorage("userEmail") var userEmail = ""
    @AppStorage("firstPop") var firstPop = "0"
    @AppStorage("firstLaunch") var firstLaunch = "0"
    @AppStorage("userProfileImage") var userProfileImage : String = ""
    
    @Binding var isTabDiet : Bool
    @Binding var isTabSnackDiet : Bool
    @Binding var userImageURL : String
    
    @State var show : Bool = false

    
    init(isTabDiet : Binding<Bool>, isTabSnackDiet : Binding<Bool>, userImageURL : Binding<String>){
        
        UINavigationBar.appearance().tintColor = UIColor(Color.init("systemColor"))
       
        _isTabDiet = isTabDiet
        _isTabSnackDiet = isTabSnackDiet
        _userImageURL = userImageURL
        
    }
    
    var body: some View {
        ZStack{
            
                
            ConfettiCannon(counter: $homeViewModel.counter,num: 150, confettiSize : 10, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 270)
                .padding(.bottom, 140)
                .zIndex(2)
            /// 포인트 획득 시 폭죽
            
            GeometryReader{geometry in

                ZStack{
                    Image("background")
                        .resizable()
                        .frame(width: 390, height: 900, alignment: .center)
                        .opacity(0.1)
                        .zIndex(-1)
                    /// 배경 그라데이션
                  
                    if homeViewModel.showingPopup || homeViewModel.showingPointPopup || homeViewModel.showingFailPopup || homeViewModel.showingTimePopup || homeViewModel.showingHalfPointPopup{
                        
                        
                        if #available(iOS 15, *){
                            Rectangle()
                                .foregroundColor(Color.black.opacity(0.3))
                                .frame(width: 390, height: 900)
                                .zIndex(1)
                        }else{
                            Rectangle()
                                .foregroundColor(Color.black.opacity(0.3))
                                .frame(width: 390, height: .infinity)
                                .zIndex(1)
                        } /// 팝업 시 배경 어두워지는 사각형

                    }
                    ZStack{
                        
                        HomeNavigationBar()
                            .zIndex(2)
                        
                        ScrollView(showsIndicators: false){
                            ZStack{
                                VStack(spacing :10){
                                    if #available(iOS 15.0, *){
                                        Rectangle()
                                            .frame(width : 390, height : 160)
                                            .opacity(0)
                                    }else{
                                        Rectangle()
                                            .frame(width : 390, height : 180)
                                            .opacity(0)
                                    }/// 스크롤 뷰 위 공백 채워줄 안보이는 사각형
                                   
                                    TodayBanner()
                                        .frame(width: 377, height: 40, alignment: .center)
                                        .background(Color.white)
                                        .cornerRadius(15)
                                        .opacity(show ? 1 : 0)
                                        .offset(y: self.show ? 0 : 20)
                                        .animation(.easeOut.delay(0.1))
                                    /// 오늘 날짜 배너
                                    
                                    MyPointView(showingPopup: $homeViewModel.showingPopup)
                                        .padding(.bottom, 40)
                                        .frame(width: 377, height: 137, alignment: .center)
                                        .background(Color.white)
                                        .cornerRadius(15)
                                        .opacity(show ? 1 : 0)
                                        .offset(y: self.show ? 0 : 20)
                                        .animation(.easeOut.delay(0.2))
                                    /// 나의 포인트 배너
                                    
                                    HomeProfileView(userImageURL: $userImageURL)
                                        .padding([.trailing, .bottom], 5)
                                        .frame(width: 377, height: 85, alignment: .center)
                                        .background(Color.white)
                                        .cornerRadius(15)
                                        .opacity(show ? 1 : 0)
                                        .offset(y: self.show ? 0 : 20)
                                        .animation(.easeOut.delay(0.3))
                                   /// 프로필 배너
                                    
                                    HomeMealBannerView(isTabDiet: $isTabDiet, isTabSnackDiet: $isTabSnackDiet, showingTimePopup : $homeViewModel.showingTimePopup, morningTimeRemaining: $homeViewModel.morningTimeRemaining, launchTimeRemaining: $homeViewModel.launchTimeRemaining, dinnerTimeRemaining: $homeViewModel.dinnerTimeRemaining, isMorningTimeOver: $homeViewModel.isMorningTimeOver, isLaunchTimeOver: $homeViewModel.isLaunchTimeOver, isDinnerTimeOver: $homeViewModel.isDinnerTimeOver)
                                        .frame(width: 377, height: 337, alignment: .center)
                                        .background(Color.white)
                                        .cornerRadius(15)
                                        .opacity(show ? 1 : 0)
                                        .offset(y: self.show ? 0 : 20)
                                        .animation(.easeOut.delay(0.4))
                                        
                                    /// 아점저 식단 기록 배너
                                    
                                    Rectangle()
                                        .frame(width : 390, height : 140)
                                        .opacity(0)
                                    /// 스크롤 뷰 위 공백 채워줄 안보이는 사각형
                                }
                                
                            }
                           
                            //.padding(.top,90)
                           

                            .ignoresSafeArea()
                        }
                        
                        .position(x: geometry.size.width / 2, y: geometry.size.height/2)
                        
                    }
                   
                   
                  
                  
                }
                .background(Color.init("background"))
                .ignoresSafeArea()
                .navigationBarHidden(true)
                
                .popup(isPresented: $homeViewModel.showingPopup) {
                    
                   PointInfoPopup()
                       
                       }
                /// 나의 포인트 설명 팝업
                
                .popup(isPresented: $homeViewModel.showingTimePopup) {
                    
                   TimeInfoPopup()
                       
                       }
                /// 시간 표시 팝업
                
                .popup(isPresented: $homeViewModel.showingHalfPointPopup, dismissCallback: {
                    
                    datas.updatePoint(email: userEmail, archieveRate: String((Float(datas.dataToDisplay["archieveRate"] ?? "0") ?? 0) + 0.5))
                    
                    if datas.dataToDisplay["userPoint"] ?? "1" == "0" && (!(datas.completeList["completeMorning"] ?? false) && !(datas.completeList["completeLaunch"] ?? false) && !(datas.completeList["completeDinner"] ?? false)){
                        
                        datas.updateTargetArchieve(email: userEmail, targetArchieve: String((Float(datas.dataToDisplay["targetArchieve"] ?? "0") ?? 0) + 1))
                    }else{
                        
                        datas.updateTargetArchieve(email: userEmail, targetArchieve: String((Float(datas.dataToDisplay["targetArchieve"] ?? "0") ?? 0) + 1))
                        datas.updatePoint(email: userEmail, archieveRate: String((Float(datas.dataToDisplay["archieveRate"] ?? "0") ?? 0) + 0.5))
                    }
                    
                    datas.isCanGetPoint(email: userEmail, userPoint: "1")
                    
                }) {
                    GetHalfPointPopup(counter: $homeViewModel.counter)
                   
                       }
                /// 500 포인트 획득 팝업
                
                .popup(isPresented: $homeViewModel.showingPointPopup, dismissCallback: {
                    
                    if datas.dataToDisplay["userPoint"] ?? "1" == "0" && (!(datas.completeList["completeMorning"] ?? false) && !(datas.completeList["completeLaunch"] ?? false) && !(datas.completeList["completeDinner"] ?? false)){
                        
                        datas.updateTargetArchieve(email: userEmail, targetArchieve: String((Float(datas.dataToDisplay["targetArchieve"] ?? "0") ?? 0) + 1))
                    }else{
                        
                        datas.updateTargetArchieve(email: userEmail, targetArchieve: String((Float(datas.dataToDisplay["targetArchieve"] ?? "0") ?? 0) + 1))
                        datas.updatePoint(email: userEmail, archieveRate: String((Float(datas.dataToDisplay["archieveRate"] ?? "0") ?? 0) + 0.5))
                    }
                    
                    datas.updatePoint(email: userEmail, archieveRate: String((Int(datas.dataToDisplay["archieveRate"] ?? "0") ?? 0) + 1))
                    
                    
                    datas.isCanGetPoint(email: userEmail, userPoint: "1")
                    
                }) {
                    GetPointPopup(counter: $homeViewModel.counter)
                   
                       }
                /// 1000 포인드 획득 팝업
                
                .popup(isPresented: $homeViewModel.showingFailPopup, dismissCallback : {
                    
                    if datas.dataToDisplay["userPoint"] ?? "1" == "0" && (!(datas.completeList["completeMorning"] ?? false) && !(datas.completeList["completeLaunch"] ?? false) && !(datas.completeList["completeDinner"] ?? false)){
                        
                        datas.updateTargetArchieve(email: userEmail, targetArchieve: String((Float(datas.dataToDisplay["targetArchieve"] ?? "0") ?? 0) + 1))
                    }else{
                        
                        datas.updateTargetArchieve(email: userEmail, targetArchieve: String((Float(datas.dataToDisplay["targetArchieve"] ?? "0") ?? 0) + 1))
                        datas.updatePoint(email: userEmail, archieveRate: String((Float(datas.dataToDisplay["archieveRate"] ?? "0") ?? 0) + 0.5))
                    }
                   
                    datas.isCanGetPoint(email: userEmail, userPoint: "1")
                    
                }){
                   FailPopup()
                }
                /// 포인트 획득 실패 팝업
                
               
            }
           
          
        }
        .onAppear{
           
           
         
            show = true
            
            let docRef = Firestore.firestore().collection("UserData").document(userEmail).collection("Calendar").document(makeTodayDetail())
            docRef.getDocument { (document, error) in
                
                if let document = document, document.exists {
                   
                } else {
                   
                    datas.createCalnedar(email: userEmail, kcal: datas.dietKcal, date: makeTodayDetail(), level: "0")
                    
                }
            }
            
            if firstPop == "0"{
                homeViewModel.showingPopup = true
                firstPop = "1"
            }
            
            homeViewModel.morningTimeRemaining = (Int(datas.userTimeToDisPlay["userMorningTime"] ?? "9") ?? 9) * 3600 - homeViewModel.getTimeToSeconds()
            homeViewModel.launchTimeRemaining = (Int(datas.userTimeToDisPlay["userLaunchTime"] ?? "12") ?? 12) * 3600 - homeViewModel.getTimeToSeconds()
            homeViewModel.dinnerTimeRemaining = (Int(datas.userTimeToDisPlay["userDinnerTime"] ?? "18") ?? 18) * 3600 - homeViewModel.getTimeToSeconds()
            
            datas.apiCall(email: userEmail, data: "archieveRate")
            datas.apiCall(email: userEmail, data: "targetArchieve")
            datas.apiCall(email: userEmail, data: "userPoint")
            datas.apiCall(email: userEmail, data: "Kcal")
            datas.apiCall(email: userEmail, data: "nickName")
            datas.apiCall(email: userEmail, data: "archievePoint")

            datas.calendarCall(email: userEmail)
            datas.calendarkcalCall(email: userEmail)
            
            datas.KcalCall(email: userEmail, data: "morningKcal", meal: "Breakfast")
            datas.KcalCall(email: userEmail, data: "launchKcal", meal: "Launch")
            datas.KcalCall(email: userEmail, data: "dinnerKcal", meal: "Dinner")
            datas.KcalCall(email: userEmail, data: "snackKcal", meal: "Snack")
           

            datas.readCalendarData(email: userEmail)
            
            for data in datas.calendarData{
                homeViewModel.tasks.append(TaskMetaData(task: [

                    Task(title: "\(data.kcal) kcal")

                ], taskDate: dateToString(dateString: data.date), taskColor:levelToColor(level:data.level) ))
            }

          
        }
        .onReceive(timer){_ in
            
            datas.userTimeCall(email: userEmail, data: "userMorningTime")
            datas.userTimeCall(email: userEmail, data: "userLaunchTime")
            datas.userTimeCall(email: userEmail, data: "userDinnerTime")
            
            datas.homeCountCall(email: userEmail)
            
            homeViewModel.morningTimeRemaining = (Int(datas.userTimeToDisPlay["userMorningTime"] ?? "9") ?? 9) * 3600 - homeViewModel.getTimeToSeconds()
            homeViewModel.launchTimeRemaining = (Int(datas.userTimeToDisPlay["userLaunchTime"] ?? "12") ?? 12) * 3600 - homeViewModel.getTimeToSeconds()
            homeViewModel.dinnerTimeRemaining = (Int(datas.userTimeToDisPlay["userDinnerTime"] ?? "18") ?? 18) * 3600 - homeViewModel.getTimeToSeconds()
            
            delegate.Notification(morningTime: Int(datas.userTimeToDisPlay["userMorningTime"] ?? "9") ?? 9, morningMinute: 00, morningMent: "\(datas.dataToDisplay["nickName"] ?? "error")님, 아침은 드셨나요?\n오늘 하루도 화이팅이에요💪🏻", launchTime: Int(datas.userTimeToDisPlay["userLaunchTime"] ?? "12") ?? 12, launchMinute: 00, launchMent: "\(datas.dataToDisplay["nickName"] ?? "error")님, 점심시간이에요! \n평소보다 한 숟가락만 덜 먹어도 살은 쏙 빠진답니다💚", dinnerTime: Int(datas.userTimeToDisPlay["userDinnerTime"] ?? "18") ?? 18, dinnerMinute: 00, dinnerMent: datas.completeList["completeMorning"] ?? false == true && datas.completeList["completeLaunch"] ?? false == true ? "\(datas.dataToDisplay["nickName"] ?? "error")님,\n저녁식사하고 기록하셔서 1,000P 받으세요💰" : "\(datas.dataToDisplay["nickName"] ?? "error")님, 저녁까지 기록해주세요!\n오늘은 아쉽지만 내일은 모두 기록하고 환급받아요🌱")
            
        
            
            if homeViewModel.morningTimeRemaining < -7200{
                homeViewModel.isMorningTimeOver = true
            }
            if homeViewModel.launchTimeRemaining < -7200{
                homeViewModel.isLaunchTimeOver = true
            }
            if homeViewModel.dinnerTimeRemaining < -7200{
                
                homeViewModel.isDinnerTimeOver = true
                
            }
            
//            if  datas.dataToDisplay["userPoint"] ?? "1" == "0" && (!(datas.completeList["completeMorning"] ?? false) || !(datas.completeList["completeLaunch"] ?? false) || !(datas.completeList["completeDinner"] ?? false)){
//
//                homeViewModel.showingFailPopup = true
//            }
            
            if isMorning(){

                datas.isCanGetPoint(email: userEmail, userPoint: "1")
            }
            if isLaunch(){

                datas.isCanGetPoint(email: userEmail, userPoint: "1")
            }
            if isDinner(){

                datas.isCanGetPoint(email: userEmail, userPoint: "1")
            }
           
//            if datas.homeCountToDisPlay["homeCount"] ?? "1" == "0"{
//                delegate.diaryNotification(ment: "test")
//                print("test")
//            }
            
            
                
            
            
            if datas.dataToDisplay["userPoint"] ?? "1" == "0" && (!(datas.completeList["completeMorning"] ?? false) && !(datas.completeList["completeLaunch"] ?? false) && !(datas.completeList["completeDinner"] ?? false)){

                homeViewModel.showingFailPopup = true
                datas.isCanGetPoint(email: userEmail, userPoint: "1")
                /// 세번 다 실패한 경우
            }else{

                if datas.dataToDisplay["userPoint"] ?? "1" == "0" && datas.completeList["completeMorning"] ?? false && datas.completeList["completeLaunch"] ?? false && datas.completeList["completeDinner"] ?? false{

                    homeViewModel.showingPointPopup = true
                    datas.updateArchievePoint(email: userEmail, archievePoint: String((Int(datas.dataToDisplay["archievePoint"] ?? "0") ?? 0) + 1000))
                    datas.isCanGetPoint(email: userEmail, userPoint: "1")
                } /// 세번 다 성공한 경우
                
                else if datas.dataToDisplay["userPoint"] ?? "1" == "0" {
                    if isMorning(){
                        homeViewModel.showingHalfPointPopup = true
                        datas.updateArchievePoint(email: userEmail, archievePoint: String((Int(datas.dataToDisplay["archievePoint"] ?? "0") ?? 0) + 500))
                        datas.isCanGetPoint(email: userEmail, userPoint: "1")
                    }
                    if isLaunch() && (!(datas.completeList["completeMorning"] ?? false)){
                        
                        homeViewModel.showingHalfPointPopup = true
                        datas.updateArchievePoint(email: userEmail, archievePoint: String((Int(datas.dataToDisplay["archievePoint"] ?? "0") ?? 0) + 500))
                        datas.isCanGetPoint(email: userEmail, userPoint: "1")
                    }
                    
                   
                }/// 세번은 아니지만 한번 or 두번 성공한 경우



            }

           
            
        }
    }
    
    func isMorning() -> Bool{
        
        
                   let date = Date()
                   let calender = Calendar.current
                   let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
                   let hour = components.hour
        
                   let today_string = String(hour!)
                   
        if today_string == String(Int(datas.userTimeToDisPlay["userMorningTime"] ?? "9") ?? 9 + 2) || today_string == String(Int(datas.userTimeToDisPlay["userMorningTime"] ?? "9") ?? 9 + 1){
            return true
               }
        else{
            return false
        }

    }
    
    func isDinner() -> Bool{
        
                   let date = Date()
                   let calender = Calendar.current
                   let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
                   let hour = components.hour
        
                   let today_string = String(hour!)
                   
        if today_string == datas.userTimeToDisPlay["userDinnerTime"] ?? "18" || today_string == String(Int(datas.userTimeToDisPlay["userDinnerTime"] ?? "18") ?? 18 + 1){
            return true
               }
        else{
            return false
        }
        
    }
    
    func isLaunch() -> Bool{
       
        let date = Date()
       let calender = Calendar.current
       let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)

       let hour = components.hour

       let today_string = String(hour!)

        if today_string == datas.userTimeToDisPlay["userLaunchTime"] ?? "12" || today_string == String(Int(datas.userTimeToDisPlay["userLaunchTime"] ?? "12") ?? 12 + 1){
            return true
               }
        else{
            return false
        }

    }
    
    
    func timeString(time: Int) -> String {
        let hours   = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func getTimeToSeconds() -> Int{
        let date = Date()
       let calender = Calendar.current
       let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)

       let hour = components.hour
        let minute = components.minute
        let second = components.second

       return hour! * 60 * 60 + minute! * 60 + second!

    }
    
   
}



var dateFormatter: DateFormatter {
        let fmtr = DateFormatter()
        fmtr.dateFormat = "HH:mm:ss"
        return fmtr
}

func isMorning() -> Bool{
    @ObservedObject var datas = firebaseData
    
               let date = Date()
               let calender = Calendar.current
               let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    
               let hour = components.hour
    
               let today_string = String(hour!)
               
    if today_string == String((Int(datas.userTimeToDisPlay["userMorningTime"] ?? "9") ?? 9)) || today_string == String((Int(datas.userTimeToDisPlay["userMorningTime"] ?? "9") ?? 9) + 1){
        return true
           }
    else{
        return false
    }

}




func isLaunch() -> Bool{
    @ObservedObject var datas = firebaseData
    let date = Date()
   let calender = Calendar.current
   let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)

   let hour = components.hour

   let today_string = String(hour!)

    if today_string == String((Int(datas.userTimeToDisPlay["userLaunchTime"] ?? "12") ?? 12)) || today_string == String((Int(datas.userTimeToDisPlay["userLaunchTime"] ?? "12") ?? 12) + 1){
        return true
           }
    else{
        return false
    }

}

func isDinner() -> Bool{
    @ObservedObject var datas = firebaseData
               let date = Date()
               let calender = Calendar.current
               let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    
               let hour = components.hour
    
               let today_string = String(hour!)
               
    if today_string == String((Int(datas.userTimeToDisPlay["userDinnerTime"] ?? "18") ?? 18)) || today_string == String((Int(datas.userTimeToDisPlay["userDinnerTime"] ?? "18") ?? 18) + 1){
        return true
           }
    else{
        return false
    }
    
}






struct PullToRefresh: View {
    
    var coordinateSpaceName: String
    var onRefresh: ()->Void
    
    @State var needRefresh: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: .named(coordinateSpaceName)).midY > 50) {
                Spacer()
                    .onAppear {
                        needRefresh = true
                    }
            } else if (geo.frame(in: .named(coordinateSpaceName)).maxY < 10) {
                Spacer()
                    .onAppear {
                        if needRefresh {
                            needRefresh = false
                            onRefresh()
                        }
                    }
            }
            HStack {
                Spacer()
                if needRefresh {
                    ProgressView()
                } else {
                    Text("⬇️")
                }
                Spacer()
            }
        }.padding(.top, -50)
    }
}
