//
//  RandomUserRowView.swift
//  RandomUserApi
//
//  Created by Jeff Jeong on 2021/03/10.
//

import Foundation
import SwiftUI

struct FoodInfoRowView : View {
    
    @State var items : Items
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
    
    @Binding var isSuccess : Bool
    @State var errorMessage : String = ""
    
    @Binding var alertFoodName : String
    @Binding var alertFoodKcal : Float
    
    var body: some View {
    
        NavigationLink(destination: NutritionAddView(items: self.$items, searchFoodName : $searchFoodName,foodSuccess: $foodSuccess,showingPopup: $showingPopup, foodName: $foodName, serveSize : $serveSize, foodKcal : $foodKcal, isSearch: $isSearch, isSuccess: $isSuccess, alertFoodName: $alertFoodName, alertFoodKcal: $alertFoodKcal)){
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
                     
                     Text("\((Float(items.displayKcal) ?? 0),specifier: "%.0f") Kcal")
                         .font(.system(size: 15))
                    
                     Button(action: {
                         datas.createFoodList(email: userEmail, foodName: items.nutrition[0], serveSize: items.nutrition[1], kcal: items.nutrition[2])
                         
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
   
    
}


