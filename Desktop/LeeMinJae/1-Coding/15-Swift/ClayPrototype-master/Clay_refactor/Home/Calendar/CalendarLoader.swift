import SwiftUI



struct CalendarLoader_Previews: PreviewProvider {
    static var previews: some View {
        CalendarLoader()
    }
}

struct CalendarLoader : View {
    @State var animate = false
    
    @State var appear : Bool = false
    @State var firstUp : Bool = false
    @State var secondUp : Bool = false
    
    var body: some View{
        GeometryReader{ geometry in
        VStack{
            ZStack{
                ZStack{
                    Image("fruit3")
                        .resizable()
                        .scaleEffect(appear ? firstUp ? 0.5 : 1 : 0.5)
                        .offset(y : appear ? firstUp ? -50 : 0 : 50)
                        .opacity( appear ?  firstUp ? 0 : 1 : 0)
                        .animation(.easeInOut.delay(firstUp ? 0.3 : 0.05))
                        .frame(width: 80, height: 80)

//                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    Image("fruit2")
                        .resizable()
                        .scaleEffect(firstUp ? secondUp ? 0.5 : 1 : 0.5)
                        .offset(y : firstUp ? secondUp ? -50 : 0 : 50)
                        .opacity( firstUp ?  secondUp ? 0 : 1 : 0)
                        .animation(.easeInOut.delay(0.3))
                        .frame(width: 80, height: 80)
//                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    
                    Image("fruit1")
                        .resizable()
                        .scaleEffect(secondUp ? 1 : 0.5)
                        .offset(y : secondUp ? 0 : 50)
                        .opacity( secondUp ? 1 : 0)
                        .animation(.easeInOut.delay(0.3))
                        .frame(width: 80, height: 80)
                        
                   
                }
                .zIndex(2)
                
                Rectangle()
                    .frame(width: 150, height: 150, alignment: .center)
                    .foregroundColor(Color.init("shadowWhite"))
                    .cornerRadius(15)
//                    .shadow(radius: 6, x: 3, y: 3)
            }
 
        }
        .padding(.bottom, 70)
        .frame(width: geometry.size.width, height: 900)
        .background(Color.white.opacity(0.7))
        .foregroundColor(.white)
        
        .onAppear{
            self.animate.toggle()
            
            self.appear = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.firstUp = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                self.secondUp = true
            }
        }
        }
    }
}
