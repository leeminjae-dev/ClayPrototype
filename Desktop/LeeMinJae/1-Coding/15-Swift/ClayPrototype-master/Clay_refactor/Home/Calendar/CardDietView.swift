//
//  CardDietView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/22.
//

import SwiftUI
import Kingfisher

struct CardDietView: View {
    
    @State var mealString : String = "아침"
    @Binding var userImageURL : String
    @Binding var foodList : [[String]]
    @Binding var isTabDate : Bool
    @Binding var index : Int
    @Binding var offset : CGFloat 
    @ObservedObject var datas = firebaseData
    
    var body: some View {
        if userImageURL == ""{
            VStack(spacing : 0){
                ZStack{
                    ZStack{
                        Image(systemName: "multiply.circle")
                            
                            .resizable()
                            .frame(width: 180, height: 180)
                            .foregroundColor(Color.init("darkGreen"))
                           
                            .zIndex(2)
                        Rectangle()
                            .frame(width: 280, height: 330)
                            .foregroundColor(Color.white)
                            .aspectRatio(contentMode: .fill)
                            .shadow(color : Color.black.opacity(0.4), radius: 5, x : 1.5 ,y: 6)
                            .zIndex(1)
                    }
                    .offset(y : -50)
                    .zIndex(3)
                        
                       
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                             .frame(width: 320, height: 480, alignment: .center)
                             
                             .shadow(color : .black.opacity(0.2), radius: 12, x : 6 ,y: 15)
                        
                        Text("이 식단은 기록하지 못했어요")
                            .offset(y: 170)
                    }
                 
                }

            }
            .offset(x: offset)
//                                            .rotationEffect(.init(degrees: morningCardOffset == 0 ? 0 : (morningCardOffset > 0 ? 12 : -12)))
            .gesture(
            
                DragGesture()
                    .onChanged({ (value) in
                        
                        withAnimation(.default){
                        
                            offset = value.translation.width
                        }
                    })
                    .onEnded({ (value) in
                        
                        withAnimation(.easeIn){
                        
                            if offset > 100 && index != 1{
                                
                                index-=1
                                offset = 0
                            }
                            else if offset < -100 && index != 3{
                                
                                index+=1
                                offset = 0
                            }
                            else{
                                
                                index = 2
                                offset = 0
                            }
                        }
                    })
            )
            
            
        }else{
            VStack(spacing : 0){
                ZStack{
                    
                    FirebaseImageView(imageURL: userImageURL)
                        .frame(width: 280, height: 330)
                        .aspectRatio(contentMode: .fill)
                        .offset(y : -50)
                        .shadow(color : Color.black.opacity(0.4), radius: 5, x : 5 ,y: 6)
                        .zIndex(1)
                        
                       
                    ZStack{
                        
                        Rectangle()
                             .foregroundColor(.white)
                             .frame(width: 320, height: 480, alignment: .center)
                             
                             .shadow(color : .black.opacity(0.2), radius: 12, x : 6 ,y: 15)
                            
                        List(foodList, id: \.self){food in
  
                            HStack(spacing : 10){
                                   
                                    Text(food[0])
                                        .font(Font.custom(systemFont, size: 15))
                                        .fontWeight(.bold)
       
                                    Spacer()
                                    
                                    Text("\(Float(food[2])!,specifier: "%.0f") Kcal")
                                        .font(Font.custom(systemFont, size: 15))
                                        
                                       
                                    
                                    
                                }

                                .background(Color.white)
                               
                            
                        }
                    
                    
                    .listStyle(PlainListStyle())
                    .frame(width: 295, height: 80)
                    
                    .offset(y: 170)
                    .onAppear{
                        UITableView.appearance().separatorColor = .clear
                        
                        }
                    }
                 
 
                }

            }
            .offset(x: offset)
//                                            .rotationEffect(.init(degrees: morningCardOffset == 0 ? 0 : (morningCardOffset > 0 ? 12 : -12)))
            .gesture(
            
                DragGesture()
                    .onChanged({ (value) in
                        
                        withAnimation(.default){
                        
                            offset = value.translation.width
                        }
                    })
                    .onEnded({ (value) in
                        
                        withAnimation(.easeIn){
                        
                            if offset > 20 && index != 1{
                                
                                index-=1
                                offset = 0
                            }
                            else if offset < -20 && index != 3{
                                
                                index+=1
                                offset = 0
                            }
                            else{
                                
                                index = 2
                                offset = 0
                            }
                        }
                    })
            )
        }
    }
    
}

struct CardDietView_Previews: PreviewProvider {
    
  
    
    static var previews: some View {
        CardDietView(userImageURL: .constant(""), foodList: .constant([["밥", "2", "3"]]), isTabDate: .constant(false), index: .constant(1), offset: .constant(0))
    }
}
