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

struct HomeView: View {
    @State var timeNow = ""
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @EnvironmentObject var userData : UserData
    @EnvironmentObject var viewModel : SignAppViewModel
    
    @ObservedObject var datas = firebaseData
    @State var isShowing : Bool = false
    @AppStorage("userEmail") var userEmail = ""
    @AppStorage("firstPop") var firstPop = "0"
    @AppStorage("firstLaunch") var firstLaunch = "0"
    @AppStorage("userProfileImage") var userProfileImage : String = ""
    
    @State private var morningTime : Bool = false
    
    
    @State private var launchTime : Bool = false
   
    ///var dinnerTime : Bool = isDinner()
    @State private var dinnerTime : Bool = false
    
    /// 시간에 따라 잠금장치가 걸릴지 안걸릴지 판별
    @State var show : Bool = false
    @State var isUnlocked : Bool = true
    
    @State var morningTimeRemaining = 0
    @State var launchTimeRemaining = 0
    @State var dinnerTimeRemaining = 0
    
    @Binding var isTabDiet : Bool
    @Binding var isTabSnackDiet : Bool
    @State var counter:Int = 0

    @State var showingPointPopup : Bool = false
    @State var showingFailPopup : Bool = false
    @State var showingPopup : Bool = false
    @State var showingTimePopup : Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    @State var isMorningTimeOver : Bool = false
    @State var isLaunchTimeOver : Bool = false
    @State var isDinnerTimeOver : Bool = false
    
    @State var isConfetti : Bool = false
    
  
    @State var homeCount = 0
    @State var endToday : Bool = false
    
    @State var tasks: [TaskMetaData] = []
    @State var currentDate: Date = Date()
    
    @State var imageURL : String = ""
    
    @State var minute : Int = 0
    @Binding var userImageURL : String 
    @State var shownProfileImage : Bool = false
    init(isTabDiet: Binding<Bool>, isTabSnackDiet : Binding<Bool>, userImageURL : Binding<String>){
        
        UINavigationBar.appearance().tintColor = UIColor(Color.init("systemColor"))
       _isTabDiet = isTabDiet
        _isTabSnackDiet = isTabSnackDiet
        _userImageURL = userImageURL
    }
    
    var body: some View {
        ZStack{
            
                
            ConfettiCannon(counter: $counter,num: 130, confettiSize : 10, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 270)
                .padding(.bottom, 140)
                .zIndex(2)
            GeometryReader{geometry in

                ZStack{
                    Image("background")
                        .resizable()
                        .frame(width: 390, height: 900, alignment: .center)
                        .opacity(0.1)
                        .zIndex(-1)
                    VStack{
                        Text("1000 포인트가 환급되었어요!")
                            .font(Font.custom(systemFont, size: 15))
                            .frame(width: 250, height: 100)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.gray, radius: 1)
                            .opacity(isConfetti ? 1 : 0)
                            
                    } .transition(.opacity)
                        .animation(.easeInOut(duration: 0.1))
                        .zIndex(1.5)
                    
                  
                    if showingPopup || showingPointPopup || showingFailPopup || showingTimePopup{
                        
                        
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
                        }
                            
                           
                          
                    }
                    ZStack{
                        ZStack{
        
                            BlurView(effect: .systemUltraThinMaterialLight)
                                .frame(width: 400, height: 100, alignment: .top)
                                .ignoresSafeArea()
                            
                            HStack{
                                Text("CLAY")
                                    .foregroundColor(Color.init("systemColor"))
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .font(Font.custom(systemFont, size: 25))
                                   
                                    .padding(.leading, 150)
                                    .padding(.top,30)
                                Spacer()
                                VStack{
                                    HStack(spacing : 15){
                                       
                                        NavigationLink(
                                            destination: CustomDatePicker(currentDate: $currentDate, tasks : $tasks),
                                            label: {
                                                ZStack{
                                                    Rectangle()
                                                        .frame(width: 40, height: 40)
                                                        .opacity(0)
                                                        .zIndex(1)
                                                    Image(systemName: "calendar")
                                                        .resizable()
                                                        .frame(width:23, height: 23, alignment: .center)
                                                        .foregroundColor(Color.init("systemColor"))
                                                }
                                                
                                            }
                                        )
                                        
                                        
                                      
                                    }.padding(.trailing, 5)
                                    
                                   
                                }
                                .padding(.top,30)
                                
                               
                               
                            
                            }
                            .padding(20)
                          
                            .zIndex(1)
                        }
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 14)
                            .zIndex(1)
                      
                       
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
                                    }
                                   
                                    TodayBanner()
                                        .frame(width: 377, height: 40, alignment: .center)
                                        .background(Color.white)
                                        .cornerRadius(15)
                                        .opacity(show ? 1 : 0)
                                        .offset(y: self.show ? 0 : 20)
                                        .animation(.easeOut.delay(0.2))
                                    
                                    VStack(spacing : 3){
                                        
                                        HStack(spacing : 0){
                                            Rectangle()
                                                .frame(width: 2, height: 17)
                                                .foregroundColor(Color.init("systemColor"))
                                                .padding(.bottom, 1)
                                            
                                            Text("나의 포인트")
                                                .font(Font.custom(systemFont, size: 17))
                                                .fontWeight(.bold)
                                                .padding(.leading, 7)
                                           
                                            Text(timeNow)
                                                .foregroundColor(Color.white)
                                                .onReceive(timer) { _ in
                                                        self.timeNow = dateFormatter.string(from: Date())
                                                }
                                            Spacer()
                                            Button(action: {
                                                showingPopup.toggle()
                                            }, label: {
                                                Image(systemName: "questionmark.circle")
                                                    .foregroundColor(Color.init("darkGreen"))
                                                    .padding(.trailing, 5)
                                            })
                                            
                                        }.padding([.leading, .top,.trailing])
                                            .padding(.top,25)
                                            
                                           
                                       
                                        VStack(spacing : 0){
                                            
                                            HStack(spacing: 0){
                                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                                    ZStack{
                                                        Image(systemName: "lightbulb")
                                                            .resizable()
                                                            .frame(width: 8, height: 13, alignment: .center)
                                                            .foregroundColor(.black)
                                                            .zIndex(1)
                                                        Circle()
                                                            .foregroundColor(Color.init("bulbYellow"))
                                                            .frame(width: 15, height: 15, alignment: .center)
                                                    }
                                                })
                                               
                                                Text("포인트 전환율을 올려보세요!")
                                                    .font(Font.custom(systemFont, size: 10))
                                                    .fontWeight(.light)
                                                    .padding(.leading, 3)
                                                 Spacer()
                                            }
                                            .padding(.leading, 15)
                                            .padding(.top, 7)
                                            
                                            
                                            
                                            GeometryReader { geometry in
                                                ZStack(alignment: .leading) {
                                                    
                                                    Text("\(Int(datas.dataToDisplay["targetArchieve"]!)! * 1000)")
                                                        .opacity(0)
                                                        .padding(.trailing)
                                                        .font(Font.custom(systemFont, size: 15))
                                                        .foregroundColor(Color.white)
                                                        .zIndex(2)
                                                        .frame(width: min(CGFloat(Float(datas.dataToDisplay["targetArchieve"]!)! * 0.033333333333333333333)*geometry.size.width, geometry.size.width), height: geometry.size.height,alignment: .trailing)
                                                        .cornerRadius(45)
                                                        .background(Color.init("targetArchieveColor"))
                                                        .animation(.linear)
                                                        .cornerRadius(45.0)
                                                        .zIndex(2)
                                                    
                                                    Text("\(Int(datas.dataToDisplay["archieveRate"]!)!*1000)")
                                                        .opacity(0)
                                                        .padding(.trailing)
                                                        .font(Font.custom(systemFont, size: 15))
                                                        .foregroundColor(Color.white)
                                                        .zIndex(3)
                                                        .frame(width: min(CGFloat(Float(datas.dataToDisplay["archieveRate"]!)! * 0.03333333)*geometry.size.width, geometry.size.width), height: geometry.size.height,alignment: .trailing)
                                                        .cornerRadius(45)
                                                        .background(Color.init("systemColor"))
                                                        .animation(.linear)
                                                        .cornerRadius(45.0)
                                                        .zIndex(3)
                                                    
                                                    Capsule()
                                                        .frame(width: geometry.size.width , height: geometry.size.height)
                                                        .opacity(0.3)
                                                        .foregroundColor(Color("systemColor"))
                                                        .zIndex(1)
                                                    
                                                }
                                                .cornerRadius(45.0)
                                               
                                            }
                                            .frame(width:345, height: 35)
                                            .padding(.top,8)
                                        }
                                        HStack(spacing : 10){
                                            Spacer()
                                            HStack{
                                                Circle()
                                                    .fill(Color.init("systemColor"))
                                                    .frame(width: 8,height: 8)
                                                Text("환급 받은 포인트")
                                                    .font(Font.custom(systemFont, size: 10))
                                            }
                                            HStack{
                                                Circle()
                                                    .fill(Color.init("targetArchieveColor"))
                                                    .frame(width: 8,height: 8)
                                                Text("예상 환급 포인트")
                                                    .font(Font.custom(systemFont, size: 10))
                                            }
                                            
                                        }
                                        .padding(.trailing, 20)
                                        .padding(.top, 10)
                                        
                                    }
                                    .padding(.bottom, 40)
                                    .frame(width: 377, height: 137, alignment: .center)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .opacity(show ? 1 : 0)
                                    .offset(y: self.show ? 0 : 20)
                                    .animation(.easeOut.delay(0.3))
                                    
                                    HStack(spacing: 5){
                                        ZStack{
                                            if userImageURL != ""{

                                                FirebaseProfileImageView(imageURL: userImageURL)
                                                    .frame(width : 65, height : 65)
                                                    .clipShape(Circle())
                                                    .padding(.trailing, 12)
                                                    .padding(.top, 7)
                                                    

                                            }else{
                                                ZStack{
                                                    Image(systemName : "person")
                                                        .resizable()
                                                        .frame(width: 30, height: 30)
                                                        .foregroundColor(Color.black)
                                                        
                                                        .multilineTextAlignment(.center)
                                                        .padding(.trailing, 13)
                                
                                                    Circle()
                                                        .foregroundColor(Color.gray.opacity(0.7))
                                                        .frame(width : 65, height : 65)
                                                        .padding(.trailing, 12)
                                                    
                                                }
                                              
                                            }
                                            
                                            
                                        }
                                       
                                        HStack(spacing : 5){
                                            Text("\(datas.dataToDisplay["nickName"]!)님은 오늘")
                                                .font(Font.custom(systemFont, size: 13))
                                            Text("\(Float(datas.dataToDisplay["Kcal"]!)! - datas.kcalToDisplay["morningKcal"]! - datas.kcalToDisplay["launchKcal"]! - datas.kcalToDisplay["dinnerKcal"]! - datas.kcalToDisplay["snackKcal"]!, specifier: "%.0f")Kcal")
                                                .font(Font.custom(systemFont, size: 13))
                                                .fontWeight(.bold)
                                                .frame(height: 6, alignment: .bottom)
                                                .background(Color.init("systemColor").opacity(0.5))
                                                .padding(.top,10)
                                            Text("만큼 먹을 수 있어요")
                                                .font(Font.custom(systemFont, size: 13))
                                        }.padding(.top, 5)

                                    }
                                    .padding([.trailing, .bottom], 5)
                                    
                                    
                                    .frame(width: 377, height: 85, alignment: .center)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .opacity(show ? 1 : 0)
                                    .offset(y: self.show ? 0 : 20)
                                    .animation(.easeOut.delay(0.4))
                                   
                                    
                                    
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
                                            if morningTime || self.isMorning(){
                                                if datas.kcalToDisplay["morningKcal"]! != 0{
                                                    Button(
                                                        action: {isTabDiet = true},
                                                        label: {
                                                            HStack{
                                                                Text("아침")
                                                                    .foregroundColor(Color.white)
                                                                    .font(Font.custom(systemFont, size: 15))
                                                                    .padding(.leading,30)
                                                                Spacer()
                                                                
                                                                ///Text("\(today,formatter: MealBanner.dateFormat)")
                                                                
                                                                
                                                                Spacer()
                                                                
                                                                HStack{
                                                                    Text("\(datas.kcalToDisplay["morningKcal"]!,specifier: "%.0f")")
                                                                        .foregroundColor(Color.white)
                                                                        .fontWeight(.black)
                                                                        .font(Font.custom(systemFont, size: 20))
                                                                    Text("Kcal")
                                                                        .foregroundColor(Color.white)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        
                                                                    }
                                                                    .padding(.trailing)
                                                                    
                                                                    
                                                                    }
                                                            
                                                                    .frame(width: 345, height: 70)
                                                                    .background(Color.init("systemColor"))
                                                                    .cornerRadius(60)
                                                                    .shadow(color: Color.init("shadowColor").opacity(0.68), radius: 3, y:3 )
                                                        })//아침 기입 후
                                                        
                                                }else{
                                                    Button(
                                                        action: {isTabDiet = true},
                                                        label: {
                                                            HStack{
                                                                Text("아침")
                                                                    .foregroundColor(Color.black)
                                                                    .font(Font.custom(systemFont, size: 15))
                                                                    .padding(.leading,30)
                                                                Spacer()
                                                                
                                                                ///Text("\(today,formatter: MealBanner.dateFormat)")
                                                                
                                                                
                                                                Spacer()
                                                                
                                                                HStack{
                                                                    Text("\(datas.kcalToDisplay["morningKcal"]!,specifier: "%.0f")")
                                                                        .foregroundColor(Color.black)
                                                                        .fontWeight(.black)
                                                                        .font(Font.custom(systemFont, size: 20))
                                                                    Text("Kcal")
                                                                        .foregroundColor(Color.black)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        
                                                                    }
                                                                    .padding(.trailing)
                                                                    
                                                                    
                                                                    }
                                                            
                                                                    .frame(width: 345, height: 70)
                                                                    .background(Color.init("lockedColor"))
                                                                    .cornerRadius(60)
                                                                    .shadow(color: Color.black.opacity(0.4), radius: 6, y:3 )
                                                        })//아침 기입 전
                                                        
                                                }
                                            
                                            }
                                            
                                                else{
                                                    if datas.completeList["completeMorning"]!{
                                                        
                                                        
                                                        ZStack{
                                                            Image(systemName: "checkmark.circle")
                                                                .resizable()
                                                            
                                                                .foregroundColor(Color.white)
                                                                .frame(width: 15, height: 15)
                                                                .zIndex(1)
                                                            HStack{
                                                                Text("아침")
                                                                    .foregroundColor(Color.white)
                                                                    .font(Font.custom(systemFont, size: 15))
                                                                    .padding(.leading,30)
                                                                Spacer()
                                                                
                                                                ///Text("\(today,formatter: MealBanner.dateFormat)")
                                                                
                                                                
                                                                Spacer()
                                                                
                                                                HStack{
                                                                    Text("\(datas.kcalToDisplay["morningKcal"]!,specifier: "%.0f")")
                                                                        .foregroundColor(Color.white)
                                                                        .fontWeight(.black)
                                                                        .font(Font.custom(systemFont, size: 20))
                                                                    Text("Kcal")
                                                                        .foregroundColor(Color.white)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        
                                                                    }
                                                                    .padding(.trailing)
                                                                    
                                                                    
                                                                    }
                                                            
                                                                    .frame(width: 345, height: 70)
                                                                    .background(Color.init("systemColor"))
                                                                    .cornerRadius(60)
                                                                    
                                                        }//아침 시간 지나고 성공
                                                        
                                                    }
                                                    else{
                                                        if isMorningTimeOver{
                                                            ZStack{
                                                                Image(systemName: "multiply.circle")
                                                                    .resizable()
                                                                    .foregroundColor(Color.white)
                                                                    .frame(width: 15, height: 15)
                                                                    .zIndex(1)
                                                                HStack{
                                                                        Text("아침")
                                                                        .foregroundColor(Color.gray)
                                                                            .fontWeight(.bold)
                                                                            .font(Font.custom(systemFont, size: 15))
                                                                            .padding(.leading,30)
                                                                    Spacer()
                                                                    
                                                                    
                                                                    Spacer()
                                                                    HStack{
                                                                       
                                                                        Text("Kcal")
                                                                            .foregroundColor(Color.gray)
                                                                            .fontWeight(.semibold)
                                                                            .font(Font.custom(systemFont, size: 15))
                                                                            
                                                                        }
                                                                    .padding(.trailing)
                                                                        
                                                                        
                                                                        }
                                                                
                                                                        .frame(width: 345, height: 70)
                                                                        .background(Color.gray.opacity(0.4))
                                                                        .cornerRadius(60)
                                                                        
                                                            }//아침 시간 지나고 실패
                                                           
                                                        }else{
                                                            HStack{
                                                                    Text("아침")
                                                                    .foregroundColor(Color.gray)
                                                                        .fontWeight(.bold)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        .padding(.leading,30)
                                                                Spacer()
                                                                
                                                                Image(systemName: "alarm")
                                                                    .foregroundColor(Color.init("timeColor"))
                                                                Text("\(timeString(time: morningTimeRemaining))")
                                                                    .fontWeight(.bold)
                                                                    .font(Font.custom(systemFont, size: 15))
                                                                    .foregroundColor(Color.init("timeColor"))
                                                                    .padding(.trailing, 15)
                                                                Spacer()
                                                                HStack{
                                                                   
                                                                    Text("Kcal")
                                                                        .foregroundColor(Color.gray)
                                                                        .fontWeight(.semibold)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        
                                                                    }
                                                                .padding(.trailing)
                                                                    
                                                                    
                                                                    }
                                                            
                                                                    .frame(width: 345, height: 70)
                                                                    .background(Color.init("lockedColor"))
                                                                    .cornerRadius(60)
                                                        }/// 아침 시간 지나기 전
                                                        
                                                    }
                                                    
                                                           
                                                }
                                               
                                            if launchTime || isLaunch(){
                                                
                                                if datas.kcalToDisplay["launchKcal"]! != 0{
                                                    Button(
                                                        
                                                        action: {isTabDiet = true},
                                                        label: {
                                                            HStack{
                                                                Text("점심")
                                                                    .foregroundColor(Color.white)
                                                                    .font(Font.custom(systemFont, size: 15))
                                                                    .padding(.leading,30)
                                                                Spacer()
                                                                
                                                                ///Text("\(today,formatter: MealBanner.dateFormat)")
                                                                
                                                                
                                                                Spacer()
                                                                
                                                                HStack{
                                                                    Text("\(datas.kcalToDisplay["launchKcal"]!,specifier: "%.0f")")
                                                                        .foregroundColor(Color.white)
                                                                        .fontWeight(.black)
                                                                        .font(Font.custom(systemFont, size: 20))
                                                                    Text("Kcal")
                                                                        .foregroundColor(Color.white)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        
                                                                    }
                                                                    .padding(.trailing)
                                                                    
                                                                    
                                                                    }
                                                            
                                                                    .frame(width: 345, height: 70)
                                                                    .background(Color.init("systemColor"))
                                                                    .cornerRadius(60)
                                                                    .shadow(color: Color.init("shadowColor").opacity(0.68), radius: 3, y:3 )
                                                        }) /// 점심 기입 후
                                                }else{
                                                    Button(
                                                        action: {isTabDiet = true},
                                                        label: {
                                                            HStack{
                                                                Text("점심")
                                                                    .foregroundColor(Color.black)
                                                                    .font(Font.custom(systemFont, size: 15))
                                                                    .padding(.leading,30)
                                                                Spacer()
                                                                
                                                                ///Text("\(today,formatter: MealBanner.dateFormat)")
                                                                
                                                                
                                                                Spacer()
                                                                
                                                                HStack{
                                                                    Text("\(datas.kcalToDisplay["launchKcal"]!,specifier: "%.0f")")
                                                                        .foregroundColor(Color.black)
                                                                        .fontWeight(.black)
                                                                        .font(Font.custom(systemFont, size: 20))
                                                                    Text("Kcal")
                                                                        .foregroundColor(Color.black)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        
                                                                    }
                                                                    .padding(.trailing)
                                                                    
                                                                    
                                                                    }
                                                            
                                                                    .frame(width: 345, height: 70)
                                                                    .background(Color.init("lockedColor"))
                                                                    .cornerRadius(60)
                                                                    .shadow(color: Color.black.opacity(0.3), radius: 6, y:3 )
                                                        })
                                                } /// 점심 기입 전
                                               
                                                    
                                            }
                                            
                                                else{
                                                    if datas.completeList["completeLaunch"]!{
                                                        ZStack{
                                                            Image(systemName: "checkmark.circle")
                                                                .resizable()
                                                                .foregroundColor(Color.white)
                                                                .frame(width: 15, height: 15)
                                                                .zIndex(1)
                                                            HStack{
                                                                Text("점심")
                                                                    .foregroundColor(Color.white)
                                                                    .font(Font.custom(systemFont, size: 15))
                                                                    .padding(.leading,30)
                                                                Spacer()
                                                                
                                                                ///Text("\(today,formatter: MealBanner.dateFormat)")
                                                                
                                                           
                                                                Spacer()
                                                                
                                                                HStack{
                                                                    Text("\(datas.kcalToDisplay["launchKcal"]!,specifier: "%.0f")")
                                                                        .foregroundColor(Color.white)
                                                                        .fontWeight(.black)
                                                                        .font(Font.custom(systemFont, size: 20))
                                                                    Text("Kcal")
                                                                        .foregroundColor(Color.white)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        
                                                                    }
                                                                    .padding(.trailing)
                                                                    
                                                                    
                                                                    }
                                                            
                                                                    .frame(width: 345, height: 70)
                                                                    .background(Color.init("systemColor"))
                                                                    .cornerRadius(60)
                                                                    
                                                        }
                                                       
                                                    } /// 점심 시간 지나고 성공
                                                    else{
                                                        if isLaunchTimeOver{
                                                            ZStack{
                                                                Image(systemName: "multiply.circle")
                                                                    .resizable()
                                                                    .foregroundColor(Color.white)
                                                                    .frame(width: 15, height: 15)
                                                                    .zIndex(1)
                                                                HStack{
                                                                    
                                                                        Text("점심")
                                                                        .foregroundColor(Color.gray)
                                                                            .fontWeight(.bold)
                                                                            .font(Font.custom(systemFont, size: 15))
                                                                            .padding(.leading,30)
                                                                    Spacer()
                                                                    
                                                                   
                                                                    Spacer()
                                                                    HStack{
                                                                       
                                                                        Text("Kcal")
                                                                            .foregroundColor(Color.gray)
                                                                            .fontWeight(.semibold)
                                                                            .font(Font.custom(systemFont, size: 15))
                                                                            
                                                                        }
                                                                    .padding(.trailing)
                                                                        
                                                                        
                                                                        }
                                                                
                                                                        .frame(width: 345, height: 70)
                                                                        .background(Color.gray.opacity(0.4))
                                                                        .cornerRadius(60)
                                                                       
                                                            } // 점심 시간 지나고 실패
                                                           
                                                        }else{
                                                            HStack{
                                                                    Text("점심")
                                                                    .foregroundColor(Color.gray)
                                                                        .fontWeight(.bold)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        .padding(.leading,30)
                                                                Spacer()
                                                                
                                                                Image(systemName: "alarm")
                                                                    .foregroundColor(Color.init("timeColor"))
                                                                Text("\(timeString(time: launchTimeRemaining))")
                                                                    .fontWeight(.bold)
                                                                    .font(Font.custom(systemFont, size: 15))
                                                                    .foregroundColor(Color.init("timeColor"))
                                                                    .padding(.trailing, 15)
                                                                Spacer()
                                                                HStack{
                                                                   
                                                                    Text("Kcal")
                                                                        .foregroundColor(Color.gray)
                                                                        .fontWeight(.semibold)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        
                                                                    }
                                                                .padding(.trailing)
                                                                    
                                                                    
                                                                    }
                                                            
                                                                    .frame(width: 345, height: 70)
                                                                    .background(Color.init("lockedColor"))
                                                                    .cornerRadius(60)
                                                        }/// 점심 시간 지나기 전
                                                        
                                                    }
                                                    
                                                           
                                                }
                                                
                                            if dinnerTime || self.isDinner(){
                                                if datas.kcalToDisplay["dinnerKcal"]! != 0{
                                                    Button(
                                                        action: {isTabDiet = true},
                                                        label: {
                                                            
                                                            HStack{
                                                                Text("저녁")
                                                                    .foregroundColor(Color.white)
                                                                    .font(Font.custom(systemFont, size: 15))
                                                                    .padding(.leading,30)
                                                                Spacer()
                                                                
                                                                ///Text("\(today,formatter: MealBanner.dateFormat)")
                                                                
                                                                
                                                                Spacer()
                                                                
                                                                HStack{
                                                                    Text("\(datas.kcalToDisplay["dinnerKcal"]!,specifier: "%.0f")")
                                                                        .foregroundColor(Color.white)
                                                                        .fontWeight(.black)
                                                                        .font(Font.custom(systemFont, size: 20))
                                                                    Text("Kcal")
                                                                        .foregroundColor(Color.white)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        
                                                                    }
                                                                    .padding(.trailing)
                                                                    
                                                                    
                                                                    }
                                                            
                                                                    .frame(width: 345, height: 70)
                                                                    .background(Color.init("systemColor"))
                                                                    .cornerRadius(60)
                                                                    .shadow(color: Color.init("shadowColor").opacity(0.68), radius: 3, y:3 )
                                                        }) /// 저녁 기입 후
                                                }else{
                                                    Button(
                                                        action: {
                                                            isTabDiet = true
                                                           
                                                            
                                                        },
                                                        label: {
                                                            
                                                            HStack{
                                                                Text("저녁")
                                                                    .foregroundColor(Color.black)
                                                                    .font(Font.custom(systemFont, size: 15))
                                                                    .padding(.leading,30)
                                                                Spacer()
                                                                
                                                                ///Text("\(today,formatter: MealBanner.dateFormat)")
                                                                
                                                                
                                                                Spacer()
                                                                
                                                                HStack{
                                                                    Text("\(datas.kcalToDisplay["dinnerKcal"]!,specifier: "%.0f")")
                                                                        .foregroundColor(Color.black)
                                                                        .fontWeight(.black)
                                                                        .font(Font.custom(systemFont, size: 20))
                                                                    Text("Kcal")
                                                                        .foregroundColor(Color.black)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        
                                                                    }
                                                                    .padding(.trailing)
                                                                    
                                                                    
                                                                    }
                                                            
                                                                    .frame(width: 345, height: 70)
                                                                    .background(Color.init("lockedColor"))
                                                                    .cornerRadius(60)
                                                                    .shadow(color: Color.black.opacity(0.3), radius: 6, y:3 )
                                                        })
                                                }
                                               
                                                
                                            }// 저녁 기입 전
                                            
                                                else{
                                                    
                                                    if datas.completeList["completeDinner"]!{
                                                        ZStack{
                                                            Image(systemName: "checkmark.circle")
                                                                .resizable()
                                                                .foregroundColor(.white)
                                                                .frame(width: 15, height: 15)
                                                                .zIndex(1)
                                                            HStack{
                                                                Text("저녁")
                                                                    .foregroundColor(Color.white)
                                                                    .font(Font.custom(systemFont, size: 15))
                                                                    .padding(.leading,30)
                                                                Spacer()
                                                                
                                                                ///Text("\(today,formatter: MealBanner.dateFormat)")
                                                                
                                                                Spacer()
                                                                
                                                                HStack{
                                                                    Text("\(datas.kcalToDisplay["dinnerKcal"]!,specifier: "%.0f")")
                                                                        .foregroundColor(Color.white)
                                                                        .fontWeight(.black)
                                                                        .font(Font.custom(systemFont, size: 20))
                                                                    Text("Kcal")
                                                                        .foregroundColor(Color.white)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        
                                                                    }
                                                                    .padding(.trailing)
                                                                    
                                                                    
                                                                    }
                                                            
                                                                    .frame(width: 345, height: 70)
                                                                    .background(Color.init("systemColor"))
                                                                    .cornerRadius(60)
                                                                   
                                                        }
                                                        
                                                    } // 시간지나고 성공
                                                    else{
                                                        if isDinnerTimeOver{
                                                            ZStack{
                                                                Image(systemName: "multiply.circle")
                                                                    .resizable()
                                                                    .foregroundColor(Color.white)
                                                                    .frame(width: 15, height: 15)
                                                                    .zIndex(1)
                                                                HStack{
                                                                        Text("저녁")
                                                                        .foregroundColor(Color.gray)
                                                                            .fontWeight(.bold)
                                                                            .font(Font.custom(systemFont, size: 15))
                                                                            .padding(.leading,30)
                                                                    Spacer()
                                                                    
                                                                    
                                                                    Spacer()
                                                                    HStack{
                                                                       
                                                                        Text("Kcal")
                                                                            .foregroundColor(Color.gray)
                                                                            .fontWeight(.semibold)
                                                                            .font(Font.custom(systemFont, size: 15))
                                                                            
                                                                        }
                                                                    .padding(.trailing)
                                                                        
                                                                        
                                                                        }
                                                                
                                                                        .frame(width: 345, height: 70)
                                                                        .background(Color.gray.opacity(0.4))
                                                                        .cornerRadius(60)
                                                                        
                                                            }// 저녁 시간 지나고 실패
                                                           
                                                        }else{
                                                            HStack{
                                                                    Text("저녁")
                                                                    .foregroundColor(Color.gray)
                                                                        .fontWeight(.bold)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        .padding(.leading,30)
                                                                Spacer()
                                                                
                                                                Image(systemName: "alarm")
                                                                    .foregroundColor(Color.init("timeColor"))
                                                                Text("\(timeString(time: dinnerTimeRemaining))")
                                                                    .fontWeight(.bold)
                                                                    .font(Font.custom(systemFont, size: 15))
                                                                    .foregroundColor(Color.init("timeColor"))
                                                                    .padding(.trailing, 15)
                                                                Spacer()
                                                                HStack{
                                                                   
                                                                    Text("Kcal")
                                                                        .foregroundColor(Color.gray)
                                                                        .fontWeight(.semibold)
                                                                        .font(Font.custom(systemFont, size: 15))
                                                                        
                                                                    }
                                                                .padding(.trailing)
                                                                    
                                                                    
                                                                    }
                                                            
                                                                    .frame(width: 345, height: 70)
                                                                    .background(Color.init("lockedColor"))
                                                                    .cornerRadius(60)
                                                        }/// 저녁 시간 지나기 전
                                                        
                                                    }
                                                    
                                                           
                                                }
                                            HStack{
                                                Spacer()
                                                if datas.kcalToDisplay["snackKcal"]! != 0{
                     
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
                                    .frame(width: 377, height: 337, alignment: .center)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .opacity(show ? 1 : 0)
                                    .offset(y: self.show ? 0 : 20)
                                    .animation(.easeOut.delay(0.5))
                                    
                                    Rectangle()
                                        .frame(width : 390, height : 140)
                                        .opacity(0)
                                }
                                
                            }
                           
                            //.padding(.top,90)
                           

                            .ignoresSafeArea()
                        }
                        
                        .position(x: geometry.size.width / 2, y: geometry.size.height/2)
                        
                    }
                   
                   
                  
                  
                }
                
                .popup(isPresented: $showingPopup) {
                    VStack(alignment : .leading, spacing : 5){
                        HStack(){
                            Spacer()
                            Image(systemName: "multiply")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color.init("systemColor"))
                        }
                        .padding(.trailing, 23)
                        
                       
                        HStack(spacing : 0){
                            Rectangle()
                                .frame(width: 2, height: 17)
                                .foregroundColor(Color.init("systemColor"))
                                .padding(.bottom, 7)
                            Text("나의 포인트란?")
                                
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding([.leading, .bottom], 7)
                                
                        }
                        .font(Font.custom(systemFont, size: 17))
                        .padding([.leading, .top,.trailing])
                        
                        VStack(alignment : .leading, spacing : 5){
                            Text("당신의 다이어트 의지를 충전하세요!")
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                            Text("매일 식사 내용을 기록한 당신에게 서비스내에서 활용할 수")
                            Text("있는 포인트를 돌려드립니다.")
                            HStack(spacing : 0){
                                Text("부모님도 못 바꾸는 나의 습관을 ")
                                Text("하루 1000원")
                                    .frame(height: 6, alignment: .bottom)
                                    .background(Color.init("systemColor").opacity(0.5))
                                    .padding(.top,10)
                                Text("으로 바꿀 수")
                            }
                            Text("있답니다.")
                            
                        }
                        .font(Font.custom(systemFont, size: 13))
                            .padding(.leading, 26)
                        HStack(spacing : 0){
                            Rectangle()
                                .frame(width: 2, height: 17)
                                .foregroundColor(Color.init("systemColor"))
                                .padding(.bottom, 7)
                            Text("포인트 전환율이란?")
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding([.leading,.bottom], 7)
                                
                        }
                        .font(Font.custom(systemFont, size: 17))
                        .padding([.leading, .top,.trailing])
                        
                        VStack(alignment : .leading, spacing : 5){
                            Text("매일 식사 내용을 기록을 하면 포인트를 환급해드립니다!")
                            HStack(spacing : 0){
                                Text("현재까지 ")
                                HStack(spacing : 0){
                                    Text("[예상 환급 포인트]")
                                        .frame(height: 6, alignment: .bottom)
                                        .background(Color.init("systemColor").opacity(0.5))
                                        .padding(.top,10)
                                    Text("와")
                                    Text(" 나의 ")
                                    Text("[환급받은 포인트]")
                                        .frame(height: 6, alignment: .bottom)
                                        .background(Color.init("systemColor").opacity(0.5))
                                        .padding(.top,10)
                                }
                               
                               
                            }
                            Text("를 확인해보세요.")
                                
                        }
                        .font(Font.custom(systemFont, size: 13))
                            .padding(.leading, 26)
                    }
                    .padding(.bottom, 40)
                    .frame(width: 350, height:350)
                    .background(Color.white)
                    .cornerRadius(30.0)
                       
                       }
                /// 나의 포인트 설명 팝업
                .popup(isPresented: $showingTimePopup) {
                    VStack{
                       
                        HStack(spacing: 0){
                            Rectangle()
                                .frame(width: 2, height: 17)
                                .foregroundColor(Color.init("systemColor"))
                                .padding(.bottom, 1)
                            
                            Text("나의 식사 시간")
                                .font(Font.custom(systemFont, size: 17))
                                .fontWeight(.bold)
                                .padding(.leading, 7)
                            Spacer()
                           
                            Image(systemName: "multiply")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color.init("systemColor"))
                                
                        }
                        .padding([.leading, .trailing], 30)
                        
                        VStack(spacing: 15){
                            ZStack{
                               
                                Text("아침 : \(datas.userTimeToDisPlay["userMorningTime"]!):00 - \(String(Int(datas.userTimeToDisPlay["userMorningTime"]!)!+2)):00")
                                    .font(Font.custom(systemFont, size: 20))
                                    .fontWeight(.bold)
                                   
                            }
                            ZStack{
                            
                                Text("점심 : \(datas.userTimeToDisPlay["userLaunchTime"]!):00 - \(String(Int(datas.userTimeToDisPlay["userLaunchTime"]!)!+2)):00")
                                    .font(Font.custom(systemFont, size: 20))
                                    .fontWeight(.bold)
                                    
                            }
                            ZStack{
                              
                                Text("저녁 : \(datas.userTimeToDisPlay["userDinnerTime"]!):00 - \(String(Int(datas.userTimeToDisPlay["userDinnerTime"]!)!+2)):00")
                                    .font(Font.custom(systemFont, size: 20))
                                    .fontWeight(.bold)
                                   
                            }
                        }
                        .padding(.vertical, 30)
                        .padding(.bottom, 5)
                       
                    
                    }
                    
                    .frame(width: 350, height:250)
                    .background(Color.white)
                    .cornerRadius(30.0)
                       
                       }/// 시간 표시 팝업
                
                .popup(isPresented: $showingPointPopup, dismissCallback: {
                    datas.updatePoint(email: userEmail, archieveRate: String(Int(datas.dataToDisplay["archieveRate"]!)! + 1))
                    datas.updateArchievePoint(email: userEmail, archievePoint: String(Int(datas.dataToDisplay["archievePoint"]!)! + 1000))
                    datas.updateTargetArchieve(email: userEmail, targetArchieve: String(Int(datas.dataToDisplay["targetArchieve"]!)! + 1))
                    datas.isCanGetPoint(email: userEmail, userPoint: "1")
                    
                   
                    
                }) {
                    ZStack{
                        
                        VStack{
                            Image("point")
                                .resizable()
                                .frame(width: 130, height: 130)
                                
                                .padding(.top, 40)
                            Text("1000 포인트")
                                .fontWeight(.bold)
                                .font(Font.custom(systemFont, size: 20))
                                .padding(.bottom, 20)
                            Text("오늘 하루 식단 기록을 완료하였어요!")
                                .padding(.bottom, 10)
                           
                        }
                    }
                    .onAppear{
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            counter += 1
                        }
                        
                    }
                    .padding(.bottom, 50)
                    .frame(width: 300, height:300)
                    .background(Color.white)
                    .cornerRadius(30.0)
                   
                       }
                /// 포인드 획득 팝업
                .popup(isPresented: $showingFailPopup, dismissCallback : {
                    datas.updateTargetArchieve(email: userEmail, targetArchieve: String(Int(datas.dataToDisplay["targetArchieve"]!)! + 1))
                    datas.isCanGetPoint(email: userEmail, userPoint: "1")
                    
                }){
                    ZStack{
                        
                        VStack(spacing : 5){
                            Image("failImage")
                                .resizable()
                                .frame(width: 130, height: 130)
                                .padding(.top, 50)
                                
                            Text("아쉬워요 🥲 ")
                                .font(Font.custom(systemFont, size: 20))
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                            Text("내일은 꾸준하게 기록하고")
                                .font(Font.custom(systemFont, size: 17))
                            Text("포인트를 환급받으세요!")
                                .font(Font.custom(systemFont, size: 17))
                                .padding(.bottom, 10)
                           
                        }
                        .padding(.bottom, 40)
                        .frame(width: 300, height:300)
                        .background(Color.white)
                        .cornerRadius(30.0)
                    }
                }
                /// 포인트 획득 실패 팝업
                .background(Color.init("background"))
                .ignoresSafeArea()
                .navigationBarHidden(true)
                .onAppear{
                    
                    let docRef = Firestore.firestore().collection("UserData").document(userEmail).collection("Calendar").document(makeTodayDetail())
                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            
                           
                        } else {
                            datas.createCalnedar(email: userEmail, kcal: datas.dietKcal, date: makeTodayDetail(), level: "0")
                            
                        }
                    }
                          
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        show = true
                    }
                    
                    
                    if firstPop == "0"{
                        showingPopup = true
                        firstPop = "1"
                    }
                 
                    datas.apiCall(email: userEmail, data: "archieveRate")
                    datas.apiCall(email: userEmail, data: "targetArchieve")
                    datas.apiCall(email: userEmail, data: "userPoint")
                    datas.apiCall(email: userEmail, data: "Kcal")
                    datas.apiCall(email: userEmail, data: "nickName")
                    datas.apiCall(email: userEmail, data: "archievePoint")
                    
                    datas.KcalCall(email: userEmail, data: "morningKcal", meal: "Breakfast")
                    datas.KcalCall(email: userEmail, data: "launchKcal", meal: "Launch")
                    datas.KcalCall(email: userEmail, data: "dinnerKcal", meal: "Dinner")
                    datas.KcalCall(email: userEmail, data: "snackKcal", meal: "Snack")
                    
                    datas.isCompleteCall(email: userEmail, data: "completeMorning", meal: "Breakfast")
                    datas.isCompleteCall(email: userEmail, data: "completeLaunch", meal: "Launch")
                    datas.isCompleteCall(email: userEmail, data: "completeDinner", meal: "Dinner")
                    
                    datas.userTimeCall(email: userEmail, data: "userMorningTime")
                    datas.userTimeCall(email: userEmail, data: "userLaunchTime")
                    datas.userTimeCall(email: userEmail, data: "userDinnerTime")
                    
                    datas.calendarCall(email: userEmail)
                    datas.calendarkcalCall(email: userEmail)
                    
                    if morningTimeRemaining < 0{
                        
                        isMorningTimeOver = true
                    }
                    if launchTimeRemaining < 0{
                        
                        isLaunchTimeOver = true
                    }
                    if dinnerTimeRemaining < 0{
                       
                        isDinnerTimeOver = true
                        
                        if  datas.dataToDisplay["userPoint"]! == "0" && (datas.completeList["completeMorning"]!  == false || datas.completeList["completeLaunch"]!  == false || datas.completeList["completeDinner"]! == false){
                            
                            showingFailPopup = true
                        }
                    }
                    
                    morningTimeRemaining = Int(datas.userTimeToDisPlay["userMorningTime"]!)! * 3600 - getTimeToSeconds()
                    launchTimeRemaining = Int(datas.userTimeToDisPlay["userLaunchTime"]!)! * 3600 - getTimeToSeconds()
                    dinnerTimeRemaining = Int(datas.userTimeToDisPlay["userDinnerTime"]!)! * 3600 - getTimeToSeconds()
                    
                
                    
                    datas.readCalendarData(email: userEmail)
                    for data in datas.calendarData{
                        tasks.append(TaskMetaData(task: [

                            Task(title: "\(data.kcal) kcal")

                        ], taskDate: dateToString(dateString: data.date), taskColor:levelToColor(level:data.level) ))
                    }
                    
    
                   
                  
                }
            }
           
            .onReceive(timer){input in
                
                
                
                delegate.Notification(morningTime: Int(datas.userTimeToDisPlay["userMorningTime"]!)!, morningMinute: 00, morningMent: "\(datas.dataToDisplay["nickName"]!)님, 아침은 드셨나요?\n오늘 하루도 화이팅이에요💪🏻", launchTime: Int(datas.userTimeToDisPlay["userLaunchTime"]!)!, launchMinute: 00, launchMent: "\(datas.dataToDisplay["nickName"]!)님, 점심시간이에요! \n평소보다 한 숟가락만 덜 먹어도 살은 쏙 빠진답니다💚", dinnerTime: Int(datas.userTimeToDisPlay["userDinnerTime"]!)!, dinnerMinute: 00, dinnerMent: datas.completeList["completeMorning"]! == true && datas.completeList["completeLaunch"]! == true ? "\(datas.dataToDisplay["nickName"]!)님,\n저녁식사하고 기록하셔서 1,000P 받으세요💰" : "\(datas.dataToDisplay["nickName"]!)님, 저녁까지 기록해주세요!\n오늘은 아쉽지만 내일은 모두 기록하고 환급받아요🌱")
              
                if isMorning(){
                    
                    
                    datas.isCanGetPoint(email: userEmail, userPoint: "1")
                }
                if isLaunch(){
                    
                    
                    datas.isCanGetPoint(email: userEmail, userPoint: "1")
                }
                if isDinner(){
                    
                  
                    datas.isCanGetPoint(email: userEmail, userPoint: "1")
                }
                
                
                
                
                isTimeEnd()
                
                if timeNow == "\(datas.userTimeToDisPlay["userMorningTime"]!):00:00"{
                   
                    morningTime = true
                    
                }
                
                if timeNow == "\(String(Int(datas.userTimeToDisPlay["userMorningTime"]!)!+2)):00:00"{
                    
                    morningTime = false
                    isMorningTimeOver = true
                    
                }
                
                if timeNow == "\(datas.userTimeToDisPlay["userLaunchTime"]!):00:00"{
                    
                    launchTime = true
                    
                    
                }
                if timeNow == "\(String(Int(datas.userTimeToDisPlay["userLaunchTime"]!)!+2)):00:00"{
                    
                    launchTime = false
                    
                }
                
                if timeNow == "\(datas.userTimeToDisPlay["userDinnerTime"]!):00:00"{
                    
                  
                    dinnerTime = true
                   
                    
                }
                if timeNow == "\(String(Int(datas.userTimeToDisPlay["userDinnerTime"]!)!+2)):00:00"{
                   
                    dinnerTime = false
                    if  datas.dataToDisplay["userPoint"]! == "0" && (!datas.completeList["completeMorning"]! || !datas.completeList["completeLaunch"]! || !datas.completeList["completeDinner"]!){
                        
                        showingFailPopup = true
                    }
                }
               
                if timeNow == "00:00:00"{
                    
                    morningTime = false
                    launchTime = false
                    dinnerTime = false
                 
                }
                
                morningTimeRemaining = Int(datas.userTimeToDisPlay["userMorningTime"]!)! * 3600 - getTimeToSeconds()
                launchTimeRemaining = Int(datas.userTimeToDisPlay["userLaunchTime"]!)! * 3600 - getTimeToSeconds()
                dinnerTimeRemaining = Int(datas.userTimeToDisPlay["userDinnerTime"]!)! * 3600 - getTimeToSeconds()
               
                    
                
               
                
                if morningTimeRemaining < 0{
                    isMorningTimeOver = true
                }
                if launchTimeRemaining < 0{
                    isLaunchTimeOver = true
                }
                if dinnerTimeRemaining < 0{
                    isDinnerTimeOver = true
                }
                
              
                
                if  datas.dataToDisplay["userPoint"]! == "0" && datas.completeList["completeMorning"]! && datas.completeList["completeLaunch"]! && datas.completeList["completeDinner"]!{
                    
                    showingPointPopup = true
                }
                
                
             
//                if  datas.dataToDisplay["userPoint"]! == "1"{
//
//                    showingPointPopup = true
//                } //테스트용 코드
                
            }
        }
      
        
    }
    
    func isMorning() -> Bool{
        
        
                   let date = Date()
                   let calender = Calendar.current
                   let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
                   let hour = components.hour
        
                   let today_string = String(hour!)
                   
        if today_string == datas.userTimeToDisPlay["userMorningTime"]! || today_string == String(Int(datas.userTimeToDisPlay["userMorningTime"]!)! + 1){
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
                   
        if today_string == datas.userTimeToDisPlay["userDinnerTime"]! || today_string == String(Int(datas.userTimeToDisPlay["userDinnerTime"]!)! + 1){
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

        if today_string == datas.userTimeToDisPlay["userLaunchTime"]! || today_string == String(Int(datas.userTimeToDisPlay["userLaunchTime"]!)! + 1){
            return true
               }
        else{
            return false
        }

    }
    
   
    
    func loadImageFromFirebase() {
        let storage = Storage.storage().reference(withPath: FILE_NAME)
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("Download success")
            self.imageURL = "\(url!)"
        }
    }
    
    func isTimeEnd() {

                   let date = Date()
                   let calender = Calendar.current
                   let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
                   let hour = components.hour
        
                   let today_string = String(hour!)
                   
        if Int(today_string)! > Int(datas.userTimeToDisPlay["userMorningTime"]!)! {
            if  datas.dataToDisplay["userPoint"]! == "0" && (!datas.completeList["completeMorning"]! || !datas.completeList["completeLaunch"]! || !datas.completeList["completeDinner"]!){

                showingFailPopup = true
            }
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






func isLaunch() -> Bool{
    @ObservedObject var datas = firebaseData
    let date = Date()
   let calender = Calendar.current
   let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)

   let hour = components.hour

   let today_string = String(hour!)

    if today_string == datas.userTimeToDisPlay["userLaunchTime"]! || today_string == String(Int(datas.userTimeToDisPlay["userLaunchTime"]!)! + 1){
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
               
    if today_string == datas.userTimeToDisPlay["userDinnerTime"]! || today_string == String(Int(datas.userTimeToDisPlay["userDinnerTime"]!)! + 1){
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


func isMorning() -> Bool{
    @ObservedObject var datas = firebaseData
    
               let date = Date()
               let calender = Calendar.current
               let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    
               let hour = components.hour
    
               let today_string = String(hour!)
               
    if today_string == datas.userTimeToDisPlay["userMorningTime"]! || today_string == String(Int(datas.userTimeToDisPlay["userMorningTime"]!)! + 1){
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
