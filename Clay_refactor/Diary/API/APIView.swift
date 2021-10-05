////
////  ContentView.swift
////  RandomUserApi
////
////  Created by Jeff Jeong on 2021/03/10.
////
//
//import SwiftUI
//
//struct APIView: View {
//    
//    @ObservedObject var foodInfoViewModel = FoodInfoViewModel()
//    @State var listToggle : Bool = false
//    @State var foodSuccess : Bool = false
//    @State var searchFoodName : String = ""
//   
//    @State var foodName : String = ""
//    @State var serveSize : String = ""
//    @State var foodKcal : String = ""
//    @State var showingPopup : Bool = false
//    
//    var body: some View {
//        ZStack{
//            VStack{
//               
//                HStack{
//                    
//                    TextField("음식을 검색해보세요", text: $searchFoodName)
//                        .padding(.leading,20)
//                        .font(Font.custom(systemFont, size: 15))
//                    Button(action: {
//                        
//                        foodInfoViewModel.fetchFoodInfo(searchFoodName: searchFoodName)
//                        
//                    }) {
//                        ZStack{
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(Color.white)
//                                .zIndex(1)
//                            Circle()
//                                .frame(width: 35, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                .foregroundColor(Color.init("systemColor"))
//                            
//                        }
//                        
//                    }
//                }
//                    .frame(width: 350, height: 35, alignment: .center)
//                    .background(Color.white)
//                    .cornerRadius(20)
//                    .overlay(
//                                RoundedRectangle(cornerRadius: 20)
//                                    .stroke(Color.init("systemColor"), lineWidth: 2)
//                        )
//                    .padding(.top,10)
//                    
//                   
//                
//                ZStack{
//                    List(foodInfoViewModel.FoodInfo){ aRandomUser in
//                        FoodInfoRowView(aRandomUser, foodSuccess: $foodSuccess,showingPopup: $showingPopup, foodName: $foodName, serveSize : $serveSize, foodKcal : $foodKcal, isSearch: $isSerch)
//                            
//                }.listStyle(PlainListStyle())
//                        
//                   
//                    
//                    if foodSuccess{
//                        FoodSelectSuccessView()
//                    }
//                    
//                }
//                
//                   
//                
//            }
//        }
//        .popup(isPresented: $showingPopup, type: .default, position: .bottom, animation: .default, dragToDismiss: true, closeOnTap: false, closeOnTapOutside: false) {
//            VStack{
//                Text("\(foodName)")
//                Text("\(foodKcal)")
//                         
//            }
//            .frame(width: 370, height: 500)
//            .background(Color.white)
//            .cornerRadius(30.0)
//            .shadow(radius: 1)
//            
//                }
//        
//      
//        .transition(.opacity)
//        
//        .navigationBarTitle("")
//        .navigationBarTitleDisplayMode(.inline)
//        
//        
////        List(0...100, id: \.self){ index in
////            RandomUserRowView()
////        }
//    }
//    
//}
//
//struct APIView_Previews: PreviewProvider {
//    static var previews: some View {
//        APIView()
//    }
//}
