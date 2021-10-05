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
    @EnvironmentObject var viewModel : SignAppViewModel
    @AppStorage("currentPage") var currentPage = 1
    var totalPage = 3
    @State var isLastPage : Bool = false
    init(){
        UINavigationBar.appearance().backgroundColor = UIColor(Color.white)
        UINavigationBar.appearance().barTintColor = UIColor(Color.white)
        UINavigationBar.appearance().shadowImage = UIImage()
        ///UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        ///UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        ///Use this if NavigationBarTitle is with displayMode = .inline
        ///UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        ///
        let control = UIPageControl()
        
        control.currentPageIndicatorTintColor = UIColor(Color.init("systemColor"))
        control.pageIndicatorTintColor = UIColor(Color.init("systemColor").opacity(0.4))
        
    }
    
    var body: some View{
        TabView {
            Image("ServiceIntro1")
                .resizable()
                .padding(.bottom, 20)
                .frame(width: 390, height: 850, alignment: .center)
            Image("ServiceIntro2")
                .resizable()
                .frame(width: 390, height: 850, alignment: .center)
                .padding(.bottom, 20)
            ZStack{
                Image("ServiceIntro3")
                    .resizable()
                    .frame(width: 390, height: 850, alignment: .center)
                    .padding(.bottom, 20)
                Button(action: {
                    currentPage = 4
                }, label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size : 30))
                        .foregroundColor(Color.init("systemColor"))
                        .font(Font.custom(systemFont, size: 20))
                        .frame(width: 60, height: 60, alignment: .center)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 1)
                        .position(x: 330, y: 770)
                })
               
            }
            
                }
        .ignoresSafeArea()
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .navigationBarTitle("")
        .navigationBarHidden(true)
      
        
        
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
