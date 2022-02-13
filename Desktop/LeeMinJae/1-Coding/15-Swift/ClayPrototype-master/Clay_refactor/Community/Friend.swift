//
//  Friend.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/10.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct Friend: View {
    
    @ObservedObject private var datas = firebaseData
    @EnvironmentObject var userData : UserData
    @StateObject var calendarViewModel = CalendarViewModel()
    
    @State var friendEmail : String = ""
    @State var friendList : [String] = []
    @State var userList : [String] = []
    
    @State var notExistFriendError : Bool = false
    @State var errorMessage : String = "존재하지 않는 이메일입니다."
    
    @AppStorage("userEmail") var userEmail = ""
    
    var body: some View {
        ZStack{
            
            ErrorAlertView(alert: $notExistFriendError, errorMassage: $errorMessage)
                .zIndex(2)
            
            VStack{
                HStack{
                    TextField("친구의 이메일을 입력하세요", text: $friendEmail)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    Button(action: {
                        
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            
                            dbCollection.document(friendEmail).getDocument { (document, error) in
                                      if let document = document {

                                          if document.exists{
                                              
                                              datas.createFriendList(email: userEmail, friendEmail: friendEmail, nickName: datas.friendNickName["nickName"] ?? "error")
                                              
                                          } else {
                                              
                                              notExistFriendError.toggle()
                                              
                                              DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                  
                                                  notExistFriendError.toggle()
                                                  
                                              }

                                          }
                                      }
                                  }
                            
                            friendEmail = ""
                            
                        }
                        
                        datas.friendNickNameCall(email: friendEmail)
                        
                    }, label: {
                        
                        Text("친구 추가")
                        
                    })
                }
                
                List {
                    ForEach(datas.friendList, id: \.self) { user in
                        HStack{
                            Text(user[1])
                           
                            NavigationLink(destination: {
                                
                                FriendDetailView(friendEmail: user[0])
                                
                            }, label: {
                                Text("")
                            })
                           
                        }
                        
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(PlainListStyle())
            }
            .padding()
            .padding(.bottom, 40)
        }
        .onAppear{
//            dbCollection.document(userEmail).getDocument { (document, error) in
//                      if let document = document {
//
//                          if document.exists{
//
//                              datas.createFriendList(email: userEmail, friendEmail: friendEmail, nickName: datas.friendNickName["nickName"] ?? "error")
//
//                          } else {
//
//                              notExistFriendError.toggle()
//
//                              DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//
//                                  notExistFriendError.toggle()
//
//                              }
//
//                          }
//                      }
//                  }
            datas.friendListCall(email: userEmail)

            datas.foodTextCall(email: userEmail, data: "morningFoodText", date: makeToday(), meal: "Breakfast")
            datas.foodTextCall(email: userEmail, data: "launchFoodText", date: makeToday(), meal: "Launch")
            datas.foodTextCall(email: userEmail, data: "dinnerFoodText", date: makeToday(), meal: "Dinner")
        }
        
    }
    func delete(at offsets: IndexSet) {
          if let first = offsets.first {
              
              datas.deletefriendList(email: userEmail, friendName: datas.friendList[first][0])
              datas.friendList.remove(at: first)
              
          }
      }
}

struct Friend_Previews: PreviewProvider {
    static var previews: some View {
        Friend()
    }
}
