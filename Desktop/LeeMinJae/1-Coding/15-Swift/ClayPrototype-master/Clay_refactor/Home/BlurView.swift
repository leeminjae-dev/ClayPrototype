//
//  BlurView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/16.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    
    var effect : UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIVisualEffectView{
        
        let blurEffect = UIBlurEffect(style: effect)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<BlurView>) {
        
    }
}

