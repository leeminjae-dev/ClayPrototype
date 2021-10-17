////
////  MealBanner.swift
////  Clay2
////
////  Created by 이민재 on 2021/08/29.
////
//
//import Foundation
//import SwiftUI
//
//struct MealBanner: View {
//    
//    @ObservedObject var datas = firebaseData
//    @Binding var MealCal : Float
//    @State var MealText : String
//    @State var isUnlocked : Bool
//    
//    @State var today = Date()
//
//    
//    
//    var body: some View{
//        if isUnlocked{
//            NavigationLink(
//                destination: DiaryView(isTabDiet: $isUnlocked),
//                label: {
//                    HStack{
//                        Text(MealText)
//                            .fontWeight(.bold)
//                            .font(Font.custom(systemFont, size: 15))
//                            .padding(.leading,30)
//                        Spacer()
//                        
//                        ///Text("\(today,formatter: MealBanner.dateFormat)")
//                        
//                        
//                        Spacer()
//                        
//                        HStack{
//                            Text("\(MealCal, specifier: "%.0f")")
//                                .foregroundColor(Color.black)
//                                .fontWeight(.black)
//                                .font(Font.custom(systemFont, size: 20))
//                            Text("Kcal")
//                                .fontWeight(.semibold)
//                                .font(Font.custom(systemFont, size: 15))
//                                
//                            }
//                            .padding(.trailing)
//                            
//                            
//                            }
//                    
//                            .frame(width: 340, height: 70)
//                            .background(Color.init("systemColor"))
//                            .cornerRadius(30)
//                            .shadow(color: .black, radius: 2)
//                })
//                .foregroundColor(Color.black)
//        }
//        
//            else{
//                HStack{
//                        Text(MealText)
//                            .fontWeight(.bold)
//                            .font(Font.custom(systemFont, size: 15))
//                            .padding(.leading,30)
//                    Spacer()
//                    Image(systemName: "lock")
//                        .foregroundColor(Color.white)
//                        .font(.system(size: 45))
//                        .padding(.leading,20)
//                    Spacer()
//                    HStack{
//                        Text("\(MealCal, specifier: "%.0f")")
//                            .foregroundColor(Color.white)
//                            .fontWeight(.black)
//                            .font(Font.custom(systemFont, size: 20))
//                        Text("Kcal")
//                            .fontWeight(.semibold)
//                            .font(Font.custom(systemFont, size: 15))
//                            
//                        }
//                    .padding(.trailing)
//                        
//                        
//                        }
//                
//                        .frame(width: 359, height: 72)
//                        .background(Color.init("lockedColor"))
//                        .cornerRadius(50)
//                        .shadow(color: .black, radius: 6, y: 3)
//            }
//        }
//    
//       
//               
//}
//
//
//
