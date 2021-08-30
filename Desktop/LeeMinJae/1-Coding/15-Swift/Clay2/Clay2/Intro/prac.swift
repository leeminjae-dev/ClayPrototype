//
//  File.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/30.
//
/*
import SwiftUI
struct prac: View {

  @State var currentPage = 0

  var body: some View {
    GeometryReader { geo in
        VStack{
            
            ZStack{
                if self.currentPage == 0{
                    Image("IntroBanner1").resizable().frame(height: 350)
                        .transition(.move(edge: .leading))
                        .animation(.easeOut)
                }
                else if self.currentPage == 1{
                    Image("IntroBanner2").resizable().frame(height: 350)
                        .transition(.slide)
                        .animation(.easeOut)
                }
                else{
                    Image("IntroBanner3").resizable().frame(height: 350)
                        .transition(.slide)
                        .animation(.easeOut)
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
            } else if $0.translation.width > 100 {
              self.currentPage = min(6, self.currentPage - 1)
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
    page.numberOfPages = 7
    page.currentPageIndicatorTintColor = .black
    page.pageIndicatorTintColor = .gray
    return page
  }

  func updateUIView(_ uiView: UIPageControl, context: UIViewRepresentableContext<PageControl>) {
    uiView.currentPage = current
  }
}


struct File_Previews : PreviewProvider{
    static var previews: some View{
        File()
    }
}*/
