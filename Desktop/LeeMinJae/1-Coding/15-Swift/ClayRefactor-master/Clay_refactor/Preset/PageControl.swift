//
//  PageControl.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/30.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    
    var maxPages : Int
    var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        
        let control = UIPageControl()
        control.backgroundStyle = .minimal
        control.numberOfPages = maxPages
        control.currentPage = currentPage
       
        control.currentPageIndicatorTintColor = UIColor(Color.init("systemColor"))
        control.pageIndicatorTintColor = UIColor(Color.init("systemColor").opacity(0.4))
       
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        
        uiView.currentPage = currentPage
        
    }
}
