//
//  Practice.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/08.
//

import SwiftUI
import FirebaseFirestore
import PopupView
import FirebaseAnalytics
import Firebase
import FirebaseFirestore
let FILE_NAME = "Diary/\(makeEmailString())/\(makeToday())/\(makeMealString()).jpg"

struct DiaryView: View {
    @ObservedObject var datas = firebaseData
    @EnvironmentObject var userData : UserData
    @ObservedObject var foodInfoViewModel = FoodInfoViewModel()
    
    @AppStorage("userEmail") var userEmail = ""
    @AppStorage("firstPop") var firstPop = false
    
    @State var diaryText : String = "1"
    @State var shown = false
    @State var shownPhoto = false
    @State var imageURL = ""
    @State var slection : Int? = nil
   
    @State var searchFoodName : String = ""
    @State var isSearch : Bool = false
    
    @State var foodName : String = ""
    @State var serveSize : String = ""
    @State var foodKcal : String = ""
    @State var showingPopup : Bool = false
    @State var foodSuccess : Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var isTabDiet : Bool
    
    @State var show : Bool = false
    
    @State var isPhoto : Bool = false
    @State var errorMessage : String = ""
    
    @State var customFoodName : String = ""
    @State var customKcal : String = ""
    @State var customServeSize : String = ""
    
//    init(){
//        
//        UITabBar.appearance().isTranslucent = true
//        UINavigationBar.appearance().tintColor = UIColor(Color.init("systemColor"))
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().isOpaque = false
//        ///UITabBar.appearance().backgroundImage = UIImage()
//       
//    }
    
    var body: some View {
        ZStack{
            WrongResetPasswordErrorView(alert: $isPhoto, errorMassage: $errorMessage)
               
                .zIndex(1)
            VStack{
                HStack{
                    Button(action: {
                        isTabDiet = false
                        
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 10, height: 20)
                            .foregroundColor(Color.init("systemColor"))
                            .padding(.trailing, 3)
                            
                        
                    })
                    HStack{
                        ZStack{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color.init("systemColor"))
                                .zIndex(1)
                           
                            
                        }
                        let binding = Binding<String>(get: {
                                   self.searchFoodName
                               }, set: {
                                   foodInfoViewModel.fetchFoodInfo(searchFoodName: searchFoodName)
                                   self.searchFoodName = $0
                                   isSearch = true
                               })
                        TextField("음식을 검색해보세요", text: binding)
                           
                            .font(Font.custom(systemFont, size: 12))
                        Button(action: {
                            
                            isSearch = false
                          
                            
                        }, label: {
                            if isSearch{
                                Image(systemName : "multiply.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.init("systemColor"))
                            }else{
                               
                            }
                           
                        })
                            .padding(.trailing, 10)
                        
                    } .padding(.leading,5)
                        .frame(width: 328, height: 42, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.init("systemColor"), lineWidth: 2)
                            )
                        .padding(.trailing, 13)
                   
                }
                .padding(.bottom, 5)
                .opacity(show ? 1 : 0)
                .offset(y: self.show ? 0 : 20)
                .animation(.spring().delay(0.1))
                
                
                if isSearch{
                    VStack{
                        HStack{
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
                            VStack{
                                HStack{
                                    Text("현재 식단내용데이터가 많지 않은 관계로, 클레이 카카오톡")
                                        .font(Font.custom(systemFont, size: 10))
                                    Spacer()
                                }
                                HStack{
                                    Text("CS채널로 식사내용을 알려주시면 정확한 칼로리를 알려드릴게요!")
                                        .font(Font.custom(systemFont, size: 10))
                                    Spacer()
                                }
                               
                            }
                            
                        }
                        .padding(.leading,38)
                        
                        List(foodInfoViewModel.FoodInfo){ aRandomUser in
                            
                            FoodInfoRowView(aRandomUser, foodSuccess: $foodSuccess,showingPopup: $showingPopup, foodName: $foodName, serveSize : $serveSize, foodKcal : $foodKcal, isSearch: $isSearch)
                                
                    }
                        .listStyle(PlainListStyle())
                        
                       NavigationLink(destination:{
                           
                           CustomNutritionAddView
                            
                        }){
                            Text("직접 추가하기")
                                .fontWeight(.bold)
                                .font(Font.custom(systemFont, size: 15))
                                .foregroundColor(.white)
                                .frame(width: 360, height: 50, alignment: .center)
                                .background(Color.init("systemColor"))
                                .cornerRadius(60)
                                .shadow(color: Color.black.opacity(0.3), radius: 6, y:3 )
                        }
                    }
                   
                        
                        
                }else{
                    VStack(spacing : 0){
                        if isMorning(){
                            Text("\(datas.dataToDisplay["nickName"]!)님이 드신 아침 식단을 알려주세요")
                                .font(Font.custom(systemFont, size: 17))
                                .padding(.top, 7)
                                .padding(.bottom, 5)
                                
                        }
                        else if isLaunch(){
                            Text("\(datas.dataToDisplay["nickName"]!)님이 드신 점심 식단을 알려주세요")
                                .font(Font.custom(systemFont, size: 17))
                                .padding(.top, 7)
                                .padding(.bottom, 5)
                               
                        }
                        else if isDinner(){
                            Text("\(datas.dataToDisplay["nickName"]!)님이 드신 저녁 식단을 알려주세요")
                                .font(Font.custom(systemFont, size: 17))
                                .padding(.top, 7)
                                .padding(.bottom, 5)
                        }else{
                            Text("\(datas.dataToDisplay["nickName"]!)님이 드신 Test 식단을 알려주세요")
                                .font(Font.custom(systemFont, size: 17))
                                .padding(.top, 7)
                                .padding(.bottom, 5)
                        }
                            
                       
                        HStack(spacing : 0){
                            ZStack{
                                Image(systemName: "lightbulb")
                                    .resizable()
                                    .frame(width: 8, height: 12, alignment: .center)
                                    .foregroundColor(.black)
                                    .zIndex(1)
                                Circle()
                                    .foregroundColor(Color.init("bulbYellow"))
                                    .frame(width: 20, height: 20, alignment: .center)
                                    
                            }
                            .padding(.trailing, 4)
                            
                            Text("양과 칼로리를 기입해주세요. 기입되면 자동으로 저장된답니다!")
                                .font(Font.custom(systemFont, size: 10))
                                .foregroundColor(Color.gray)
                        }
                       
                    }
                    .opacity(show ? 1 : 0)
                    .offset(y: self.show ? 0 : 20)
                    .animation(.easeOut.delay(0.2))
                    .padding(.bottom,20)
                    
                    VStack{
  
                        if datas.foodList == []{
                            VStack{
                                foodTextView
                                HStack{
                                    ZStack{
                                        Image("foodImage")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                        Circle()
                                            .stroke()
                                            .frame(width: 44, height: 44)
                                            .foregroundColor(Color.init("systemColor"))

                                    }
                                    .padding(.trailing, 8)
                                    Text("음식을 검색하여 식단을 기입해주세요")
                                        .font(Font.custom(systemFont, size: 15))
                                        .foregroundColor(Color.gray)
                                        .padding(.trailing, 3)
                                }
                                .multilineTextAlignment(.center)
                                
                                .frame(width: 360, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 1)
                               
                            }
                            .opacity(show ? 1 : 0)
                            .offset(y: self.show ? 0 : 20)
                            .animation(.easeOut.delay(0.2))
                            .padding(.bottom,7)
                            
                                
                        }else{
                            VStack{
                                foodTextView
                                    .padding(.leading, 19)
                                List(datas.foodList, id: \.self){food in
                                    
                                    HStack(spacing :0){
                                            HStack(spacing :0){
                                                ZStack{
                                                    Image("foodImage")
                                                        .resizable()
                                                        .frame(width: 30, height: 30)
                                                    Circle()
                                                        .stroke()
                                                        .frame(width: 44, height: 44)
                                                        .foregroundColor(Color.init("systemColor"))

                                                }
                                                .padding(.trailing, 10)
                                                VStack{
                                                    HStack{
                                                        Text(food[0])
                                                            .font(Font.custom(systemFont, size: 15))
                                                            .fontWeight(.bold)
                                                        Spacer()
                                                    }
                                                    HStack{
                                                        Text("\(Float(food[2])!,specifier: "%.0f") Kcal")
                                                            .font(Font.custom(systemFont, size: 13))
                                                        Spacer()
                                                    }
                                                    
                                                }
                                               
                                            }
                                            Button(action: {
                                                
                                                let foodIndex = datas.foodList.firstIndex(of: [food[0],food[1],food[2]])
                                                datas.foodList.remove(at: foodIndex!)
                                                datas.deleteFoodList(email: userEmail, foodName: food[0])
                                                datas.dietKcal = 0
                                                datas.foodList.removeAll()
                                                datas.foodListCall(email: userEmail)
                                                
                                            }, label: {
                                                Image(systemName: "trash")
                                            })
                                            .buttonStyle(BorderlessButtonStyle())
                                    }
                                    .padding(.trailing, 20)
                                    .padding(.leading, 6)
                                        .padding(5)
                                        
                                        .frame(width: 347, height: 60)
                                        .background(Color.white)
                                        .cornerRadius(60)
                                        .shadow(radius: 3, y: 3)
                                        
                                }
                            }
                            
                            .listStyle(PlainListStyle())
                            .frame(width: 370, height: 200)
                            .padding(.trailing, 30)
                            .onAppear{
                                UITableView.appearance().separatorColor = .clear
                            }
                           
                           
                           
                          
                            
                            
                        }
                        
                    }
                    
                    ZStack{
                        if imageURL != "" {
                            ZStack{
                                
                                FirebaseImageView(imageURL: imageURL)
                                    
                                HStack {
//                                    Button(action: { self.imageURL = ""}){
//                                        Text("dd")
//                                    }
                                    Button(action: { self.shown.toggle() }) {
                                        
                                        Image(systemName: "camera")
                                            .opacity(show ? 1 : 0)
                                            .offset(y: self.show ? 0 : 20)
                                            .animation(.easeOut.delay(0.35))
                                    }
                                    .sheet(isPresented: $shown) {
                                        
                                        Camera(shown: self.$shown,imageURL: self.$imageURL)
                                            .opacity(show ? 1 : 0)
                                            .offset(y: self.show ? 0 : 20)
                                            .animation(.easeOut.delay(0.35))
                                        }
                                    .padding(10).background(Color.init("systemColor")).foregroundColor(Color.white).cornerRadius(20)
                                        .onAppear(perform: loadImageFromFirebase).animation(.spring())
                                   
                                   
                                    Button(action: { self.shownPhoto.toggle() }) {
                                        
                                        Image(systemName: "photo.on.rectangle.angled")
                                            .opacity(show ? 1 : 0)
                                            .offset(y: self.show ? 0 : 20)
                                            .animation(.easeOut.delay(0.35))
                                    }
                                    .sheet(isPresented: $shownPhoto) {
                                        
                                        imagePicker(shown: self.$shownPhoto,imageURL: self.$imageURL)
                                            .opacity(show ? 1 : 0)
                                            .offset(y: self.show ? 0 : 20)
                                            .animation(.easeOut.delay(0.35))
                                            
                                        }
                                        .padding(10).background(Color.init("systemColor")).foregroundColor(Color.white).cornerRadius(20)
                                        .onAppear(perform: loadImageFromFirebase).animation(.spring())
                                }
                                .padding(.top, 230)
                                .padding(.leading, 230)
                                .zIndex(1)
                               
                                
                            }
                          
                            
                            
                        }else{
                           
                            VStack{
                                HStack {
                                    VStack(spacing : 0){
                                        Text("식단 사진을 업로드해 주세요")
                                            .padding(.trailing, 15)
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
                                           
                                            Text("사진촬영 및 업로드를 해야 입력이 완료됩니다!")
                                                .font(Font.custom(systemFont, size: 10))
                                                .fontWeight(.light)
                                                .padding(.leading, 3)
                                             Spacer()
                                        }
                                    }
                                    
                                        
                                    Spacer()
                                    Button(action: { self.shown.toggle() }) {
                                        
                                        Image(systemName: "camera")
                                        
                                    }
                                    .sheet(isPresented: $shown) {
                                        
                                        Camera(shown: self.$shown,imageURL: self.$imageURL)
                                                    
                                        }
                                        .padding(10).background(Color.init("systemColor")).foregroundColor(Color.white).cornerRadius(20)
                                        .onAppear(perform: loadImageFromFirebase).animation(.spring())
                                        .opacity(show ? 1 : 0)
                                        .offset(y: self.show ? 0 : 20)
                                        .animation(.easeOut.delay(0.35))
                                    
                                    Button(action: { self.shownPhoto.toggle() }) {
                                        
                                        Image(systemName: "photo.on.rectangle.angled")
                                            .opacity(show ? 1 : 0)
                                            .offset(y: self.show ? 0 : 20)
                                            .animation(.easeOut.delay(0.35))
                                    }
                                    .sheet(isPresented: $shownPhoto) {
                                        
                                        imagePicker(shown: self.$shownPhoto,imageURL: self.$imageURL)
                                        
                                            
                                        }
                                        .padding(10).background(Color.init("systemColor"))
                                        .foregroundColor(Color.white).cornerRadius(20)
                                        .onAppear(perform: loadImageFromFirebase).animation(.spring())
                                        .opacity(show ? 1 : 0)
                                        .offset(y: self.show ? 0 : 20)
                                        .animation(.easeOut.delay(0.35))
                                }
                                .padding()
                                .frame(width: 360, height: 100, alignment: .center)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 1)
                                
                                
                                
                                
                            }
                          
                           
                            
                        }
                    
                        
                    }
                    .opacity(show ? 1 : 0)
                    .offset(y: self.show ? 0 : 20)
                    .animation(.easeOut.delay(0.35))
                    
                    Spacer()
                    if imageURL != ""{
                        Button(action: {
                            
                            
                            let docRef = Firestore.firestore().collection("UserData").document(userEmail).collection("Calendar").document(makeTodayDetail())
                            docRef.getDocument { (document, error) in
                                if let document = document, document.exists {
                                   
                                    datas.updateCalnedar(email: userEmail, kcal: datas.calendarKcalToDisplay["kcal"]! + datas.dietKcal, date: makeTodayDetail(), level: String(Int(datas.calendarToDisplay["level"]!)! + 1))
                                } else {
                                    datas.createCalnedar(email: userEmail, kcal: datas.dietKcal, date: makeTodayDetail(), level: "0")
                                    
                                }
                            }
                            
                            firebaseData.createDiary(email:userEmail , image: "image1", diaryText: diaryText ,morningKcal: datas.dietKcal ,launchKcal: datas.dietKcal ,dinnerKcal: datas.dietKcal)
                            self.isTabDiet = false
                            datas.isCanGetPoint(email: userEmail, userPoint: "1")
                            
                        }, label: {
                            
                            Text("식단 기록하기")
                                .fontWeight(.bold)
                                .font(Font.custom(systemFont, size: 15))
                                .foregroundColor(.white)
                                .frame(width: 360, height: 50, alignment: .center)
                                .background(Color.init("systemColor"))
                                .cornerRadius(60)
                                .shadow(color: Color.black.opacity(0.3), radius: 6, y:3 )
                            
                        })
                        .opacity(show ? 1 : 0)
                        .offset(y: self.show ? 0 : 20)
                        .animation(.easeOut.delay(0.35))
                    }
                    else if datas.foodList == []{
                        Button(action: {
                            
                           
                            isPhoto = true
                            errorMessage = "식단을 추가해주세요!"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                isPhoto = false
                            }
                            
                        }, label: {
                            
                            Text("식단 기록하기")
                                .fontWeight(.bold)
                                .font(Font.custom(systemFont, size: 15))
                                .foregroundColor(.white)
                                .frame(width: 360, height: 50, alignment: .center)
                                .background(Color.init("systemColor"))
                                .cornerRadius(60)
                                .shadow(color: Color.black.opacity(0.3), radius: 6, y:3 )
                            
                        })
                        .opacity(show ? 1 : 0)
                        .offset(y: self.show ? 0 : 20)
                        .animation(.easeOut.delay(0.35))
                    }
                    else{
                        Button(action: {
                            
                            isPhoto = true
                            errorMessage = "사진을 첨부해야 업로드 할 수 있어요!"

                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                isPhoto = false
                            }
                        }, label: {
                            
                            Text("식단 기록하기")
                                .fontWeight(.bold)
                                .font(Font.custom(systemFont, size: 15))
                                .foregroundColor(.white)
                                .frame(width: 360, height: 50, alignment: .center)
                                .background(Color.init("systemColor"))
                                .cornerRadius(60)
                                .shadow(color: Color.black.opacity(0.3), radius: 6, y:3 )
                            
                        })
                        .opacity(show ? 1 : 0)
                        .offset(y: self.show ? 0 : 20)
                        .animation(.easeOut.delay(0.35))
                    }
                        
                    
                }
             
                }
        }
        
        .ignoresSafeArea(.keyboard)
        .padding()
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear{
            
            Analytics.logEvent(AnalyticsEventScreenView,
                                     parameters: [AnalyticsParameterScreenName: "\(DiaryView.self)",
                                                  AnalyticsParameterScreenClass: "\(DiaryView.self)"])
            
            show = true
            datas.dietKcal = 0
            datas.foodList.removeAll()
            datas.foodListCall(email: userEmail)
            
            
            
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
    
    private var foodTextView : some View{
        VStack(spacing : 5){
            HStack(spacing: 0){
                Text("오늘")
                    .font(Font.custom(systemFont, size: 17))
                if isMorning(){
                    Text(" 아침")
                        .fontWeight(.bold)
                        .font(Font.custom(systemFont, size: 17))
                }
                else if isLaunch(){
                    Text(" 점심")
                        .fontWeight(.bold)
                        .font(Font.custom(systemFont, size: 17))
                }
                else if isDinner(){
                    Text(" 저녁")
                        .font(Font.custom(systemFont, size: 17))
                        .fontWeight(.bold)
                }
                
                Text("으로")
                    .font(Font.custom(systemFont, size: 17))
                Spacer()
            }
            
            HStack(spacing: 0){
                Text("\(datas.dietKcal,specifier: "%.0f")kcal")
                    .font(Font.custom(systemFont, size: 17))
                    .fontWeight(.bold)
                Text("를 섭취했어요")
                    .font(Font.custom(systemFont, size: 17))
                Spacer()
            }
         
        }
        
        
    }
    var CustomNutritionAddView : some View{
        ZStack{
            if isPhoto{
                WrongResetPasswordErrorView(alert: $isPhoto, errorMassage: $errorMessage)
                    .zIndex(2)
                    .padding(.bottom, 300)
            }
                
            
            VStack(spacing : 20){
                ZStack{
                    Image("foodImage")
                        .resizable()
                        .frame(width: 130, height: 130)
                        .padding(.bottom, 20)
                    
                }
                
                HStack{
                    Text("음식명")
                        .font(Font.custom(systemFont, size: 17))
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 20)
                        
                    TextField("제품명",text : $customFoodName)
                        .multilineTextAlignment(.center)
                        .frame(width: 230, height: 30)
                        .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.init("systemColor"), lineWidth: 1.5))
                    
                    Spacer()
                }
                .padding(.leading, 7)
               
                
                HStack{
                    Text("섭취량")
                        .font(Font.custom(systemFont, size: 17))
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 20)
                    TextField("g", text : $customServeSize)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .frame(width: 230, height: 30)
                        .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.init("systemColor"), lineWidth: 1.5))
                    Spacer()
                }
                .padding(.leading, 7)
                
                HStack{
                    Text("칼로리")
                        .font(Font.custom(systemFont, size: 17))
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 20)
                    TextField("kcal", text : $customKcal)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .frame(width: 230, height: 30)
                        .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.init("systemColor"), lineWidth: 1.5))
                    Spacer()
                }
                .padding(.leading, 7)
                .padding(.bottom, 20)
                if customFoodName == "" || customServeSize == "" || customKcal == ""{
                    Button(action :{
                        errorMessage = "모든 칸을 채워주세요!"
                       isPhoto = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            isPhoto = false
                        }
                        
                        
                    }){
                        Text("식단 추가하기")
                            .font(Font.custom(systemFont, size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 330, height: 50, alignment: .center)
                            .background(Color.init("systemColor"))
                            .cornerRadius(60)
                    }
                }else{
                    Button(action :{
                        isSearch = false
                        datas.createFoodList(email: userEmail, foodName: customFoodName, serveSize: customServeSize, kcal : "\(Float(customKcal)!)")
                        customKcal = ""
                        customFoodName = ""
                        customServeSize = ""
                        
                    }){
                        Text("식단 추가하기")
                            .font(Font.custom(systemFont, size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 330, height: 50, alignment: .center)
                            .background(Color.init("systemColor"))
                            .cornerRadius(60)
                    }
                }
               
               
            }
            .padding([.leading, .trailing], 30)
            .padding(.bottom, 150)
            .navigationTitle("직접 추가하기")
        }
       
       
    }

}
    



func makeMealString() -> String{
    if isMorning(){
        return "Breakfast"
           }
    else if isLaunch(){
        return "Launch"
           }
    else if isDinner(){
        return "Dinner"
           }
    return "test"

}

func makeEmailString() -> String{
    @AppStorage("userEmail") var userEmail = ""
    return userEmail
}



#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
