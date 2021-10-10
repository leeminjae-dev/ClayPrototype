//
//  MyPageView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/06.
//

import SwiftUI
import FirebaseStorage

struct MyPageView: View {
    
    @ObservedObject var datas = firebaseData
    @EnvironmentObject var userData : UserData
    let userImageFileName : String = "Diary/\(makeEmailString())/ProfileImage.jpg"
    @State var shownProfileImage : Bool = false
    @Binding var userImageURL : String 
    @AppStorage("userEmail") var userEmail = ""
   
    @State var show : Bool = false
    
    var body: some View {
        GeometryReader{geometry in
            VStack{
                HStack{
                    Text("마이페이지")
                        .font(Font.custom(systemFont, size: 25))
                        .fontWeight(.bold)
                        .padding(.leading, 15)
                        .padding(.top, 15)
                        .padding(.bottom, 45)
                    Spacer()
                    LogoutBtn()
                        .padding(.top, 55)
                        .padding(.trailing, 20)
                        .opacity(show ? 1 : 0)
                        .offset(y: self.show ? 0 : 20)
                        .animation(.easeOut.delay(0.25))
                }

                if userImageURL != ""
                {
                    ZStack{
                        FirebaseProfileImageView(imageURL: userImageURL)
                            .frame(width : 135, height : 135)
                            .clipShape(Circle())
                        
                            
                         
                           
                        Button(action: { self.shownProfileImage.toggle() }) {
                            
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 20, height: 20)
                    
                        }
                        .sheet(isPresented: $shownProfileImage) {
                            
                            ProfileImagePicker(shown: self.$shownProfileImage,imageURL: $userImageURL, isProfile: true)
                                .opacity(show ? 1 : 0)
                                .offset(y: self.show ? 0 : 20)
                                .animation(.easeOut.delay(0.35))
                                
                            }
                            .padding(12)
                            .background(Color.init("systemColor"))
                            .foregroundColor(Color.white)
                            .cornerRadius(9999)
                            .offset(x:50, y:50)
                        
                    }
                    .opacity(show ? 1 : 0)
                    .offset(y: self.show ? 0 : 20)
                    .animation(.easeOut.delay(0.2))
                    
                }else{
                    ZStack{
                        Circle()
                            .foregroundColor(Color.gray.opacity(0.7))
                            .frame(width : 135, height : 135)
                            
                        Image(systemName : "person")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.black)
  
                        Button(action: { self.shownProfileImage.toggle() }) {
                            
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                    
                        }
                        .sheet(isPresented: $shownProfileImage) {
                            
                            ProfileImagePicker(shown: self.$shownProfileImage,imageURL: $userImageURL, isProfile: true)
                                .opacity(show ? 1 : 0)
                                .offset(y: self.show ? 0 : 20)
                                .animation(.easeOut.delay(0.35))
                                
                            }
                            .padding(10)
                            .background(Color.init("systemColor"))
                            .foregroundColor(Color.white)
                            .cornerRadius(9999)
                            .offset(x:50, y:50)
                            
                         
                    }
                    .opacity(show ? 1 : 0)
                    .offset(y: self.show ? 0 : 20)
                    .animation(.easeOut.delay(0.2))
                  
                }
                VStack{
                    Text(datas.dataToDisplay["nickName"]!)
                        .font(Font.custom(systemFont, size: 25))
                        .fontWeight(.bold)
                       
                    Text(userEmail)
                        .font(Font.custom(systemFont, size: 20))
                        
                     
                }
                .opacity(show ? 1 : 0)
                .offset(y: self.show ? 0 : 20)
                .animation(.easeOut.delay(0.35))
                .padding(.bottom, 50)
               
                   
            }
            
        }
        .navigationBarHidden(true)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                show = true
            }
       
            
        }
       
    }
    
    func loadImageFromUserImageFirebase() {
        let storage = Storage.storage().reference(withPath: "Diary/\(makeEmailString())/ProfileImage.jpg")
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("Download success")
            self.userImageURL = "\(url!)"
        }
    }
}


