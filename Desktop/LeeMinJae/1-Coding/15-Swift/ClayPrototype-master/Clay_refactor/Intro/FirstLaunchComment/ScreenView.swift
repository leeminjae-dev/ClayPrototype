//
//  ScreenView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/05.
//

import SwiftUI

@available(iOS 14.0, *)
struct ScreenView : View{
    
    var image : String
    var title : String
    var detail : String
    var totalPage = 3
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View{
        /// 스크린 뷰
        VStack{
            /// 위 네비게이션 바
                    HStack{
                        if self.currentPage == 1{
                            Text("클레이는 이런 앱이에요.")
                                .font(Font.custom(systemFont, size: 15))
                            }
                        else{
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
struct ScreenView_Previews: PreviewProvider {
    @available(iOS 14.0, *)
    static var previews: some View {
        ScreenView(image: "FirstLanchBanner1", title: "Step1", detail: "어쩌구 저쩌구")
    }
}
