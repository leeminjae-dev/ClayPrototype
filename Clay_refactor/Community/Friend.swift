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
    
    @State var friendEmail : String = ""
    
    var body: some View {
        ZStack{
            
            VStack{
                HStack{
                    TextField("친구의 이메일을 입력하세요", text: $friendEmail)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    Button(action: {
                        userData.friendList.append(self.friendEmail)
                    }, label: {
                        Text("친구 추가")
                    })
                }
                
                List {
                    ForEach(datas.data){ data in
                        HStack {
                            if userData.friendList.contains(data.email!){
                                FriendView(data: data)
                            }
                            
                        }
                    }
                }
            }
        }
        
        
    }
}

struct Friend_Previews: PreviewProvider {
    static var previews: some View {
        Friend()
    }
}
