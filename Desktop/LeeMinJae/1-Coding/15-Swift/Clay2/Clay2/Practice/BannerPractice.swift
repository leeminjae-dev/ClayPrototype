//
//  IntroBanner.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/30.
//
/*
import Foundation
import SwiftUI

struct BannerPractice: View {
    @State var Currentpage = 1
    @State var transitionView : Bool = false
    var body: some View{
        
        ZStack(alignment: .bottom) {
            
            VStack{
                Button("버튼") {
                    transitionView.toggle()
                }
                Spacer()
            }
            
            if transitionView {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: UIScreen.main.bounds.height * 0.5)
                .transition(.slide)
                .animation(.easeIn)
                
            }
        }
         .ignoresSafeArea(edges: .bottom)
       
    }
}



struct BannerPractice_Previews : PreviewProvider{
    static var previews: some View{
        BannerPractice()
    }
}

struct pageControl : UIViewRepresentable {
    
    var current = 0
    
    func makeUIView(context: UIViewRepresentableContext<pageControl>) -> UIPageControl {
        
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = .black
        page.numberOfPages = 3
        page.pageIndicatorTintColor = .gray
        return page
    }
    
    func updateUIView(_ uiView: pageControl.UIViewType, context: UIViewRepresentableContext<pageControl>) {
        
        uiView.currentPage = current
        
    
    }
    
}
*/
