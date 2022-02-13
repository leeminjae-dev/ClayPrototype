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



struct DiaryView: View {
    @ObservedObject var datas = firebaseData
    @EnvironmentObject var userData : UserData
    @ObservedObject var foodInfoViewModel = FoodInfoViewModel()
    @StateObject var homeViewModel = HomeViewModel()
    
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
    
    @State var isLoading : Bool = false
    @State var isFocusOn : Bool = false
    @State var isFocusOnButton : Bool = false
    
    @State var isSuccess : Bool = false
    @State var alertFoodName : String = ""
    @State var alertFoodKcal : Float = 0
    
    @State var foodText : String = ""
    @State var memo : String = ""
    
    var body: some View {
        ZStack{
            
            if isLoading{
                Loader()
                    .zIndex(2)
            }
            
            if isSuccess == true{
                DietAddSuccessAlert(isAdd: $isSuccess, foodName: alertFoodName, foodKcal: alertFoodKcal)
                    .zIndex(2)
                    .padding(.bottom, 150)
                  
            }
            
            WrongResetPasswordErrorView(alert: $isPhoto, errorMassage: $errorMessage)
               
                .zIndex(1)
            VStack(spacing : 15){
                HStack{
                    Button(action: {
                        if isSearch{
                            isSearch = false
                            searchFoodName = ""
                        }else{
                            isTabDiet = false
                        }
                        
                        
                    }, label: {
                        HStack{
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 10, height: 20)
                                .foregroundColor(Color.init("systemColor"))
                                .padding(.trailing, 3)
                            Text("Back")
                                  .foregroundColor(Color.init("systemColor"))
                        }
                        
                        
                    })
                  
                    Spacer()
                }
                .padding(.bottom, 25)
                .padding(.trailing, 15)
                .opacity(show ? 1 : 0)
                .animation(.spring().delay(0.1))
            
                
                HStack{
                    
                    Text("\(datas.dataToDisplay["nickName"] ?? "")님이 드신 것을 기록해주세요")
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .font(Font.custom(systemFont, size: 18))
                .padding(.bottom, 5)
                .padding(.trailing, 15)
                .opacity(show ? 1 : 0)
                .animation(.easeOut.delay(0.15))
                
                HStack{
                    if isAfter(){
                        HStack{
                            Text("오전")
                                .font(Font.custom(systemFont, size: 15))
                                .foregroundColor(Color.black)
                            Text("오후")
                                .font(Font.custom(systemFont, size: 15))
                                .foregroundColor(Color.black)
                                .frame(width: 45, height: 33, alignment: .center)
                                .background(Color.white)
                                .cornerRadius(5)
                               
                        }
                        .frame(width: 87, height: 40, alignment: .center)
                        .background(Color.init("shadowWhite"))
                        .cornerRadius(5)
                    }else{
                        HStack{
                            Text("오전")
                                .font(Font.custom(systemFont, size: 15))
                                .foregroundColor(Color.black)
                                .frame(width: 45, height: 33, alignment: .center)
                                .background(Color.white)
                                .cornerRadius(5)
                            Text("오후")
                                .font(Font.custom(systemFont, size: 15))
                                .foregroundColor(Color.black)
                               
                        }
                        .frame(width: 87, height: 40, alignment: .center)
                        .background(Color.init("shadowWhite"))
                        .cornerRadius(5)
                    }
                    Text("\(makeTime())")
                        .font(Font.custom(systemFont, size: 20))
                        .frame(width: 75, height: 40, alignment: .center)
                        .background(Color.init("shadowWhite"))
                        .cornerRadius(5)
                    Spacer()
                }
                .padding(.trailing, 15)
                .opacity(show ? 1 : 0)
                .animation(.easeOut.delay(0.25))
              
                
                ZStack{
                    if imageURL != "" {
                        ZStack{
                            
                            FirebaseImageView(imageURL: imageURL)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 360, height: isFocusOn ? 45 : 280, alignment: .center)
                                .cornerRadius(15)
                               
                            
                            HStack {
//                                    Button(action: { self.imageURL = ""}){
//                                        Text("dd")
//                                    }
                                Button(action: { self.shown.toggle() }) {
                                    
                                    Image(systemName: "camera")
                                        .opacity(show ? 1 : 0)
                                       
                                      
                                }
                                .sheet(isPresented: $shown) {
                                    
                                    Camera(shown: self.$shown,imageURL: self.$imageURL)
                                        .opacity(show ? 1 : 0)
                                        
                                       
                                    }
                                .padding(10).background(Color.init("systemColor")).foregroundColor(Color.white).cornerRadius(20)
                                    .onAppear(perform: loadImageFromFirebase).animation(.spring())
                               
                               
                                Button(action: { self.shownPhoto.toggle() }) {
                                    
                                    Image(systemName: "photo.on.rectangle.angled")
                                        .opacity(show ? 1 : 0)
                                      
                                        
                                }
                                .sheet(isPresented: $shownPhoto) {
                                    
                                    imagePicker(shown: self.$shownPhoto,imageURL: self.$imageURL, isLoading: $isLoading)
                                        .opacity(show ? 1 : 0)
                                        
                                        
                                      
                                        
                                    }
                                    .padding(10).background(Color.init("systemColor")).foregroundColor(Color.white).cornerRadius(20)
                                    .animation(.spring())
                            }
                            .padding(.top, isFocusOn ? 0  : 230)
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
                                    .opacity(show ? 1 : 0)
                                    .animation(.easeOut.delay(0.35))
                                
                                Button(action: { self.shownPhoto.toggle() }) {
                                    
                                    Image(systemName: "photo.on.rectangle.angled")
                                        .opacity(show ? 1 : 0)
                                       
                                        .animation(.easeOut.delay(0.35))
                                }
                                .sheet(isPresented: $shownPhoto) {
                                    
                                    imagePicker(shown: self.$shownPhoto,imageURL: self.$imageURL, isLoading: $isLoading)
                                    
                                    }
                                    .padding(10)
                                    .background(Color.init("systemColor"))
                                    .foregroundColor(Color.white)
                                    .cornerRadius(20)
                                    .onAppear(perform: loadImageFromFirebase)
                                    .opacity(show ? 1 : 0)
                                    .animation(.easeOut.delay(0.35))
                                
                            }
                            .padding()
                            .frame(width: 360, height: 100)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 1)

                        }
                    }
                }
                .opacity(show ? 1 : 0)
                .animation(.easeOut.delay(0.35))
                

                let binding = Binding<String>(get: {
                    
                           self.foodText
                    
                       }, set: {
 
                           self.foodText = $0
                           
                       })
                TextField("무엇을 먹었는지 여기에 입력해주세요", text: binding, onEditingChanged: { (editingChanged) in
                    if editingChanged {

                        isFocusOn = true
                    } else {
                        isFocusOn = false

                    }})
                    .font(Font.custom(systemFont, size: 15))
                    .padding()
                    .frame(width: 360, height: 40, alignment: .center)
                    .background(Color.init("shadowWhite"))
                    .cornerRadius(15)
                    .opacity(show ? 1 : 0)
                    .animation(.easeOut.delay(0.45))
                let binding = Binding<String>(get: {
                    
                           self.memo
                    
                       }, set: {
 
                           self.memo = $0
                           
                       })
                TextField("간단한 메모를 해주세요", text: binding, onEditingChanged: { (editingChanged) in
                    if editingChanged {

                        isFocusOn = true
                    } else {
                        isFocusOn = false

                    }})
                    .font(Font.custom(systemFont, size: 15))
                    .padding()
                    .frame(width: 360, height: 100, alignment: .center)
                    .background(Color.init("shadowWhite"))
                    .cornerRadius(15)
                    .opacity(show ? 1 : 0)
                    .animation(.easeOut.delay(0.55))
                
                Spacer()
                if imageURL != ""{
                    Button(action: {
                        
                        
                        let docRef = Firestore.firestore().collection("UserData").document(userEmail).collection("Calendar").document(makeTodayDetail())
                        
                        docRef.getDocument { (document, error) in
                            if let document = document, document.exists {
                                if isMorning(){
                                    if datas.completeList["completeMorning"] ?? false{
                                        
                                    }else{
                                        
                                        datas.updateCalnedar(email: userEmail, kcal: datas.calendarKcalToDisplay["kcal"] ?? 0 + datas.dietKcal, date: makeTodayDetail(), level: String((Int(datas.calendarToDisplay["level"] ?? "0") ?? 0) + 1))
                                    }
                                }
                                if isLaunch(){
                                    if datas.completeList["completeLaunch"] ?? false{
                                      
                                    }else{
                                        datas.updateCalnedar(email: userEmail, kcal: datas.calendarKcalToDisplay["kcal"] ?? 0 + datas.dietKcal, date: makeTodayDetail(), level: String((Int(datas.calendarToDisplay["level"] ?? "0") ?? 0) + 1))
                                    }
                                }
                                if isDinner(){
                                    if datas.completeList["completeDinner"] ?? false{
                                       
                                    }else{
                                        datas.updateCalnedar(email: userEmail, kcal: datas.calendarKcalToDisplay["kcal"] ?? 0 + datas.dietKcal, date: makeTodayDetail(), level: String((Int(datas.calendarToDisplay["level"] ?? "0") ?? 0) + 1))
                                    }
                                }
                               
                            } else {
                                
                                datas.createCalnedar(email: userEmail, kcal: datas.dietKcal, date: makeTodayDetail(), level: "0")
                                
                            }
                        }
                        
                        firebaseData.createDiary(email:userEmail , image: "image1", foodText : foodText, memo: memo)
                        
                        self.isTabDiet = false
                        
                        if isDinner() && !(datas.completeList["completeDinner"] ?? false){
                            
                            datas.isCanGetPoint(email: userEmail, userPoint: "0")
                            
                        }
                        if isLaunch() && !(datas.completeList["completeMorning"] ?? false){
                            
                            datas.isCanGetPoint(email: userEmail, userPoint: "0")
                           
                            
                        }
                        if isMorning(){
                            
                            
                            datas.isCanGetPoint(email: userEmail, userPoint: "0")
                            
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
                    .animation(.easeOut.delay(0.35))
                }
                        
                    
                
             
                }
           
        }
        
        .padding()
      
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear{
            
            loadImageFromFirebase()
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
    
    func makeTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: date)
    }
    
    func isAfter() -> Bool {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        if Int(formatter.string(from: date))! > 11{
            return true
        }
        else{
            return false
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
                }else{
                    Text(" 간식")
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
    return "Snack"

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
