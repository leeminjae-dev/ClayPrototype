//
//  RandomUserRowView.swift
//  RandomUserApi
//
//  Created by Jeff Jeong on 2021/03/10.
//

import Foundation
import SwiftUI

struct SnackFoodInfoRowView : View {
    
    var items : Items
    @State var isTabNutri : Bool = false
    
    @EnvironmentObject var userData : UserData
    @ObservedObject var datas = firebaseData
    @AppStorage("userEmail") var userEmail = ""
    
    @State var searchFoodName : String = ""
    @State var isBtnTab : Bool = false
    @Binding var foodSuccess : Bool
    @Binding var showingPopup : Bool
    
    @Binding var foodName : String
    @Binding var serveSize : String
    @Binding var foodKcal : String
    @Binding var isSearch : Bool
    
    @State var OptionOne : Bool = true
    @State var OptionTwo : Bool = false
    @State var OptionThree : Bool = false
    @State var OptionFour : Bool = false
    @State var OptionCustom : Bool = false
    @State var foodSize : String = ""
    
    @State var isSuccsses : Bool = false
    @State var errorMessage : String = ""
    init(_ items : Items, foodSuccess : Binding<Bool>, showingPopup : Binding<Bool>, foodName : Binding<String> , serveSize : Binding<String>, foodKcal : Binding<String>, isSearch : Binding<Bool>) {
        self.items = items
        self._foodSuccess = foodSuccess
        self._showingPopup = showingPopup
        self._foodName = foodName
        self._serveSize = serveSize
        self._foodKcal = foodKcal
        self._isSearch = isSearch
    }
    
    var body: some View {
        NavigationLink(destination: nutritionAddView){
            HStack{
                 VStack(spacing: 10){
                     HStack{
                         Text("\(items.description)")
                             .font(.system(size: 15))
                             .fontWeight(.bold)
                         Spacer()
                     }
                     
                     HStack(spacing : 10){
                         Text("\(items.displayServe)")
                             .font(.system(size: 15))
                             .foregroundColor(.gray)
                         
                         Spacer()
                     }
            
                 }
                 
                 Spacer()
                 HStack{
                     Spacer()
                     Spacer()
                     Spacer()
                     Text("\(Float(items.displayKcal)!,specifier: "%.0f") Kcal")
                         .font(.system(size: 15))
                    
                     Button(action: {
                         datas.createSnackFoodList(email: userEmail, foodName: items.nutrition[0], serveSize: items.nutrition[1], kcal: items.nutrition[2])
                         
//                         self.foodSuccess.toggle()
                         self.isBtnTab.toggle()
                         isSearch = false
                         DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                             self.foodSuccess.toggle()
                         }
                     }) {
                         
                         if isBtnTab{
                             Image(systemName: "checkmark.circle")
                                 .resizable()
                                 .foregroundColor(.green)
                                 .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                         }else{
                             ZStack{
                                 Image(systemName: "plus")
                                 Circle()
                                     .stroke(lineWidth: 2)
                                     .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                     
                             }
                             .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                         }
                        
                         
                     }
                     .buttonStyle(BorderlessButtonStyle())
                     
                     Spacer()
                     
                     
                 }

             }
            .background(Color.white)
            
        }
       
       
    }
    var nutritionAddView : some View{
        ZStack{
            SuccessAlertView(alert: $isSuccsses, errorMassage: $errorMessage)
            VStack(spacing : 20){
                HStack(spacing : 7){
                    
                    Rectangle()
                        .foregroundColor(Color.init("systemColor"))
                        .frame(width: 3, height: 20)
                    Text(items.nutrition[0])
                        .font(Font.custom(systemFont, size: 17))
                        .bold()
                    Spacer()
                }
                HStack(spacing : 0){
                    
                    Text("\(items.nutrition[1])g ")
                        .fontWeight(.bold)
                    Text("기준 ")
                    Text("\(Float(items.nutrition[2])!,specifier: "%.0f")Kcal ")
                        .fontWeight(.bold)
                    Text("입니다")
                    Spacer()
                    
                }
                .font(Font.custom(systemFont, size: 15))
                .padding(.leading, 2)
                
                HStack(spacing : 10){
                    Button(action : {
                        OptionOne = true
                        OptionTwo = false
                        OptionThree = false
                        OptionFour = false
                        OptionCustom = false
                        foodSize = ""
                        hideKeyboard()
                        
                    }, label: {
                        
                        if OptionOne{
                            VStack(spacing : 10){
                                Text("\(items.nutrition[1])g")
                                    .fontWeight(.bold)
                                Text("\(Float(items.nutrition[2])!,specifier: "%.0f")kcal")
                                    .fontWeight(.bold)
                                
                            }
                            .font(Font.custom(systemFont, size: 12))
                            .foregroundColor(Color.white)
                            .frame(width: 82, height: 60, alignment: .center)
                            .background(Color.init("systemColor"))
                            .cornerRadius(15)
                            .shadow(radius: 6, y: 3)
                            
                        }else{
                            
                            VStack(spacing : 10){
                                Text("\(items.nutrition[1])g")
                                Text("\(Float(items.nutrition[2])!,specifier: "%.0f")kcal")
                                
                            }
                            .font(Font.custom(systemFont, size: 12))
                            .foregroundColor(Color.gray.opacity(0.5))
                            .frame(width: 79, height: 60, alignment: .center)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(15)
                            
                        }
                       
                    })
                    
                    Button(action : {
                        OptionTwo = true
                        OptionOne = false
                        OptionThree = false
                        OptionFour = false
                        OptionCustom = false
                        foodSize = ""
                        hideKeyboard()
                    }, label: {
                        if OptionTwo{
                            VStack(spacing : 10){
                                Text("\(Float(items.nutrition[1])! * 2,specifier: "%.0f")g")
                                    .fontWeight(.bold)
                                Text("\(Float(items.nutrition[2])! * 2,specifier: "%.0f")kcal")
                                    .fontWeight(.bold)
                                
                            }
                            .font(Font.custom(systemFont, size: 12))
                            
                            .foregroundColor(Color.white)
                            .frame(width: 82, height: 60, alignment: .center)
                            .background(Color.init("systemColor"))
                            .cornerRadius(15)
                            .shadow(radius: 6, y: 3)
                        }else{
                            VStack(spacing : 10){
                                Text("\(Float(items.nutrition[1])! * 2,specifier: "%.0f")g")
                                Text("\(Float(items.nutrition[2])! * 2,specifier: "%.0f")kcal")
                                
                            }
                            .font(Font.custom(systemFont, size: 12))
                            .foregroundColor(Color.gray.opacity(0.5))
                            .frame(width: 82, height: 60, alignment: .center)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(15)
                            
                        }
                     
                    })
                    
                    Button(action : {
                        OptionThree = true
                        OptionOne = false
                        OptionTwo = false
                        OptionFour = false
                        OptionCustom = false
                        foodSize = ""
                        hideKeyboard()
                    }, label: {
                        if OptionThree{
                            VStack(spacing : 10){
                                Text("\(Float(items.nutrition[1])! * 3,specifier: "%.0f")g")
                                    .fontWeight(.bold)
                                Text("\(Float(items.nutrition[2])! * 3,specifier: "%.0f")kcal")
                                    .fontWeight(.bold)

                            }
                            .font(Font.custom(systemFont, size: 12))
                            .foregroundColor(Color.white)
                            .frame(width: 82, height: 60, alignment: .center)
                            .background(Color.init("systemColor"))
                            .cornerRadius(15)
                            .shadow(radius: 6, y: 3)
                        }else{
                            VStack(spacing : 10){
                                Text("\(Float(items.nutrition[1])! * 3,specifier: "%.0f")g")
                                Text("\(Float(items.nutrition[2])! * 3,specifier: "%.0f")kcal")
                                
                            }
                            .font(Font.custom(systemFont, size: 12))
                            .foregroundColor(Color.gray.opacity(0.5))
                            .frame(width: 82, height: 60, alignment: .center)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(15)
                           
                        }
                     
                    })
                    
                    Button(action : {
                        
                        OptionFour = true
                        OptionOne = false
                        OptionTwo = false
                        OptionThree = false
                        OptionCustom = false
                        foodSize = ""
                        hideKeyboard()
                        
                    }, label: {
                        if OptionFour{
                            VStack(spacing : 10){
                                Text("\(Float(items.nutrition[1])! * 4,specifier: "%.0f")g")
                                    .fontWeight(.bold)
                                Text("\(Float(items.nutrition[2])! * 4,specifier: "%.0f")kcal")
                                    .fontWeight(.bold)
                                
                            }
                           
                            .font(Font.custom(systemFont, size: 12))
                            
                            .foregroundColor(Color.white)
                            .frame(width: 79, height: 60, alignment: .center)
                            .background(Color.init("systemColor"))
                            .cornerRadius(15)
                            .shadow(radius: 6, y: 3)
                        }else{
                            VStack(spacing : 10){
                                Text("\(Float(items.nutrition[1])! * 4,specifier: "%.0f")g")
                                Text("\(Float(items.nutrition[2])! * 4,specifier: "%.0f")kcal")
                                
                            }
                            .font(Font.custom(systemFont, size: 12))
                            .foregroundColor(Color.gray.opacity(0.5))
                            .frame(width: 79, height: 60, alignment: .center)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(15)
                            
                        }
                     
                    })
                   
                   
                    
                }
                .padding(.bottom, 10)
                VStack(spacing : 0){
                    HStack(spacing : 0){
                        Text("섭취량으로 입력하기")
                            .font(Font.custom(systemFont, size: 12))
                            
                        let binding = Binding<String>(get: {
                                   self.foodSize
                               }, set: {
                                   self.foodSize = $0
                                   
                                   OptionOne = false
                                   OptionTwo = false
                                   OptionThree = false
                                   OptionFour = false
                                   OptionCustom = true
                                   
                               })
                        
                        TextField("그램", text: binding)
                            
                            .font(.system(size: 19, weight: .heavy, design: .default))
                            .frame(width: 170, height: 25, alignment: .center)
                            .multilineTextAlignment(.center)
                            .keyboardType(.decimalPad)
                            .padding(.bottom, 10)
                            
                        Text("g")
                            .font(Font.custom(systemFont, size: 12))
                    }
                    .padding(.bottom, 2)
                    Rectangle()
                        .frame(width: 342, height: 1, alignment: .center)
                        .foregroundColor(Color.init("systemColor"))
                }
                
                if self.foodSize != ""{
                    Text("**\(Float(items.nutrition[2])! / Float(items.nutrition[1])! * Float(foodSize)!, specifier: "%.0f")** Kcal")
                        
                }else{
                    
                }
                Spacer()
                Button(action: {
                    if OptionOne{
                        datas.createSnackFoodList(email: userEmail, foodName: items.nutrition[0], serveSize: items.nutrition[1], kcal: items.nutrition[2])
                    }
                    else if OptionTwo{
                        datas.createSnackFoodList(email: userEmail, foodName: items.nutrition[0], serveSize: "\(Float(items.nutrition[1])! * 2)", kcal:"\(Float(items.nutrition[2])! * 2)")
                    }
                    else if OptionThree{
                        datas.createSnackFoodList(email: userEmail, foodName: items.nutrition[0], serveSize: "\(Float(items.nutrition[1])! * 3)", kcal:"\(Float(items.nutrition[2])! * 3)")
                    }
                    else if OptionFour{
                        datas.createSnackFoodList(email: userEmail, foodName: items.nutrition[0], serveSize: "\(Float(items.nutrition[1])! * 4)", kcal:"\(Float(items.nutrition[2])! * 4)")
                    }
                    else if OptionCustom{
                        datas.createSnackFoodList(email: userEmail, foodName: items.nutrition[0], serveSize: "\(self.foodSize)", kcal:"\(Float(items.nutrition[2])! / Float(items.nutrition[1])! * Float(foodSize)!)")
                    }
                    
                    if #available(iOS 15, *){
                        isSearch = false
                    }else{
                        errorMessage = "식단이 추가 되었습니다"
                        
                        isSuccsses = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                            isSuccsses = false
                        }
                    }
                   
                    
                   
                }, label: {
                    Text("식단 추가하기")
                        .font(Font.custom(systemFont, size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50, alignment: .center)
                        .background(Color.init("systemColor"))
                        .cornerRadius(20)
                }
                    )
                
            }
            .padding()
            .padding(.top, 20)
        }
      
       
        
    }
    
    
}



