//
//  MyTextView.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import SwiftUI

struct MyTextView : View{
    @Binding
    var isActivated: Bool
    
    init(isActivated : Binding<Bool> =
            .constant(true)){
        _isActivated = isActivated
    }
    
    @State
    private var index: Int = 0
    @State var animate = false
    private let backGroundColors = [
        Color.red,
        Color.yellow,
        Color.blue,
        Color.green,
        Color.orange
    ]
    
    var body: some View {
        VStack{
            Spacer()
            Text("배경 인덱스\(index)")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 40))
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Text("\(String(isActivated))")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 40))
                .foregroundColor(self.isActivated ? Color.black : Color.blue)
                                .rotationEffect(.init(degrees: self.animate ? 360 : 0))
            Spacer()
                
        }
        .rotationEffect(.init(degrees: self.animate ? 360 : 0))
        
        .background(backGroundColors[index])
        .onTapGesture {
            
            if(self.index == self.backGroundColors.count-1){
                self.index = 0
            }else{
                self.index += 1
            }
           
            
        }
        
    }
}

struct MyTextView_Previews: PreviewProvider {
    static var previews: some View {
        MyTextView()
    }
}
