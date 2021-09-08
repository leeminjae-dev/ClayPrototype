//
//  FirstLaunchView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/05.
//

import SwiftUI
struct FirstLaunchView_Previews: PreviewProvider {
    
    static var previews: some View {
        if #available(iOS 14.0, *) {
            FirstLaunchView()
        } else {
            // Fallback on earlier versions
        }
    }
}


struct Home : View{
    var body: some View{
        Text("Home")
    }
}



struct FirstLaunchView : View{

    @AppStorage("currentPage") var currentPage = 1
    var totalPage = 3
    
    var body: some View{
        ZStack{
            
            if self.currentPage == 1{
                ScreenView(image: "FirstLaunchBanner1", title: "Step 1",detail: "클레이는 어떤 앱이에요 어쩌구 저쩌구 어떻게 하면 다이어트를 성공하게 해줄 수 있다 같은 설명이 들어가는 자리입니다.")
                    .transition(.scale)
            }
            if self.currentPage == 2{
                ScreenView(image: "FirstLaunchBanner2", title: "Step 2",detail: "클레이는 어떤 앱이에요 어쩌구 저쩌구 어떻게 하면 다이어트를 성공하게 해줄 수 있다 같은 설명이 들어가는 자리입니다.")
                    .transition(.scale)
            }
            if self.currentPage == 3{
                ScreenView(image: "FirstLaunchBanner3", title: "Step 3",detail: "클레이는 어떤 앱이에요 어쩌구 저쩌구 어떻게 하면 다이어트를 성공하게 해줄 수 있다 같은 설명이 들어가는 자리입니다.")
                    .transition(.scale)
            }
            
           
            
            }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .overlay(
            // 다음페이지 넘기기 버튼
            Button(action: {
                    withAnimation(.easeOut){
                        if self.currentPage <= self.totalPage{
                            self.currentPage += 1
                }else{
                    self.currentPage = 1
                }
                
            }}, label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.black)
                    .font(Font.custom(systemFont, size: 20))
                    .frame(width: 60, height: 60, alignment: .center)
                    .background(Color.init("systemColor"))
                    .clipShape(Circle())
                    
                    .overlay(
                        ZStack{
                            Circle()
                                .stroke(Color.black.opacity(0.04), lineWidth: 4)
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage)/CGFloat(totalPage))
                                .stroke(Color.init("systemColor"), lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-15)
                    )
            })
            .padding(.bottom,30)
            ,alignment : .bottom
            
        )
        }
    }


struct ScreenView : View{
    
    var image : String
    var title : String
    var detail : String
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View{
        /// 스크린 뷰
        VStack{
            /// 위 네비게이션 바
            HStack{
                if self.currentPage == 1{
                    Text("클레이는 이런 앱이에요.")
                        .font(Font.custom(systemFont, size: 15))
                    }else{
                    Button(action: {
                        withAnimation(.easeInOut){
                            self.currentPage -= 1
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(Font.custom(systemFont, size: 20))
                        
                    })
                        
                    }
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut){
                        self.currentPage = 4
                    }
                }, label: {
                    Text("Skip")
                        .font(Font.custom(systemFont, size: 18))
                        .foregroundColor(.blue)
                        })
            }
            .padding(25)
            VStack(spacing : 10){
                Image(image)
                    .resizable()
                    .frame(width: 400, height: 400, alignment: .center)
                    
                Text(title)
                    .fontWeight(.bold)
                
                Text(detail)
                    .font(Font.custom(systemFont, size: 15))
                    .multilineTextAlignment(.center)
                    .padding(.top)
                    .padding([.leading,.trailing])
                    
                Spacer()
            }
            
        }
        .background(Color.white)
        
    }
}
