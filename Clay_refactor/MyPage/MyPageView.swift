//
//  MyPageView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/06.
//

import SwiftUI

struct MyPageView: View {
    @ObservedObject var datas = firebaseData
    @EnvironmentObject var userData : UserData
    var body: some View {
        GeometryReader{geometry in
            VStack{
                if userData.userImageURL != ""
                {
                    FirebaseImageView(imageURL: userData.userImageURL)
                        .clipShape(Circle())
                }else{
    //                ZStack{
    //                    Image(systemName : "person")
    //
    //                        .foregroundColor(Color.black)
    //                        .frame(width: 60, height: 60)
    //                        .multilineTextAlignment(.center)
    //                        .padding(.trailing, 13)
    //
    //                    Circle()
    //                        .foregroundColor(Color.gray.opacity(0.7))
    //                        .frame(width : 55, height : 55)
    //                        .padding(.trailing, 15)
    //                }
                  
                }
                
               
                
                LogoutBtn()
                    .position(x:geometry.size.width/2 ,y: geometry.size.height/2)
            }
            
        }
       
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
