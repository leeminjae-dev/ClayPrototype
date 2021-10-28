//
//  MyPageView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/06.
//

import SwiftUI
import FirebaseStorage
import Kingfisher

struct MyPageView: View {
    
    @ObservedObject var datas = firebaseData
    @EnvironmentObject var userData : UserData
    @StateObject var homeViewModel = HomeViewModel()
   
    @State var shownProfileImage : Bool = false
    
    @Binding var userImageURL : String
    @AppStorage("userEmail") var userEmail = ""
   
    @State var show : Bool = false
    @State var isChangedProfile : Bool = false
    @State var errorMessage : String = "  변경된 프로필 사진은\n앱 재시작 후 적용됩니다."
    
    var body: some View {
        GeometryReader{geometry in
            ZStack{
              
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
                            KFImage(URL(string: userImageURL))
                                .resizable()
                                .frame(width : 110, height : 110)
                                .clipShape(Circle())




                            Button(action: {
                                self.shownProfileImage.toggle()
                               
                            }) {

                                Image(systemName: "pencil")
                                    .resizable()
                                    .frame(width: 15, height: 15)

                            }
                            .sheet(isPresented: $shownProfileImage) {

                                ProfileImagePicker(shown: self.$shownProfileImage,imageURL: $userImageURL, isProfile: true, isChangedProfile: self.$isChangedProfile, userImageURL: $userImageURL)
                                    .opacity(show ? 1 : 0)
                                    .offset(y: self.show ? 0 : 20)
                                    .animation(.easeOut.delay(0.35))

                                }
                                .padding(12)
                                .background(Color.init("systemColor"))
                                .foregroundColor(Color.white)
                                .cornerRadius(9999)
                                .offset(x:40, y:40)

                        }
                        .opacity(show ? 1 : 0)
                        .offset(y: self.show ? 0 : 20)
                        .animation(.easeOut.delay(0.2))

                    }else{
                        ZStack{
                            Circle()
                                .foregroundColor(Color.gray.opacity(0.7))
                                .frame(width : 110, height : 110)
                                
                            Image(systemName : "person")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.black)
      
                            Button(action: {
                                self.shownProfileImage.toggle()
                               
                            }) {
                                
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                        
                            }
                            .sheet(isPresented: $shownProfileImage) {
                                
                                ProfileImagePicker(shown: self.$shownProfileImage,imageURL: $userImageURL, isProfile: true, isChangedProfile: self.$isChangedProfile, userImageURL: $userImageURL)
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
                    VStack(spacing : 10){
                        Text(datas.dataToDisplay["nickName"] ?? "error")
                            .font(Font.custom(systemFont, size: 25))
                            .fontWeight(.bold)
                           
                        Text(userEmail)
                            .font(Font.custom(systemFont, size: 20))
                            
                         
                    }
                    .opacity(show ? 1 : 0)
                    .offset(y: self.show ? 0 : 20)
                    .animation(.easeOut.delay(0.35))
                   
                   
                    Rectangle()
                        .frame(width: 300, height: 400, alignment: .center)
                        .opacity(0)
                }
                
                SuccessAlertView(alert: $isChangedProfile, errorMassage: $errorMessage)
                    
                    .zIndex(1)
            }
            
            
        }
        .navigationBarHidden(true)
        .onAppear{
            
          show = true

        }
       
    }
    
    func loadImageFromUserImageFirebase() {
        let storage = Storage.storage().reference(withPath: DOWNLOAD_PROFILE_FILE_NAME)
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


extension UIImageView {
    func setImage(with urlString: String) {
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString, options: nil) { result in // 캐시에서 키를 통해 이미지를 가져온다.
            switch result {
            case .success(let value):
                if let image = value.image { // 만약 캐시에 이미지가 존재한다면
                    self.image = image // 바로 이미지를 셋한다.
                } else {
                    guard let url = URL(string: urlString) else { return }
                    let resource = ImageResource(downloadURL: url, cacheKey: urlString) // URL로부터 이미지를 다운받고 String 타입의 URL을 캐시키로 지정하고
                    self.kf.setImage(with: resource) // 이미지를 셋한다.
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
