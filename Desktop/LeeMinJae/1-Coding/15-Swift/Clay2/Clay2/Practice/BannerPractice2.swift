//
//  File.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/30.
//
/*
import SwiftUI
struct BannerPractice2: View {

@State var currentPage = 0
@State var direction : Bool = true
var body: some View {
GeometryReader { geo in
    VStack{
        ZStack{
            if self.currentPage == 0{
                if(direction){
                    Image("IntroBanner1").resizable()
                        .frame(height: UIScreen.main.bounds.height*0.5)
                        .transition(.move(edge: .trailing))
                    .animation(.easeIn)
                }else{
                    Image("IntroBanner1").resizable()
                        .frame(height: UIScreen.main.bounds.height*0.5)
                    .transition(.move(edge: .leading))
                        .animation(.easeIn)
                }
            }
            else if self.currentPage == 1{
                if(direction){
                    Image("IntroBanner2").resizable()
                        .frame(height: UIScreen.main.bounds.height*0.5)
                        .transition(.move(edge:.trailing))
                    .animation(.easeIn)
                }else{
                    Image("IntroBanner2").resizable()
                        .frame(height: UIScreen.main.bounds.height*0.5)
                    .transition(.move(edge: .leading))
                    .animation(.easeIn)
                }
                    
            }
            else{
                
                if(direction){
                    Image("IntroBanner3").resizable()
                        .frame(height: UIScreen.main.bounds.height*0.5)
                        .transition(.move(edge: .trailing))
                    .animation(.easeIn)
                }else{
                    Image("IntroBanner3").resizable()
                        .frame(height: UIScreen.main.bounds.height*0.5)
                    .transition(.move(edge:.leading))
                    .animation(.easeIn)
                }
            }
            
        }
        pageControl(current: currentPage)
    }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .gesture(
    DragGesture()
      .onEnded {
        if $0.translation.width < -100 {
          self.currentPage = max(0, self.currentPage + 1)
            self.direction = true
        } else if $0.translation.width > 100 {
          self.currentPage = max(0, self.currentPage - 1)
            self.direction = false
        }
    }
  )
}
}
}

struct PageControl : UIViewRepresentable {

var current = 0

func makeUIView(context: UIViewRepresentableContext<PageControl>) -> UIPageControl {
let page = UIPageControl()
page.numberOfPages = 3
page.currentPageIndicatorTintColor = .black
page.pageIndicatorTintColor = .gray
return page
}

func updateUIView(_ uiView: UIPageControl, context: UIViewRepresentableContext<PageControl>) {
uiView.currentPage = current
}
}


struct BannerPractice2_Previews : PreviewProvider{
    static var previews: some View{
        BannerPractice2()
    }
}*/
