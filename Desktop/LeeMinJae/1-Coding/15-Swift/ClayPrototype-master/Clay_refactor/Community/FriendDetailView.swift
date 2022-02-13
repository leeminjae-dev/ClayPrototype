//
//  FirendDetailView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/11/02.
//

import SwiftUI

struct FriendDetailView: View {
    
    @ObservedObject private var datas = firebaseData
    @EnvironmentObject var userData : UserData
    @StateObject var calendarViewModel = CalendarViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var friendList : [String] = []
    @State var userList : [String] = []
    

    @State var isTabFriend : Bool = false
    
    @State var index : Int = 1
    
    @State var morningCardOffset : CGFloat = 0
    @State var launchCardOffset : CGFloat = 0
    @State var dinnerCardOffset : CGFloat = 0
    
    @State var friendEmail : String = ""
    
    var body: some View {
        VStack{
                    VStack(spacing : 0){
                    
                    VStack{
                        Text("\(datas.friendNickName["nickName"] ?? "error")님의 오늘")
                        Text(index == 1 ? "아침" : index == 2 ? "점심" : "저녁" )
                            .font(Font.custom(systemFont, size: 28))
                            .fontWeight(.bold)
                       
                    }
                    .padding(.top, 15)
                    .padding(.bottom, 30)
                    .zIndex(1)
                      
                    VStack{
                        ZStack{

                            CardDietView(mealString : "저녁",userImageURL: $calendarViewModel.dinnerImageURL, foodText : "dinnerFoodText", isTabDate : $isTabFriend, index:$index, offset: $dinnerCardOffset)
                                .scaleEffect(index == 3  ? 1 : 0.64)
                                .offset(x: index == 3 ?  0 : getRect().width - 120, y : index == 3 ? 0 : 15 )
                                .opacity(index == 3 ? 1 : 0.6)
                                .zIndex(index == 3  ? 3 : 1)
                               
                            
                            CardDietView(mealString : "점심",userImageURL: $calendarViewModel.launchImageURL, foodText : "launchFoodText", isTabDate: $isTabFriend, index:$index, offset: $launchCardOffset)
                                .scaleEffect(index == 2  ? 1 : 0.64)
                                .offset(x: index == 2 ? 0 : index < 2 ? getRect().width - 120 : getRect().width - 660 , y : index == 2 ? 0 : 15 )
                                .zIndex(index == 2  ? 3 : 2)
                                .opacity(index == 2 ? 1 : 0.6)
                              
                            CardDietView(mealString : "아침",userImageURL: $calendarViewModel.morningImageURL,foodText : "morningFoodText", isTabDate: $isTabFriend, index:$index, offset: $morningCardOffset)
                                .scaleEffect(index == 1 ? 1 : 0.64)
                                .offset(x: index == 1 ?  0 : getRect().width - 660, y : index == 1 ? 0 : 15 )
                                
                                .zIndex(index == 1  ? 3 : 1)
                                .opacity(index == 1 ? 1 : 0.6)
                               
                            
                        }
                        .padding(.bottom , 40)
                    }
                    
                    
                

                    HStack{
                        
                           Button(action: {
                            withAnimation(.spring()){
                                
                                isTabFriend = false
//                                        isLoadingEnd = false
                                calendarViewModel.morningImageURL = ""
                                calendarViewModel.launchImageURL = ""
                                calendarViewModel.dinnerImageURL = ""
                                
                                morningCardOffset = 0
                                launchCardOffset = 0
                                dinnerCardOffset = 0
                                
                                index = 1
                                
                                presentationMode.wrappedValue.dismiss()
                                
                              
                            }
                            
                            
                        }, label: {
                            ZStack{
                                Image(systemName: "arrow.uturn.left")
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .foregroundColor(.white)
                                    .zIndex(2)
                                Circle()
                                    .frame(width: 70, height: 70, alignment: .center)
                                   
                                    .foregroundColor(Color.init("darkGreen"))
                                    .shadow(radius: 6, x: 2, y: 2)
                            }
                          
                        })
                     
                    }
                    .padding(.horizontal, 30)
                   
                    
                }
               

        }
        .padding(.bottom, 50)
        .zIndex(2)
        .onAppear{
            calendarViewModel.loadImageFromFirebase(path: "Diary/\(friendEmail)/\(makeCurrentDate())/Breakfast.jpg", meal : "morning")
            calendarViewModel.loadImageFromFirebase(path: "Diary/\(friendEmail)/\(makeCurrentDate())/Launch.jpg", meal : "launch")
            calendarViewModel.loadImageFromFirebase(path: "Diary/\(friendEmail)/\(makeCurrentDate())/Dinner.jpg", meal : "dinner")
            
            datas.friendNickNameCall(email: friendEmail)
        }
    }
    
    func makeCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMM dd"
        return formatter.string(from: date)
    }
}

struct FriendDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetailView()
    }
}
