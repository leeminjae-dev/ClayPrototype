//
//  MyVstackView.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import SwiftUI
struct MyVstackView : View {
    
    @Binding
    var isActivated: Bool
    
    init(isActivated : Binding<Bool> =
            .constant(true)){
        _isActivated = isActivated
    }
    
    
    var body: some View{
    
        VStack{
        Text("Hello, world!")
            .padding()
        Text("Hello, world!")
            .padding()
        Text("Hello, world!")
            .padding()
    }
        .background(self.isActivated ? Color.red : Color.green)
        
    }
    
}

