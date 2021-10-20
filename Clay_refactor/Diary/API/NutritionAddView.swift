//
//  NutritionAddView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/20.
//

import SwiftUI

struct NutritionAddView: View {
    
    @Binding var items : Items
    @State var isTabNutri : Bool = false
    
    @EnvironmentObject var userData : UserData
    @ObservedObject var datas = firebaseData
    @AppStorage("userEmail") var userEmail = ""
    
    @Binding var searchFoodName : String
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
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        
        ZStack{
//            if isSuccsses{
//                if #available(iOS 15, *){
//                    Rectangle()
//                        .foregroundColor(Color.black.opacity(0.3))
//                        .frame(width: 390, height: 900)
//                        .ignoresSafeArea()
//                        .zIndex(1)
//                }else{
//                    Rectangle()
//                        .foregroundColor(Color.black.opacity(0.3))
//                        .frame(width: 390, height: .infinity)
//                        .ignoresSafeArea()
//                        .zIndex(1)
//                } /// 팝업 시 배경 어두워지는 사각형
//            }
            if isSuccsses == true{
                DietAddSuccessAlert(isAdd: $isSuccsses, foodName: items.nutrition[0], foodKcal: (Float(items.nutrition[2]) ?? 1))
                    .zIndex(2)
                    .padding(.bottom, 150)
                  
            }else{
                
            }
                
            
          
//            SuccessAlertView(alert: $isSuccsses, errorMassage: $errorMessage)

            VStack(spacing : 20){
                if #available(iOS 15, *){
                    
                }else{
                    Button(action: {
                        
                        self.presentationMode.wrappedValue.dismiss()
                        isSearch = false
                    }, label: {
                        Image(systemName: "chevron.left")
                    })
                }
               
                
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
                    Text("\((Float(items.nutrition[2]) ?? 0) ,specifier: "%.0f")Kcal ")
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
                                Text("\((Float(items.nutrition[2]) ?? 0) ,specifier: "%.0f")kcal")
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
                                Text("\((Float(items.nutrition[2]) ?? 0),specifier: "%.0f")kcal")
                                
                            }
                            .font(Font.custom(systemFont, size: 12))
                            .foregroundColor(Color.gray.opacity(0.5))
                            .frame(width: 82, height: 60, alignment: .center)
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
                                Text("\((Float(items.nutrition[1]) ?? 0) * 2,specifier: "%.0f")g")
                                    .fontWeight(.bold)
                                Text("\((Float(items.nutrition[2]) ?? 0) * 2,specifier: "%.0f")kcal")
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
                                Text("\((Float(items.nutrition[1]) ?? 0) * 2,specifier: "%.0f")g")
                                Text("\((Float(items.nutrition[2]) ?? 0) * 2,specifier: "%.0f")kcal")
                                
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
                                Text("\((Float(items.nutrition[1]) ?? 0) * 3,specifier: "%.0f")g")
                                    .fontWeight(.bold)
                                Text("\((Float(items.nutrition[2]) ?? 0) * 3,specifier: "%.0f")kcal")
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
                                Text("\((Float(items.nutrition[1]) ?? 0) * 3,specifier: "%.0f")g")
                                Text("\((Float(items.nutrition[2]) ?? 0) * 3,specifier: "%.0f")kcal")
                                
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
                                Text("\((Float(items.nutrition[1]) ?? 0) * 4,specifier: "%.0f")g")
                                    .fontWeight(.bold)
                                Text("\((Float(items.nutrition[2]) ?? 0) * 4,specifier: "%.0f")kcal")
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
                                Text("\((Float(items.nutrition[1]) ?? 0) * 4,specifier: "%.0f")g")
                                Text("\((Float(items.nutrition[2]) ?? 0) * 4,specifier: "%.0f")kcal")
                                
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
                    
                    Text("**\(Float(items.nutrition[2]) ?? 0 / (Float(items.nutrition[1]) ?? 0) * (Float(foodSize) ?? 0), specifier: "%.0f")** Kcal")
                        
                }else{
                    
                }
                Spacer()
                Button(action: {
                    if OptionOne{
                        
                        datas.createFoodList(email: userEmail, foodName: items.nutrition[0], serveSize: items.nutrition[1], kcal: items.nutrition[2])
                        
                    }
                    else if OptionTwo{
                        datas.createFoodList(email: userEmail, foodName: items.nutrition[0], serveSize: "\((Float(items.nutrition[1]) ?? 0) * 2)", kcal:"\((Float(items.nutrition[2]) ?? 1) * 2)")
                    }
                    else if OptionThree{
                        datas.createFoodList(email: userEmail, foodName: items.nutrition[0], serveSize: "\((Float(items.nutrition[1]) ?? 0) * 3)", kcal:"\((Float(items.nutrition[2]) ?? 1) * 3)")
                    }
                    else if OptionFour{
                        datas.createFoodList(email: userEmail, foodName: items.nutrition[0], serveSize: "\((Float(items.nutrition[1]) ?? 0) * 4)", kcal:"\((Float(items.nutrition[2]) ?? 1) * 4)")
                    }
                    else if OptionCustom{
                        datas.createFoodList(email: userEmail, foodName: items.nutrition[0], serveSize: "\(self.foodSize)", kcal:"\((Float(items.nutrition[2]) ?? 1) / (Float(items.nutrition[1]) ?? 1) * (Float(foodSize) ?? 1) )")
                    }
                    
                    if #available(iOS 15, *){
                        
                        isSearch = false
                        errorMessage = "식단이 추가 되었습니다"
                        
                    }else{
                        
                        self.presentationMode.wrappedValue.dismiss()
                        isSearch = false
                        errorMessage = "식단이 추가 되었습니다"
                        searchFoodName = ""
                        isSuccsses = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
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

//struct NutritionAddView_Previews: PreviewProvider {
//    static var previews: some View {
//        NutritionAddView()
//    }
//}
