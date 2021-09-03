//
//  LoadingView.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/03.
//

import SwiftUI



struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}

struct Loader : View {
    @State var animate = false
    var body: some View{
        GeometryReader{ geometry in
        VStack{
            Circle()
                
                .trim(from: 0, to: 0.8)
                .stroke(AngularGradient(gradient: .init(colors: [.black.opacity(0.3),.white]), center: .center),style: StrokeStyle(lineWidth : 8, lineCap: .round))
                .frame(width: 45, height: 45)
                .rotationEffect(.init(degrees: self.animate ? 360 : 0))
                .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
           
        }
        .frame(width: geometry.size.width, height: (geometry.size.height/7)*6)
        .onAppear{
            self.animate.toggle()
        }
        }
    }
}


/*struct ContentView: View {
    @State private var hasTimeElapsed = false

    var body: some View {
        Text(hasTimeElapsed ? "Sorry, too late." : "Please enter above.")
            .onAppear(perform: delayText)
    }

    private func delayText() {
        // Delay of 7.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.5) {
            hasTimeElapsed = true
        }
    }
}*/
 
