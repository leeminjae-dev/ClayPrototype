//
//  FollowYoutube.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/30.
//

import Foundation
import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct MainSignUp: View {
    
    @State private var selectedTab : Trip = trips[0]
    @EnvironmentObject var viewModel : SignAppViewModel
    
    
    var body: some View{
        
            GeometryReader{proxy in
                //let frame = proxy.frame(in: .global)
                VStack{
                    VStack{
                        
                        TabView(selection : $selectedTab){
                            ForEach(trips){trip in
                                Image(trip.image)
                                    .resizable()
                                    .frame(width: 400, height: 400)
                                    .tag(trip)
                            }
                            
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(width: 400, height: 400)
                        
                        
                        PageControl(maxPages: trips.count, currentPage: getIndex())
                         
                    }
                    .padding([.top, .bottom])
                    
                    NavigationLink(
                       destination: SignUpView(),
                       label: {
                        Text("클레이로 회원가입하기")
                            .foregroundColor(.black)
                            .font(Font.custom(systemFont, size: 15))
                            .fontWeight(.semibold)
                            .frame(width: 300, height: 50, alignment: .center)
                            .background(Color.init("systemColor"))
                            .cornerRadius(5)
                       
                       })
                        .shadow(color: .black, radius: 0.8)
                        .navigationBarTitle("회원가입").font(.headline)
                    
                    Button(action : {
                           //카카오톡이 깔려있는지 확인하는 함수
                           if (UserApi.isKakaoTalkLoginAvailable()) {
                               //카카오톡이 설치되어있다면 카카오톡을 통한 로그인 진행
                               UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                                if let error = error {
                                            print(error)
                                        }
                                        else {
                                            print("loginWithKakaoTalk() success.")
                                            //do something
                                            _ = oauthToken
                                        }
                               }
                           }else{
                               //카카오톡이 설치되어있지 않다면 사파리를 통한 로그인 진행
                               UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                                if let error = error {
                                            print(error)
                                        }
                                        else {
                                            print("loginWithKakaoTalk() success.")
                                            //do something
                                            _ = oauthToken
                                        }
                               }
                           }
                       }){
                           
                        Image("KakaoLogInBtn")
                            .resizable()
                            .frame(width: 300, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .transition(.slide)
                            .shadow(color: .black, radius: 0.8)
                       }
                       //ios가 버전이 올라감에 따라 sceneDelegate를 더이상 사용하지 않게되었다
                       //그래서 로그인을 한후 리턴값을 인식을 하여야하는데 해당 코드를 적어주지않으면 리턴값을 인식되지않는다
                       //swiftUI로 바뀌면서 가장큰 차이점이다.
                       .onOpenURL(perform: { url in
                           if (AuthApi.isKakaoTalkLoginUrl(url)) {
                               _ = AuthController.handleOpenUrl(url: url)
                           }
                       })
                    
                    
                }
                
            }
            .transition(.slide)
        
        
    }
    
    func getIndex()->Int{
        
        let index = trips.firstIndex { (trip) -> Bool in
            return selectedTab.id == trip.id
            
        } ?? 0
        return index
   
    }

}



private var trips = [
    
    Trip(image: "IntroBanner1", title: "banner1"),
    Trip(image: "IntroBanner2", title: "banner2"),
    Trip(image: "IntroBanner3", title: "banner3"),
]

private struct Trip : Identifiable, Hashable{
    
    var id = UUID().uuidString
    var image : String
    var title : String
}


struct MainSignUp_Previews : PreviewProvider{
    static var previews: some View{
        MainSignUp()
    }
}
